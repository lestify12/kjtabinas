import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/section_wrapper.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      color: AppTheme.textBlack,
      padding: EdgeInsets.symmetric(
          horizontal: isNarrow ? 24 : 80, vertical: 80),
      child: SectionWrapper(
        sectionKey: 'contact',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "06",
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.3),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Let's Work\nTogether.",
              style: GoogleFonts.playfairDisplay(
                fontSize: isNarrow ? 40 : 64,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                height: 1.1,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Open to new opportunities, collaborations,\nand exciting projects across the globe.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.5),
                height: 1.7,
              ),
            ),
            const SizedBox(height: 48),

            isNarrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _contactItems(),
                  )
                : Row(
                    children: _contactItems()
                        .map((w) => Expanded(child: w))
                        .toList(),
                  ),

            const SizedBox(height: 64),

            const Divider(color: Color(0xFF2A2A2A), height: 1),
            const SizedBox(height: 28),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2025 Krystler John Tabinas',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                Text(
                  'Built with Flutter ⚡',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _contactItems() => [
        _ContactItem(
            icon: Icons.email_outlined,
            label: 'Email',
            value: PortfolioData.email),
        _ContactItem(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: PortfolioData.phone),
        _ContactItem(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: PortfolioData.location),
      ];
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactItem(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.4), size: 18),
          const SizedBox(height: 10),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.3),
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
