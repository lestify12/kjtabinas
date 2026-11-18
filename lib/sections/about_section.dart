import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/motion.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 900;

    return SectionShell(
      backdrop: [
        Positioned(
          right: -w * 0.08,
          top: 40,
          child: const ParallaxShift(
              factor: -0.10, child: Glow(size: 520, color: AppTheme.lilac)),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            number: '01',
            label: 'About',
            title: 'Bridging technology',
            accent: '& business.',
          ),
          const SizedBox(height: 48),
          isNarrow
              ? const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_Bio(), SizedBox(height: 40), _Side()],
                )
              : const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: _Bio()),
                    SizedBox(width: 72),
                    Expanded(flex: 5, child: _Side()),
                  ],
                ),
        ],
      ),
    );
  }
}

class _Bio extends StatelessWidget {
  const _Bio();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          index: 2,
          child: Text(
            'I build the systems a business actually runs on, and then automate the work around them.',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              height: 1.45,
              letterSpacing: -0.4,
              color: AppTheme.textBlack,
            ),
          ),
        ),
        const SizedBox(height: 22),
        Reveal(
          index: 3,
          child: Text(PortfolioData.profileSummary, style: AppTheme.body()),
        ),
        const SizedBox(height: 14),
        Reveal(
          index: 4,
          child: Text(
            'Currently based in Dubai, building AI agents, workflow automations and internal '
            'business systems at Luxe Signature Holiday Homes, and shipping my own products on '
            'the side.',
            style: AppTheme.body(),
          ),
        ),
        const SizedBox(height: 32),
        Reveal(
          index: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _InfoRow('Email', PortfolioData.email),
              _InfoRow('Phone', PortfolioData.phone),
              _InfoRow('Based in', PortfolioData.location, last: true),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String text;
  final bool last;
  const _InfoRow(this.label, this.text, {this.last = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: AppTheme.border),
          bottom: last ? const BorderSide(color: AppTheme.border) : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Text(label.toUpperCase(), style: AppTheme.eyebrow()),
          ),
          Expanded(
            child: Text(text,
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.textDark)),
          ),
        ],
      ),
    );
  }
}

class _Side extends StatelessWidget {
  const _Side();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: const [
            Expanded(child: _Stat(index: 2, end: 3, suffix: '+', label: 'Years building\nsystems')),
            SizedBox(width: 14),
            Expanded(child: _Stat(index: 3, end: 6, suffix: '', label: 'Systems built\nend to end')),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: const [
            Expanded(child: _Stat(index: 4, end: 412, suffix: '', label: 'Units managed on\nthe PM platform')),
            SizedBox(width: 14),
            Expanded(child: _Stat(index: 5, end: 5, suffix: '', label: 'Companies across\ntwo countries')),
          ],
        ),
        const SizedBox(height: 14),
        Reveal(
          index: 6,
          child: Container(
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: AppTheme.textBlack,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppTheme.mint),
                    ),
                    const SizedBox(width: 10),
                    Text('NOW', style: AppTheme.eyebrow(color: Colors.white54)),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'AI Automation Engineer at Luxe Signature Holiday Homes, Dubai. '
                  'Running the property platform, the HRIS and the automations that connect them.',
                  style: GoogleFonts.inter(
                      fontSize: 14.5, height: 1.7, color: Colors.white.withValues(alpha: 0.85)),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text('LANGUAGES', style: AppTheme.eyebrow(color: Colors.white38)),
                    const SizedBox(width: 14),
                    const TagLine(['English', 'Filipino'], color: Colors.white70),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final int index;
  final int end;
  final String suffix;
  final String label;
  const _Stat({required this.index, required this.end, required this.suffix, required this.label});

  @override
  Widget build(BuildContext context) {
    return Reveal(
      index: index,
      scaleFrom: 0.96,
      child: LiftCard(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CountUp(
              end: end,
              suffix: suffix,
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.5,
                height: 1,
                color: AppTheme.textBlack,
              ),
            ),
            const SizedBox(height: 10),
            Text(label,
                style: GoogleFonts.inter(
                    fontSize: 12.5, height: 1.45, color: AppTheme.textGray)),
          ],
        ),
      ),
    );
  }
}
