import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';

/// The opening screen: portrait in a soft arch, name set large beneath it,
/// social links down the side and a strip of the systems I have built.
class HeroSection extends StatelessWidget {
  final VoidCallback onScrollDown;
  final VoidCallback? onProjects;
  final VoidCallback? onContact;

  const HeroSection({
    super.key,
    required this.onScrollDown,
    this.onProjects,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 768;
    return isNarrow
        ? _NarrowHero(
            onProjects: onProjects ?? onScrollDown,
            onContact: onContact ?? onScrollDown,
          )
        : _WideHero(
            onScrollDown: onScrollDown,
            onProjects: onProjects ?? onScrollDown,
            onContact: onContact ?? onScrollDown,
          );
  }
}

// ─── Palette for this screen ─────────────────────────────────────────────────

const _kLine = Color(0xFF3FA47F); // the looping accent line
const _kArchTop = Color(0xFFC9D2D7);
const _kArchBottom = Color(0xFFF4F5F3);
const _kBg = Color(0xFFF7F7F4);

const _kTitle = 'AI AUTOMATION ENGINEER  //  BUSINESS SYSTEMS ENGINEER';

class _Social {
  final String label;
  final String url;
  final IconData? icon;
  final String? glyph;
  const _Social(this.label, this.url, {this.icon, this.glyph});
}

const _socials = [
  _Social('LinkedIn', 'https://www.linkedin.com/in/kjtabinas/', glyph: 'in'),
  _Social('GitHub', 'https://github.com/lestify12', icon: Icons.code_rounded),
  _Social('Facebook', 'https://www.facebook.com/kjtabinas', glyph: 'f'),
  _Social('Email', 'mailto:${PortfolioData.email}',
      icon: Icons.mail_outline_rounded),
];

class _Logo {
  final String asset;
  final String name;
  final double height; // relative weight; wordmarks run wider than marks
  const _Logo(this.asset, this.name, this.height);
}

const _logos = [
  _Logo('assets/images/logos/fleeto.png', 'Fleeto', 1.0),
  _Logo('assets/images/logos/luxe_pm.png', 'Luxe PM', 1.0),
  _Logo('assets/images/logos/hris.png', 'Luxe HRIS', 1.0),
];

// ─── Wide layout ─────────────────────────────────────────────────────────────

class _WideHero extends StatelessWidget {
  final VoidCallback onScrollDown;
  final VoidCallback onProjects;
  final VoidCallback onContact;
  const _WideHero({
    required this.onScrollDown,
    required this.onProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = math.max(size.height, 760.0);

    const stripH = 112.0;
    final stage = h - stripH; // everything above the logo strip

    final nameSize = (w * 0.078).clamp(44.0, 108.0);

    // The arch is sized by width, but never so tall that the name and title
    // beneath it run into the strip on a short window.
    final archTop = stage * 0.15;
    final textBlock = nameSize * 1.1 + 70; // name, gap, title line
    final maxArchH = stage - archTop - textBlock - 36;
    final archW = math.min((w * 0.30).clamp(300.0, 520.0), maxArchH / 1.02)
        .clamp(200.0, 520.0);
    final archH = archW * 1.02;
    final archLeft = (w - archW) / 2;

    return SizedBox(
      width: double.infinity,
      height: h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background: soft glows and faint arches.
          Positioned.fill(
            child: CustomPaint(painter: _BackdropPainter()),
          ),

          // Social links, down the left.
          Positioned(
            left: w * 0.12,
            top: archTop + archH * 0.30,
            child: Column(
              children: [
                for (final s in _socials) ...[
                  _SocialDot(s),
                  const SizedBox(height: 22),
                ],
              ],
            ).animate().fadeIn(delay: 700.ms, duration: 600.ms),
          ),

          // Available pill, top-left.
          Positioned(
            left: w * 0.06,
            top: stage * 0.13,
            child: const _AvailableBadge()
                .animate()
                .fadeIn(delay: 900.ms, duration: 600.ms),
          ),

          // Portrait in its arch.
          Positioned(
            left: archLeft,
            top: archTop,
            child: _Portrait(
              archW: archW,
              archH: archH,
              onContact: onContact,
            ),
          ),

          // Name and title under the arch.
          Positioned(
            top: archTop + archH + 6,
            left: 0,
            right: 0,
            child: Column(
              children: [
                _FadedName(fontSize: nameSize)
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 800.ms)
                    .slideY(begin: 0.12, end: 0, delay: 300.ms),
                const SizedBox(height: 10),
                Text(
                  _kTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: (w * 0.0135).clamp(13.0, 19.0),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.6,
                    color: const Color(0xFF4A4A4A),
                  ),
                ).animate().fadeIn(delay: 600.ms, duration: 700.ms),
              ],
            ),
          ),

          // Scroll hint, tucked right above the strip.
          Positioned(
            bottom: stripH + 10,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: onScrollDown,
                child: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppTheme.textLight, size: 22)
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(
                        begin: 0,
                        end: 5,
                        duration: 1200.ms,
                        curve: Curves.easeInOut),
              ),
            ),
          ),

          // The systems strip.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: stripH,
            child: _LogoStrip(onTap: onProjects, logoHeight: 34)
                .animate()
                .fadeIn(delay: 900.ms, duration: 800.ms),
          ),
        ],
      ),
    );
  }
}

