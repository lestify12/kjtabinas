import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/section_wrapper.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      color: AppTheme.bgCream,
      padding: EdgeInsets.symmetric(
          horizontal: isNarrow ? 24 : 80, vertical: 80),
      child: SectionWrapper(
        sectionKey: 'education',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel(number: '05', title: 'Education & Training'),
            Text(
              'Academic\nBackground',
              style: GoogleFonts.playfairDisplay(
                fontSize: isNarrow ? 32 : 46,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: AppTheme.textBlack,
                letterSpacing: -1,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 48),

            // Education cards
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: PortfolioData.education
                  .map((e) => _EduCard(item: e))
                  .toList(),
            ),

            const SizedBox(height: 64),

            Text(
              'TRAININGS & ACHIEVEMENTS',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.textLight,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 24),

            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                _TrainingCard(
                  title: 'Yale Model United Nations Korea',
                  org: 'Seoul, South Korea · Nov 2018',
                  desc: 'Represented Poland — debate, diplomacy, public speaking.',
                  icon: '🌍',
                ),
                _TrainingCard(
                  title: 'Business Correspondence 101',
                  org: 'GC&C Group of Companies · Nov 2024',
                  desc: 'Professional communication, email etiquette, digital workplace.',
                  icon: '✉️',
                ),
                _TrainingCard(
                  title: '5S Awareness Training',
                  org: 'GC&C Group of Companies · Jan 2025',
                  desc: 'Lean management, workplace organization, continuous improvement.',
                  icon: '⚙️',
                ),
                _TrainingCard(
                  title: 'WAVE Training',
                  org: 'GC&C Group of Companies · Sep 2024',
                  desc: 'Work Attitude & Values Enhancement — teamwork, resilience.',
                  icon: '🌊',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EduCard extends StatefulWidget {
  final EducationItem item;
  const _EduCard({required this.item});

  @override
  State<_EduCard> createState() => _EduCardState();
}

class _EduCardState extends State<_EduCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 300,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _hovered ? AppTheme.textBlack : AppTheme.bgWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.icon,
                style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 16),
            Text(
              widget.item.degree,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _hovered ? Colors.white : AppTheme.textBlack,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.item.school,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: _hovered
                    ? Colors.white.withValues(alpha: 0.6)
                    : AppTheme.textGray,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _hovered
                    ? Colors.white.withValues(alpha: 0.1)
                    : AppTheme.bgCream,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                'Class of ${widget.item.year}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: _hovered
                      ? Colors.white.withValues(alpha: 0.8)
                      : AppTheme.textGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrainingCard extends StatefulWidget {
  final String title;
  final String org;
  final String desc;
  final String icon;
  const _TrainingCard({
    required this.title,
    required this.org,
    required this.desc,
    required this.icon,
  });

  @override
  State<_TrainingCard> createState() => _TrainingCardState();
}

class _TrainingCardState extends State<_TrainingCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 260,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _hovered ? AppTheme.bgWhite : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.icon,
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.textBlack,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.org,
              style: GoogleFonts.inter(
                  fontSize: 11, color: AppTheme.textLight),
            ),
            const SizedBox(height: 8),
            Text(
              widget.desc,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppTheme.textGray,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
