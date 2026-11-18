import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/motion.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 900;

    return SectionShell(
      color: AppTheme.paper2,
      backdrop: [
        Positioned(
          left: -w * 0.08,
          top: 0,
          child: const ParallaxShift(
              factor: 0.06, child: Glow(size: 460, color: AppTheme.lilac, opacity: 0.4)),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            number: '05',
            label: 'Education & training',
            title: 'Where I',
            accent: 'learned.',
          ),
          const SizedBox(height: 48),
          isNarrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _DegreeCard(item: PortfolioData.education.first),
                    const SizedBox(height: 18),
                    const _Trainings(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 340, child: _DegreeCard(item: PortfolioData.education.first)),
                    const SizedBox(width: 18),
                    const Expanded(child: _Trainings()),
                  ],
                ),
        ],
      ),
    );
  }
}

class _DegreeCard extends StatelessWidget {
  final EducationItem item;
  const _DegreeCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Reveal(
      index: 2,
      scaleFrom: 0.97,
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 44, 30, 30),
        decoration: const BoxDecoration(
          color: AppTheme.textBlack,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(170), bottom: Radius.circular(22)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.08)),
                child: const Icon(Icons.school_outlined, color: AppTheme.mint, size: 28),
              ),
            ),
            const SizedBox(height: 36),
            Text('DEGREE', style: AppTheme.eyebrow(color: Colors.white38)),
            const SizedBox(height: 10),
            Text(item.degree,
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.4,
                    height: 1.2,
                    color: Colors.white)),
            const SizedBox(height: 8),
            Text(item.school,
                style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: Colors.white60)),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white24)),
              child: Text('Class of ${item.year}',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Training {
  final IconData icon;
  final String title;
  final String org;
  final String desc;
  const _Training(this.icon, this.title, this.org, this.desc);
}

const _trainings = [
  _Training(Icons.public_rounded, 'Yale Model United Nations Korea',
      'Seoul, South Korea · Nov 2018', 'Represented Poland: debate, diplomacy and public speaking.'),
  _Training(Icons.mail_outline_rounded, 'Business Correspondence 101',
      'GC&C Group of Companies · Nov 2024', 'Professional communication, email etiquette and the digital workplace.'),
  _Training(Icons.tune_rounded, '5S Awareness Training',
      'GC&C Group of Companies · Jan 2025', 'Lean management, workplace organisation and continuous improvement.'),
  _Training(Icons.waves_rounded, 'WAVE Training',
      'GC&C Group of Companies · Sep 2024', 'Work Attitude and Values Enhancement: teamwork and resilience.'),
];

class _Trainings extends StatelessWidget {
  const _Trainings();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final two = c.maxWidth > 560;
      final cw = two ? (c.maxWidth - 18) / 2 : c.maxWidth;
      return Wrap(
        spacing: 18,
        runSpacing: 18,
        children: [
          for (var i = 0; i < _trainings.length; i++)
            SizedBox(
              width: cw,
              child: Reveal(
                index: 3 + i,
                scaleFrom: 0.97,
                child: LiftCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppTheme.mintSoft),
                        child: Icon(_trainings[i].icon, size: 19, color: AppTheme.mint),
                      ),
                      const SizedBox(height: 16),
                      Text(_trainings[i].title,
                          style: GoogleFonts.poppins(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                              color: AppTheme.textBlack)),
                      const SizedBox(height: 4),
                      Text(_trainings[i].org,
                          style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textLight)),
                      const SizedBox(height: 10),
                      Text(_trainings[i].desc, style: AppTheme.body(size: 13.5)),
                    ],
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
