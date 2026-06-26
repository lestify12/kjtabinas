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
            const SectionLabel(number: '02', title: 'I Can Help You With'),
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

            // Tech marquee
            Text(
              'TECHNOLOGIES',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.textLight,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 24),
            const _MarqueeBand(reverse: false),
            const SizedBox(height: 12),
            const _MarqueeBand(reverse: true),
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
    _SkillRow('2025–Now', 'AI & Automation',
        ['Claude Code', 'AI Agents', 'MCP', 'Workflow Automation']),
    _SkillRow('2023–Now', 'API & Integration',
        ['REST APIs', 'Webhooks', 'n8n', 'OAuth']),
    _SkillRow('2023–25', 'Low-Code & BI',
        ['Power Apps', 'Power Automate', 'Power BI', 'Excel VBA']),
    _SkillRow('2024–25', 'App & Web Dev',
        ['Flutter', 'Dart', 'JavaScript', 'Supabase']),
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

// ─── Marquee band ────────────────────────────────────────────────────────────

class _MarqueeBand extends StatefulWidget {
  final bool reverse;
  const _MarqueeBand({required this.reverse});

  @override
  State<_MarqueeBand> createState() => _MarqueeBandState();
}

class _MarqueeBandState extends State<_MarqueeBand>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  static const _row1 = [
    'Claude Code', 'AI Agents', 'MCP', 'Workflow Automation',
    'n8n', 'Prompt Engineering',
  ];
  static const _row2 = [
    'REST APIs', 'Webhooks', 'Flutter', 'Python',
    'JavaScript', 'Power BI', 'SQL', 'Supabase',
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.reverse ? _row2 : _row1;
    // Duplicate list for seamless loop
    final doubled = [...items, ...items];

    return SizedBox(
      height: 44,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          final offset = widget.reverse
              ? (1 - _ctrl.value)
              : _ctrl.value;
          return ClipRect(
            child: FractionalTranslation(
              translation: Offset(-offset, 0),
              child: Row(
                children: doubled
                    .map((label) => _MarqueeChip(label))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MarqueeChip extends StatefulWidget {
  final String label;
  const _MarqueeChip(this.label);

  @override
  State<_MarqueeChip> createState() => _MarqueeChipState();
}

class _MarqueeChipState extends State<_MarqueeChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: _hovered ? AppTheme.textBlack : AppTheme.bgWhite,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: _hovered ? AppTheme.textBlack : AppTheme.border,
          ),
          boxShadow: _hovered ? [] : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
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