// ─── Narrow layout ────────────────────────────────────────────────────────────

class _NarrowHero extends StatelessWidget {
  final VoidCallback onProjects;
  final VoidCallback onContact;
  const _NarrowHero({required this.onProjects, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final archW = (w * 0.68).clamp(220.0, 320.0);
    final archH = archW * 1.02;

    return Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: _BackdropPainter())),
        Column(
          children: [
            const SizedBox(height: 96),
            const _AvailableBadge().animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 28),
            SizedBox(
              width: archW + 60, // room for the badge beside the arch
              height: archH + 24,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    top: 24,
                    child: _Portrait(
                      archW: archW,
                      archH: archH,
                      onContact: onContact,
                      compact: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _FadedName(fontSize: (w * 0.115).clamp(34.0, 48.0), twoLines: true)
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 700.ms),
                  const SizedBox(height: 10),
                  Text(
                    'AI AUTOMATION ENGINEER\nBUSINESS SYSTEMS ENGINEER',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      letterSpacing: 1.4,
                      height: 1.7,
                      color: const Color(0xFF4A4A4A),
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final s in _socials) ...[
                  _SocialDot(s),
                  const SizedBox(width: 18),
                ],
              ],
            ).animate().fadeIn(delay: 600.ms),
            const SizedBox(height: 36),
            _LogoStrip(onTap: onProjects, logoHeight: 26, wrap: true)
                .animate()
                .fadeIn(delay: 700.ms),
          ],
        ),
      ],
    );
  }
}

// ─── Portrait: arch, photo, loop line, talk badge ────────────────────────────

class _Portrait extends StatelessWidget {
  final double archW;
  final double archH;
  final VoidCallback onContact;
  final bool compact;
  const _Portrait({
    required this.archW,
    required this.archH,
    required this.onContact,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    // The photo stands taller than the arch so the head rises above it.
    final photoH = archH * 1.16;
    final badge = compact ? 86.0 : 118.0;

    return SizedBox(
      width: archW,
      height: archH,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // The arch itself.
          Container(
            width: archW,
            height: archH,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(archW / 2)),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_kArchTop, _kArchBottom],
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 700.ms)
              .scale(
                  begin: const Offset(0.96, 0.96),
                  end: const Offset(1, 1),
                  duration: 700.ms),

          // The photo: black and white, fading out at the hem, clipped only at
          // the arch's foot so the head can overflow the top.
          Positioned(
            bottom: 0,
            child: ClipRect(
              clipper: _BelowClipper(extraTop: photoH),
              child: SizedBox(
                height: photoH,
                width: archW,
                child: ShaderMask(
                  shaderCallback: (r) => const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.78, 1.0],
                    colors: [Colors.black, Colors.black, Colors.transparent],
                  ).createShader(r),
                  blendMode: BlendMode.dstIn,
                  child: ColorFiltered(
                    // Identity: the portrait keeps its colour.
                    colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.dst),
                    child: Image.asset(
                      'assets/images/me.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                      errorBuilder: (_, __, ___) => Center(
                        child: Text(
                          'KJT',
                          style: GoogleFonts.poppins(
                            fontSize: 64,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 200.ms, duration: 900.ms)
                .slideY(begin: 0.04, end: 0, delay: 200.ms, duration: 900.ms),
          ),

          // The green line that loops the portrait and runs off to the badge.
          Positioned(
            left: -archW * 0.22,
            right: -archW * 0.30,
            top: -archH * 0.12,
            bottom: -archH * 0.04,
            child: IgnorePointer(
              child: CustomPaint(painter: _LoopPainter()),
            ),
          ).animate().fadeIn(delay: 600.ms, duration: 900.ms),

          // "Let's talk" ring at the arch's shoulder.
          Positioned(
            right: -badge * 0.55,
            top: -badge * 0.18,
            child: _TalkBadge(size: badge, onTap: onContact)
                .animate()
                .fadeIn(delay: 800.ms, duration: 600.ms)
                .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    delay: 800.ms,
                    curve: Curves.easeOutBack),
          ),
        ],
      ),
    );
  }
}

