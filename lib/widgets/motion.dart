import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';

// ─── Scroll scope ────────────────────────────────────────────────────────────

/// Hands the page's scroll position to anything that wants to move with it,
/// without rebuilding the whole page on every tick.
class ScrollScope extends InheritedWidget {
  final ValueListenable<double> offset;
  const ScrollScope({super.key, required this.offset, required super.child});

  static ValueListenable<double>? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ScrollScope>()?.offset;

  @override
  bool updateShouldNotify(ScrollScope old) => old.offset != offset;
}

/// Drifts its child as the page scrolls. `factor` is how far it moves for each
/// pixel the viewport travels past it; positive drifts down, negative up.
class ParallaxShift extends StatelessWidget {
  final Widget child;
  final double factor;
  const ParallaxShift({super.key, required this.child, this.factor = 0.08});

  @override
  Widget build(BuildContext context) {
    final offset = ScrollScope.of(context);
    if (offset == null) return child;
    return ValueListenableBuilder<double>(
      valueListenable: offset,
      builder: (context, _, child) {
        double dy = 0;
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize && box.attached) {
          final top = box.localToGlobal(Offset.zero).dy;
          final vh = MediaQuery.of(context).size.height;
          // 0 when the element enters at the bottom, 1 when it leaves at the top.
          final progress = ((vh - top) / (vh + box.size.height)).clamp(-1.0, 2.0);
          dy = (progress - 0.5) * vh * factor;
        }
        return Transform.translate(offset: Offset(0, dy), child: child);
      },
      child: child,
    );
  }
}

// ─── Reveal on scroll ────────────────────────────────────────────────────────

/// Fades and slides its child in the first time it scrolls into view.
/// `index` staggers siblings; `from` is the slide direction as a fraction.
class Reveal extends StatefulWidget {
  final Widget child;
  final int index;
  final Offset from;
  final double scaleFrom;
  final Duration duration;
  final Duration stagger;
  final double threshold;

  const Reveal({
    super.key,
    required this.child,
    this.index = 0,
    this.from = const Offset(0, 0.10),
    this.scaleFrom = 1,
    this.duration = const Duration(milliseconds: 700),
    this.stagger = const Duration(milliseconds: 90),
    this.threshold = 0.12,
  });

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: widget.duration);
  late final Animation<double> _fade =
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  late final Animation<Offset> _slide = Tween(begin: widget.from, end: Offset.zero)
      .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  late final Animation<double> _scale = Tween(begin: widget.scaleFrom, end: 1.0)
      .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  late final Key _key = Key('reveal-${identityHashCode(this)}');
  bool _shown = false;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (_shown || info.visibleFraction < widget.threshold) return;
        _shown = true;
        Future.delayed(widget.stagger * widget.index, () {
          if (mounted) _ctrl.forward();
        });
      },
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: widget.scaleFrom == 1
              ? widget.child
              : ScaleTransition(scale: _scale, child: widget.child),
        ),
      ),
    );
  }
}

/// Reports how far a block has scrolled through the viewport, 0 to 1, so a
/// line can draw itself or a bar can fill as the reader moves down.
class ScrollProgress extends StatelessWidget {
  final Widget Function(BuildContext, double progress) builder;
  final double start; // viewport fraction where progress begins (1 = bottom)
  final double end; // viewport fraction where it completes (0 = top)
  const ScrollProgress(
      {super.key, required this.builder, this.start = 0.85, this.end = 0.35});

  @override
  Widget build(BuildContext context) {
    final offset = ScrollScope.of(context);
    if (offset == null) return builder(context, 1);
    return ValueListenableBuilder<double>(
      valueListenable: offset,
      builder: (context, _, __) {
        double p = 0;
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize && box.attached) {
          final vh = MediaQuery.of(context).size.height;
          final top = box.localToGlobal(Offset.zero).dy;
          final bottom = top + box.size.height;
          // The line is complete once the block's foot passes `end` of the view.
          final a = vh * start;
          final b = vh * end;
          p = ((a - top) / ((bottom - top) + (a - b))).clamp(0.0, 1.0);
        }
        return builder(context, p);
      },
    );
  }
}

