import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/motion.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cols = w < 700 ? 1 : (w < 1100 ? 2 : 2);

    return SectionShell(
      color: AppTheme.paper2,
      backdrop: [
        Positioned(
          left: -w * 0.10,
          bottom: -80,
          child: const ParallaxShift(
              factor: 0.08, child: Glow(size: 560, color: AppTheme.blush, opacity: 0.45)),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            number: '02',
            label: 'What I do',
            title: 'What I can',
            accent: 'help you with.',
          ),
          const SizedBox(height: 48),
          LayoutBuilder(builder: (context, c) {
            const gap = 18.0;
            final cw = (c.maxWidth - gap * (cols - 1)) / cols;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (var i = 0; i < _areas.length; i++)
                  SizedBox(width: cw, child: _AreaCard(area: _areas[i], index: i + 2)),
              ],
            );
          }),
          const SizedBox(height: 72),
          Reveal(
            child: Text('TOOLS I REACH FOR', style: AppTheme.eyebrow()),
          ),
          const SizedBox(height: 22),
          const Reveal(index: 1, child: _MarqueeBand(reverse: false)),
          const SizedBox(height: 12),
          const Reveal(index: 2, child: _MarqueeBand(reverse: true)),
        ],
      ),
    );
  }
}

class _Area {
  final IconData icon;
  final String title;
  final String desc;
  final List<String> tools;
  const _Area(this.icon, this.title, this.desc, this.tools);
}

const _areas = [
  _Area(
    Icons.auto_awesome_rounded,
    'AI agents & automation',
    'Agents and workflows that take real work off a team: drafting, reconciling, chasing, reporting. Built with Claude Code and MCP, wired into the tools you already use.',
    ['Claude Code', 'MCP', 'AI Agents', 'n8n', 'Prompt Engineering'],
  ),
  _Area(
    Icons.account_tree_outlined,
    'Internal business systems',
    'Property management, HR, approvals, invoicing and reporting, designed around how the office actually operates and shipped to production.',
    ['Supabase', 'PostgreSQL', 'Cloudflare', 'Role-based access', 'Reporting'],
  ),
  _Area(
    Icons.devices_rounded,
    'Apps & integrations',
    'Web and mobile apps with the integrations behind them: REST APIs, webhooks, payment and document flows, offline-first where it matters.',
    ['Flutter', 'React Native', 'Expo', 'TypeScript', 'REST APIs', 'Webhooks'],
  ),
  _Area(
    Icons.insights_rounded,
    'Low-code & data',
    'Fast internal tooling and dashboards on the Microsoft stack, and the spreadsheets and reports that finance still runs on.',
    ['Power Apps', 'Power Automate', 'Power BI', 'Excel VBA', 'SQL'],
  ),
];

class _AreaCard extends StatelessWidget {
  final _Area area;
  final int index;
  const _AreaCard({required this.area, required this.index});

  @override
  Widget build(BuildContext context) {
    return Reveal(
      index: index,
      scaleFrom: 0.97,
      child: LiftCard(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppTheme.mintSoft),
              child: Icon(area.icon, size: 22, color: AppTheme.mint),
            ),
            const SizedBox(height: 22),
            Text(
              area.title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.4,
                color: AppTheme.textBlack,
              ),
            ),
            const SizedBox(height: 10),
            Text(area.desc, style: AppTheme.body(size: 14.5)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [for (final t in area.tools) Pill(t, fill: AppTheme.paper)],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Marquee ─────────────────────────────────────────────────────────────────

class _MarqueeBand extends StatefulWidget {
  final bool reverse;
  const _MarqueeBand({required this.reverse});

  @override
  State<_MarqueeBand> createState() => _MarqueeBandState();
}

class _MarqueeBandState extends State<_MarqueeBand>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: const Duration(seconds: 26))
        ..repeat();

  static const _row1 = [
    'Claude Code', 'AI Agents', 'MCP', 'Workflow Automation', 'n8n',
    'Prompt Engineering', 'Supabase', 'Cloudflare Pages',
  ];
  static const _row2 = [
    'REST APIs', 'Webhooks', 'Flutter', 'React Native', 'TypeScript',
    'Python', 'Power BI', 'SQL', 'Next.js',
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.reverse ? _row2 : _row1;
    final doubled = [...items, ...items];
    return SizedBox(
      height: 44,
      child: ClipRect(
        child: ShaderMask(
          shaderCallback: (r) => const LinearGradient(
            colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
            stops: [0, 0.06, 0.94, 1],
          ).createShader(r),
          blendMode: BlendMode.dstIn,
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) {
              final v = widget.reverse ? 1 - _ctrl.value : _ctrl.value;
              return OverflowBox(
                alignment: Alignment.centerLeft,
                maxWidth: double.infinity,
                child: FractionalTranslation(
                  translation: Offset(-v / 2, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [for (final l in doubled) _Chip(l)],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatefulWidget {
  final String label;
  const _Chip(this.label);
  @override
  State<_Chip> createState() => _ChipState();
}

class _ChipState extends State<_Chip> {
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
          border: Border.all(color: _hovered ? AppTheme.textBlack : AppTheme.border),
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