/// Clips nothing above the box (so the head can rise past the arch) and
/// everything below it.
class _BelowClipper extends CustomClipper<Rect> {
  final double extraTop;
  const _BelowClipper({required this.extraTop});
  @override
  Rect getClip(Size size) =>
      Rect.fromLTRB(-size.width, -extraTop, size.width * 2, size.height);
  @override
  bool shouldReclip(covariant _BelowClipper old) => old.extraTop != extraTop;
}

class _LoopPainter extends CustomPainter {
  // Ellipse the line travels on: angle 0 is the right-hand point, angles
  // decrease as the line moves from the left, down across the front of the
  // body, out to the right, round the back and across the front once more.
  static Offset _on(double w, double h, double t) {
    const cx = 0.47, cy = 0.68, tilt = -0.12;
    final a = math.pi * 0.95 - t * math.pi * 2.95; // 1.5 turns, minus a little
    final rx = w * (0.40 - 0.07 * t);
    final ry = h * (0.115 - 0.03 * t);
    final x = math.cos(a) * rx;
    final y = math.sin(a) * ry;
    return Offset(
      w * cx + x * math.cos(tilt) - y * math.sin(tilt),
      h * cy + x * math.sin(tilt) + y * math.cos(tilt),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kLine
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
    final path = Path();

    // A small curl to start from, just left of where the sweep begins.
    final first = _on(w, h, 0);
    final c0 = Offset(first.dx - w * 0.035, first.dy + h * 0.035);
    final r0x = w * 0.04, r0y = h * 0.032;
    path.moveTo(c0.dx + r0x, c0.dy);
    for (var i = 1; i <= 48; i++) {
      final a = i / 48 * math.pi * 1.75;
      path.lineTo(c0.dx + math.cos(a) * r0x, c0.dy - math.sin(a) * r0y);
    }
    path.lineTo(first.dx, first.dy);

    for (var i = 1; i <= 220; i++) {
      final p = _on(w, h, i / 220);
      path.lineTo(p.dx, p.dy);
    }

    // Away from the right-hand point, up the outside of the arch, to the badge.
    final last = _on(w, h, 1);
    path.cubicTo(
      last.dx + w * 0.10, last.dy - h * 0.06,
      w * 0.92, h * 0.42,
      w * 0.79, h * 0.25,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ─── Talk badge: text set round a ring, slowly turning ───────────────────────

class _TalkBadge extends StatefulWidget {
  final double size;
  final VoidCallback onTap;
  const _TalkBadge({required this.size, required this.onTap});
  @override
  State<_TalkBadge> createState() => _TalkBadgeState();
}

class _TalkBadgeState extends State<_TalkBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: SizedBox(
          width: s,
          height: s,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(s, s),
                painter: _RingTextPainter(
                  text: "OPEN TO WORK  ·  LET'S TALK  ·  ",
                  radius: s * 0.44,
                  style: GoogleFonts.poppins(
                    fontSize: s * 0.105,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: AppTheme.textBlack,
                  ),
                ),
              )
                  .animate(onPlay: (c) => c.repeat())
                  .rotate(duration: 16.seconds, curve: Curves.linear),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: s * 0.5,
                height: s * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: _hovered
                        ? _kLine
                        : const Color(0xFFCBE7DC),
                    width: s * 0.075,
                  ),
                ),
                child: Icon(Icons.arrow_outward_rounded,
                    size: s * 0.17,
                    color: _hovered ? _kLine : const Color(0xFF9AB8AC)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingTextPainter extends CustomPainter {
  final String text;
  final double radius;
  final TextStyle style;
  _RingTextPainter(
      {required this.text, required this.radius, required this.style});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Measure every glyph so the ring is evenly spaced for any font.
    final painters = text.characters.map((ch) {
      final tp = TextPainter(
        text: TextSpan(text: ch, style: style),
        textDirection: TextDirection.ltr,
      )..layout();
      return tp;
    }).toList();
    final total = painters.fold<double>(0, (s, p) => s + p.width);
    final circumference = 2 * math.pi * radius;
    final gap = (circumference - total) / painters.length;

    var angle = -math.pi / 2;
    for (final tp in painters) {
      final half = (tp.width + gap) / 2;
      angle += half / radius;
      canvas.save();
      canvas.translate(center.dx + math.cos(angle) * radius,
          center.dy + math.sin(angle) * radius);
      canvas.rotate(angle + math.pi / 2);
      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
      angle += half / radius;
    }
  }

  @override
  bool shouldRepaint(covariant _RingTextPainter old) =>
      old.text != text || old.radius != radius || old.style != style;
}

// ─── Backdrop ────────────────────────────────────────────────────────────────

class _BackdropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(Offset.zero & size, Paint()..color = _kBg);

    void glow(Offset c, double r, Color color) {
      canvas.drawCircle(
        c,
        r,
        Paint()
          ..shader = RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ).createShader(Rect.fromCircle(center: c, radius: r)),
      );
    }