// ─── Count-up number ─────────────────────────────────────────────────────────

class CountUp extends StatefulWidget {
  final int end;
  final String suffix;
  final TextStyle style;
  const CountUp({super.key, required this.end, this.suffix = '', required this.style});

  @override
  State<CountUp> createState() => _CountUpState();
}

class _CountUpState extends State<CountUp> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
  late final Animation<double> _anim =
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
  late final Key _key = Key('count-${identityHashCode(this)}');
  bool _started = false;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (i) {
        if (!_started && i.visibleFraction > 0.3) {
          _started = true;
          _ctrl.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) => Text(
          '${(_anim.value * widget.end).round()}${widget.suffix}',
          style: widget.style,
        ),
      ),
    );
  }
}

// ─── Section furniture ───────────────────────────────────────────────────────

/// Eyebrow ("01 — About") and a title with one accent phrase in italic serif.
class SectionHeading extends StatelessWidget {
  final String number;
  final String label;
  final String title;
  final String accent;
  final bool center;
  final Color color;
  final Color accentColor;
  final Color eyebrowColor;

  const SectionHeading({
    super.key,
    required this.number,
    required this.label,
    required this.title,
    required this.accent,
    this.center = false,
    this.color = AppTheme.textBlack,
    this.accentColor = AppTheme.mint,
    this.eyebrowColor = AppTheme.textLight,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final size = (w * 0.038).clamp(34.0, 56.0);
    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Reveal(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppTheme.mint),
              ),
              const SizedBox(width: 10),
              Text('$number  —  ${label.toUpperCase()}',
                  style: AppTheme.eyebrow(color: eyebrowColor)),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Reveal(
          index: 1,
          child: RichText(
            textAlign: center ? TextAlign.center : TextAlign.start,
            text: TextSpan(
              style: AppTheme.display(size, color: color),
              children: [
                TextSpan(text: '$title '),
                TextSpan(
                    text: accent,
                    style: AppTheme.displayAccent(size, color: accentColor)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A soft radial glow, for placing behind content.
class Glow extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;
  const Glow({super.key, required this.size, required this.color, this.opacity = 0.55});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [
            color.withValues(alpha: opacity),
            color.withValues(alpha: 0),
          ]),
        ),
      ),
    );
  }
}

/// Full-width band with centred, width-limited content and optional glows.
class SectionShell extends StatelessWidget {
  final Widget child;
  final Color color;
  final List<Widget> backdrop;
  final double maxWidth;
  final EdgeInsets? padding;

  const SectionShell({
    super.key,
    required this.child,
    this.color = Colors.transparent,
    this.backdrop = const [],
    this.maxWidth = 1180,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 768;
    return Container(
      width: double.infinity,
      color: color,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...backdrop,
          Padding(
            padding: padding ??
                EdgeInsets.symmetric(
                    horizontal: isNarrow ? 22 : 64,
                    vertical: isNarrow ? 72 : 112),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A rounded tag.
class Pill extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? fill;
  const Pill(this.label, {super.key, this.color, this.fill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: fill ?? AppTheme.bgWhite,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppTheme.border),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color ?? AppTheme.textDark,
        ),
      ),
    );
  }
}

/// A hover-lifting card.
class LiftCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final Color? hoverColor;
  final double radius;
  final VoidCallback? onTap;
  const LiftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(28),
    this.color = AppTheme.bgWhite,
    this.hoverColor,
    this.radius = 22,
    this.onTap,
  });

  @override
  State<LiftCard> createState() => _LiftCardState();
}

class _LiftCardState extends State<LiftCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: _hovered ? (widget.hoverColor ?? widget.color) : widget.color,
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(
                color: _hovered ? AppTheme.borderDark : AppTheme.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hovered ? 0.08 : 0.03),
                blurRadius: _hovered ? 28 : 14,
                offset: Offset(0, _hovered ? 14 : 6),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
