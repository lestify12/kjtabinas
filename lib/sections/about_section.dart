import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/section_wrapper.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      color: AppTheme.bgWhite,
      padding: EdgeInsets.symmetric(
          horizontal: isNarrow ? 24 : 80, vertical: 80),
      child: SectionWrapper(
        sectionKey: 'about',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel(number: '01', title: 'About Me'),
            isNarrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_Bio(), const SizedBox(height: 40), _Stats()],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _Bio()),
                      const SizedBox(width: 80),
                      Expanded(flex: 4, child: _Stats()),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class _Bio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bridging\nTechnology\n& Business.',
          style: GoogleFonts.playfairDisplay(
            fontSize: 42,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            color: AppTheme.textBlack,
            height: 1.15,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          PortfolioData.profileSummary,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppTheme.textGray,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Currently based in Dubai, UAE — building AI agents, workflow automations, and internal '
          'business systems at Luxe Signature Holiday Homes that streamline real estate operations end-to-end.',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppTheme.textGray,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 32),
        // Contact info
        _InfoRow(Icons.email_outlined, PortfolioData.email),
        const SizedBox(height: 10),
        _InfoRow(Icons.phone_outlined, PortfolioData.phone),
        const SizedBox(height: 10),
        _InfoRow(Icons.location_on_outlined, PortfolioData.location),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.textLight),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
                fontSize: 13, color: AppTheme.textGray),
          ),
        ),
      ],
    );
  }
}

class _Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        _StatRow('3+', 'Years of Experience'),
        _Divider(),
        _StatRow('5', 'Companies Worked'),
        _Divider(),
        _StatRow('2', 'Countries Operated'),
        _Divider(),
        const SizedBox(height: 24),
        Text(
          'Languages',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppTheme.textLight,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _LangChip('English'),
            const SizedBox(width: 8),
            _LangChip('Filipino'),
          ],
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  final String value;
  final String label;
  const _StatRow(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: AppTheme.textBlack,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppTheme.textGray,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const Divider(color: AppTheme.border, height: 1);
}

class _LangChip extends StatelessWidget {
  final String label;
  const _LangChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.border),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: AppTheme.textDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