    glow(Offset(w * 0.10, h * 0.36), w * 0.26,
        const Color(0xFFFFC7C7).withValues(alpha: 0.60));
    glow(Offset(w * 0.86, h * 0.70), w * 0.24,
        const Color(0xFFE4CBFF).withValues(alpha: 0.60));
    glow(Offset(w * 0.52, h * 0.98), w * 0.34,
        const Color(0xFFCDEBDF).withValues(alpha: 0.55));

    // Two faint arch outlines, bottom-left and top-right.
    final line = Paint()
      ..color = const Color(0xFFD5DBD8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final aw = (w * 0.16).clamp(120.0, 260.0);
    final bl = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.02, h * 0.58, aw, h * 0.6),
      topLeft: Radius.circular(aw / 2),
      topRight: Radius.circular(aw / 2),
    );
    canvas.drawRRect(bl, line);

    final tr = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.86, -h * 0.25, aw * 1.1, h * 0.58),
      bottomLeft: Radius.circular(aw * 0.55),
      bottomRight: Radius.circular(aw * 0.55),
    );
    canvas.drawRRect(tr, line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ─── Name with the trailing letters fading out ───────────────────────────────

class _FadedName extends StatelessWidget {
  final double fontSize;
  final bool twoLines;
  const _FadedName({required this.fontSize, this.twoLines = false});

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      letterSpacing: fontSize * -0.035,
      height: 1.0,
      color: AppTheme.textBlack,
    );
    Widget faded(String text) => ShaderMask(
          shaderCallback: (r) => const LinearGradient(
            stops: [0.0, 0.78, 1.0],
            colors: [Colors.black, Colors.black, Color(0xFFB5B5B5)],
          ).createShader(r),
          blendMode: BlendMode.srcIn,
          child: Text(text, textAlign: TextAlign.center, style: style),
        );
    if (!twoLines) return faded('Krystler John Tabinas');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Krystler John', textAlign: TextAlign.center, style: style),
        faded('Tabinas'),
      ],
    );
  }
}

// ─── Small pieces ────────────────────────────────────────────────────────────

