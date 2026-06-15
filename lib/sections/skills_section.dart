import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/section_wrapper.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      color: AppTheme.bgCream,
      padding: EdgeInsets.symmetric(
          horizontal: isNarrow ? 24 : 80, vertical: 80),
      child: SectionWrapper(
        sectionKey: 'skills',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel(number: '03', title: 'I Can Help You With'),
            const SizedBox(height: 8),
            Text(
              'Experience & Skills',
              style: GoogleFonts.playfairDisplay(
                fontSize: isNarrow ? 32 : 46,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: AppTheme.textBlack,
                letterSpacing: -1,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 48),

            // Skills table — like the reference
            _SkillsTable(isNarrow: isNarrow),

            const SizedBox(height: 64),

            // Tech chips
            Text(
              'TECHNOLOGIES',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.textLight,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: PortfolioData.technicalSkills
                  .asMap()
                  .entries
                  .map((e) => _TechChip(e.value, e.key))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillsTable extends StatelessWidget {
  final bool isNarrow;
  const _SkillsTable({required this.isNarrow});

  static const _rows = [
    _SkillRow('2023–25', 'Software Engineering',
        ['Flutter', 'Dart', 'HTML/CSS/JS', 'Power Apps']),
    _SkillRow('2023–25', 'Business Automation',
        ['Power Automate', 'Power BI', 'Excel VBA', 'API Integration']),
    _SkillRow('2024–25', 'Digital Marketing',
        ['SEO', 'CMS', 'Social Media', 'Lead Generation']),
    _SkillRow('2022–25', 'IT Administration',
        ['Microsoft 365', 'Git', 'HTML/CSS/JS', 'Cybersecurity']),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _rows
          .asMap()
          .entries
          .map((e) => _SkillRowWidget(row: e.value, index: e.key))
          .toList(),
    );
  }
}

class _SkillRow {
  final String period;
  final String area;
  final List<String> tools;
  const _SkillRow(this.period, this.area, this.tools);
}

class _SkillRowWidget extends StatefulWidget {
  final _SkillRow row;
  final int index;
  const _SkillRowWidget({required this.row, required this.index});

  @override
  State<_SkillRowWidget> createState() => _SkillRowWidgetState();
}

class _SkillRowWidgetState extends State<_SkillRowWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 768;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: _hovered ? AppTheme.bgWhite : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            bottom: BorderSide(color: AppTheme.border, width: 1),
          ),
        ),
        child: isNarrow
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.row.period,
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.textLight,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text(widget.row.area,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textBlack)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children:
                        widget.row.tools.map((t) => _Pill(t)).toList(),
                  ),
                ],
              )
            : Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Text(widget.row.period,
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.textLight,
                            fontWeight: FontWeight.w500)),
                  ),
                  Expanded(
                    child: Text(widget.row.area,
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textBlack)),
                  ),
                  Wrap(
                    spacing: 6,
                    children:
                        widget.row.tools.map((t) => _Pill(t)).toList(),
                  ),
                ],
              ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  const _Pill(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.bgCream,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppTheme.border),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: AppTheme.textGray,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _TechChip extends StatefulWidget {
  final String label;
  final int index;
  const _TechChip(this.label, this.index);

  @override
  State<_TechChip> createState() => _TechChipState();
}

class _TechChipState extends State<_TechChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: _hovered ? AppTheme.textBlack : AppTheme.bgWhite,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
              color: _hovered ? AppTheme.textBlack : AppTheme.border),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _hovered ? Colors.white : AppTheme.textDark,
          ),
        ),
      ),
    );
  }
}
