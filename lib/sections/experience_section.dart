import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/section_wrapper.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      color: AppTheme.bgWhite,
      padding: EdgeInsets.symmetric(
          horizontal: isNarrow ? 24 : 80, vertical: 80),
      child: SectionWrapper(
        sectionKey: 'experience',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel(number: '04', title: 'Work Experience'),
            Text(
              'My Professional\nJourney',
              style: GoogleFonts.playfairDisplay(
                fontSize: isNarrow ? 32 : 46,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: AppTheme.textBlack,
                letterSpacing: -1,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 56),
            ...PortfolioData.experiences
                .asMap()
                .entries
                .map((e) => _ExpRow(exp: e.value, index: e.key)),
          ],
        ),
      ),
    );
  }
}

class _ExpRow extends StatefulWidget {
  final ExperienceItem exp;
  final int index;
  const _ExpRow({required this.exp, required this.index});

  @override
  State<_ExpRow> createState() => _ExpRowState();
}

class _ExpRowState extends State<_ExpRow>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  bool _visible = false;
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _expand;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _expand =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
  }

  Color get _accent =>
      Color(int.parse('FF${widget.exp.color}', radix: 16));

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 768;

    return VisibilityDetector(
      key: Key('exp-${widget.index}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 400 + widget.index * 80),
        opacity: _visible ? 1 : 0,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: _toggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 2),
              padding:
                  const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: _hovered || _expanded
                    ? AppTheme.bgCream
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  bottom: BorderSide(color: AppTheme.border),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Color dot
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _accent,
                        ),
                      ),
                      const SizedBox(width: 12),

                      if (!isNarrow) ...[
                        SizedBox(
                          width: 80,
                          child: Text(
                            widget.exp.location.contains('Dubai')
                                ? 'Dubai'
                                : 'Philippines',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppTheme.textLight,
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                      ],

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.exp.company,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textBlack,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.exp.title,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: AppTheme.textGray,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (widget.exp.period == 'Current')
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'Current',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: const Color(0xFF16A34A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      const SizedBox(width: 16),
                      AnimatedRotation(
                        turns: _expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppTheme.textLight,
                          size: 20,
                        ),
                      ),
                    ],
                  ),

                  // Expandable highlights
                  SizeTransition(
                    sizeFactor: _expand,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.exp.highlights
                            .map((h) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6),
                                        child: Container(
                                          width: 4,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _accent,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          h,
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: AppTheme.textGray,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