class _SocialDot extends StatefulWidget {
  final _Social social;
  const _SocialDot(this.social);
  @override
  State<_SocialDot> createState() => _SocialDotState();
}

class _SocialDotState extends State<_SocialDot> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.social;
    final color = _hovered ? AppTheme.textBlack : const Color(0xFF6B6B6B);
    return Tooltip(
      message: s.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(s.url),
              mode: LaunchMode.externalApplication),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 36,
            height: 36,
            transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
            child: Center(
              child: s.icon != null
                  ? Icon(s.icon, size: 18, color: color)
                  : Text(
                      s.glyph!,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: color,
                        height: 1,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AvailableBadge extends StatelessWidget {
  const _AvailableBadge();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppTheme.accentGreen),
        )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.35, 1.35),
                duration: 1100.ms,
                curve: Curves.easeInOut),
        const SizedBox(width: 10),
        Text(
          'AVAILABLE FOR NEW OPPORTUNITIES',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}

// ─── The systems strip: a slow ticker of the systems I have built ─────────

class _LogoStrip extends StatefulWidget {
  final VoidCallback onTap;
  final double logoHeight;
  final bool wrap; // kept for call sites; the strip always runs
  const _LogoStrip(
      {required this.onTap, required this.logoHeight, this.wrap = false});

  @override
  State<_LogoStrip> createState() => _LogoStripState();
}

class _LogoStripState extends State<_LogoStrip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: const Duration(seconds: 28))
        ..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      for (final l in _logos)
        Padding(
          padding: EdgeInsets.only(right: widget.logoHeight * 2.2),
          child: _LogoTile(
              logo: l, height: widget.logoHeight * l.height, onTap: widget.onTap),
        ),
    ];
    final doubled = [...items, ...items];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: widget.wrap ? 26 : 0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        border: const Border(top: BorderSide(color: Color(0xFFE6EAE7))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'SYSTEMS I HAVE BUILT',
            style: GoogleFonts.inter(
              fontSize: 10,
              letterSpacing: 2.4,
              fontWeight: FontWeight.w600,
              color: AppTheme.textLight,
            ),
          ),
          const SizedBox(height: 16),
          MouseRegion(
            onEnter: (_) => _ctrl.stop(),
            onExit: (_) => _ctrl.repeat(),
            child: SizedBox(
              height: widget.logoHeight * 1.5,
              child: ClipRect(
                child: ShaderMask(
                  shaderCallback: (r) => const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black,
                      Colors.black,
                      Colors.transparent
                    ],
                    stops: [0, 0.08, 0.92, 1],
                  ).createShader(r),
                  blendMode: BlendMode.dstIn,
                  child: AnimatedBuilder(
                    animation: _ctrl,
                    builder: (_, __) => OverflowBox(
                      alignment: Alignment.centerLeft,
                      maxWidth: double.infinity,
                      child: FractionalTranslation(
                        translation: Offset(-_ctrl.value / 2, 0),
                        child: Row(mainAxisSize: MainAxisSize.min, children: doubled),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoTile extends StatefulWidget {
  final _Logo logo;
  final double height;
  final VoidCallback onTap;
  const _LogoTile(
      {required this.logo, required this.height, required this.onTap});
  @override
  State<_LogoTile> createState() => _LogoTileState();
}

class _LogoTileState extends State<_LogoTile> {
  bool _hovered = false;

  static const _grey = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0, //
    0, 0, 0, 1, 0,
  ]);
  static const _none = ColorFilter.mode(Colors.transparent, BlendMode.dst);

  @override
  Widget build(BuildContext context) {
    final l = widget.logo;
    final isMark = l.height <= 1.0; // square marks get a wordmark beside them
    return Tooltip(
      message: l.name,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: _hovered ? 1 : 0.72,
            child: ColorFiltered(
              colorFilter: _hovered ? _none : _grey,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(l.asset, height: widget.height,
                      filterQuality: FilterQuality.medium),
                  if (isMark) ...[
                    const SizedBox(width: 10),
                    Text(
                      l.name,
                      style: GoogleFonts.poppins(
                        fontSize: widget.height * 0.62,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        color: const Color(0xFF1A1A1A),
                        height: 1,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
