import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/motion.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 800;

    return SectionShell(
      backdrop: [
        Positioned(
          right: -w * 0.1,
          top: 120,
          child: const ParallaxShift(
              factor: -0.08, child: Glow(size: 520, color: AppTheme.blush, opacity: 0.4)),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            number: '04',
            label: 'Experience',
            title: 'Where I have',
            accent: 'worked.',
          ),
          const SizedBox(height: 56),
          _Timeline(isNarrow: isNarrow),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  final bool isNarrow;
  const _Timeline({required this.isNarrow});

  @override
  Widget build(BuildContext context) {
    final railX = isNarrow ? 14.0 : 150.0; // where the vertical line sits
    return ScrollProgress(
      start: 0.8,
      end: 0.3,
      builder: (context, p) => Stack(
        children: [
          // The rail, drawn as the reader scrolls.
          Positioned(
            left: railX,
            top: 8,
            bottom: 8,
            child: LayoutBuilder(builder: (context, c) {
              return Stack(
                children: [
                  Container(width: 2, height: c.maxHeight, color: AppTheme.border),
                  Container(
                    width: 2,
                    height: c.maxHeight * p,
                    decoration: BoxDecoration(
                      color: AppTheme.mint,
                      boxShadow: [
                        BoxShadow(color: AppTheme.mint.withValues(alpha: 0.5), blurRadius: 8)
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
          Column(
            children: [
              for (var i = 0; i < PortfolioData.experiences.length; i++)
                _Entry(
                  exp: PortfolioData.experiences[i],
                  index: i,
                  isNarrow: isNarrow,
                  railX: railX,
                  reached: p > (i + 0.35) / PortfolioData.experiences.length,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Entry extends StatefulWidget {
  final ExperienceItem exp;
  final int index;
  final bool isNarrow;
  final double railX;
  final bool reached;
  const _Entry({
    required this.exp,
    required this.index,
    required this.isNarrow,
    required this.railX,
    required this.reached,
  });

  @override
  State<_Entry> createState() => _EntryState();
}

class _EntryState extends State<_Entry> with SingleTickerProviderStateMixin {
  late bool _expanded = widget.index == 0;
  late final AnimationController _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
      value: _expanded ? 1 : 0);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.exp;
    final current = e.period.contains('Present');
    final short = e.location.contains('Dubai')
        ? 'Dubai'
        : e.location.contains('Remote')
            ? 'Remote'
            : 'Philippines';

    final node = AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.reached ? AppTheme.mint : AppTheme.paper,
        border: Border.all(
            color: widget.reached ? AppTheme.mint : AppTheme.borderDark, width: 2),
        boxShadow: widget.reached
            ? [BoxShadow(color: AppTheme.mint.withValues(alpha: 0.35), blurRadius: 10)]
            : [],
      ),
    );

    final period = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(e.period,
            style: GoogleFonts.inter(
                fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        const SizedBox(height: 4),
        Text(short, style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textLight)),
      ],
    );

    final card = LiftCard(
      onTap: _toggle,
      padding: const EdgeInsets.fromLTRB(26, 24, 22, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.isNarrow) ...[
                      period,
                      const SizedBox(height: 10),
                    ],
                    Text(e.company,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                            color: AppTheme.textBlack)),
                    const SizedBox(height: 3),
                    Text(e.title,
                        style: GoogleFonts.inter(fontSize: 13.5, color: AppTheme.textGray)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (current)
                Container(
                  margin: const EdgeInsets.only(right: 10, top: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: AppTheme.mintSoft, borderRadius: BorderRadius.circular(100)),
                  child: Text('Current',
                      style: GoogleFonts.inter(
                          fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.mint)),
                ),
              AnimatedRotation(
                turns: _expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                child: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: AppTheme.textLight, size: 22),
              ),
            ],
          ),
          SizeTransition(
            sizeFactor: CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic),
            child: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final h in e.highlights)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: AppTheme.mint),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(h, style: AppTheme.body(size: 13.5))),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Reveal(
      index: 2 + widget.index,
      from: const Offset(0.04, 0.06),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isNarrow) SizedBox(width: widget.railX - 30, child: period),
            SizedBox(
              width: widget.isNarrow ? widget.railX * 2 + 2 : 62,
              child: Padding(
                padding: const EdgeInsets.only(top: 22),
                child: Center(child: node),
              ),
            ),
            Expanded(child: card),
          ],
        ),
      ),
    );
  }
}
