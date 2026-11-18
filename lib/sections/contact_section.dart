import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../utils/cv.dart';
import '../widgets/motion.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 860;
    final titleSize = (w * 0.058).clamp(40.0, 84.0);

    return SectionShell(
      padding: EdgeInsets.fromLTRB(isNarrow ? 16 : 48, isNarrow ? 48 : 96, isNarrow ? 16 : 48, 28),
      maxWidth: 1240,
      backdrop: [
        Positioned(
          left: w * 0.15,
          top: -60,
          child: const ParallaxShift(
              factor: -0.06, child: Glow(size: 520, color: AppTheme.blush, opacity: 0.5)),
        ),
        Positioned(
          right: w * 0.05,
          top: 120,
          child: const ParallaxShift(
              factor: 0.08, child: Glow(size: 460, color: AppTheme.lilac, opacity: 0.5)),
        ),
      ],
      child: Column(
        children: [
          Reveal(
            scaleFrom: 0.985,
            stagger: const Duration(milliseconds: 40),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? 28 : 72, vertical: isNarrow ? 56 : 88),
              decoration: BoxDecoration(
                color: AppTheme.textBlack,
                borderRadius: BorderRadius.circular(isNarrow ? 16 : 24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Reveal(
                    index: 1, stagger: const Duration(milliseconds: 50),
                    child: Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppTheme.mint),
                        ),
                        const SizedBox(width: 10),
                        Text('06  —  CONTACT', style: AppTheme.eyebrow(color: Colors.white38)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Reveal(
                    index: 2, stagger: const Duration(milliseconds: 50),
                    child: RichText(
                      text: TextSpan(
                        style: AppTheme.display(titleSize, color: Colors.white),
                        children: [
                          const TextSpan(text: "Let's work\n"),
                          TextSpan(
                              text: 'together.',
                              style: AppTheme.displayAccent(titleSize, color: AppTheme.mint)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Reveal(
                    index: 3, stagger: const Duration(milliseconds: 50),
                    child: Text(
                      'Open to automation, internal tooling and mobile work, in the UAE or remote. '
                      'Tell me what is slowing your team down and I will tell you what I would build.',
                      style: GoogleFonts.inter(
                          fontSize: 16, height: 1.7, color: Colors.white.withValues(alpha: 0.6)),
                    ),
                  ),
                  const SizedBox(height: 36),
                  Reveal(
                    index: 4, stagger: const Duration(milliseconds: 50),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SquareButton(
                          label: 'Email me',
                          icon: Icons.arrow_outward_rounded,
                          ink: AppTheme.mint,
                          paper: AppTheme.textBlack,
                          onTap: () => launchUrl(Uri.parse('mailto:${PortfolioData.email}')),
                        ),
                        SquareButton(
                          label: 'Download CV',
                          icon: Icons.download_rounded,
                          filled: false,
                          ink: Colors.white,
                          onTap: downloadCV,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 56),
                  Reveal(
                    index: 5, stagger: const Duration(milliseconds: 50),
                    child: Container(height: 1, color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  const SizedBox(height: 36),
                  Reveal(
                    index: 6, stagger: const Duration(milliseconds: 50),
                    child: isNarrow
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final c in _details) ...[c, const SizedBox(height: 24)],
                              const _Socials(),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final c in _details) Expanded(child: c),
                              const _Socials(),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 8,
              children: [
                Text('© 2026 Krystler John Tabinas',
                    style: GoogleFonts.inter(fontSize: 13, color: AppTheme.textLight)),
                Text('Dubai, UAE  ·  Built with Flutter',
                    style: GoogleFonts.inter(fontSize: 13, color: AppTheme.textLight)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const _details = [
    _Detail(Icons.mail_outline_rounded, 'Email', PortfolioData.email),
    _Detail(Icons.call_outlined, 'Phone', PortfolioData.phone),
    _Detail(Icons.place_outlined, 'Location', PortfolioData.location),
  ];
}

class _Detail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _Detail(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppTheme.mint),
        const SizedBox(height: 12),
        Text(label.toUpperCase(), style: AppTheme.eyebrow(color: Colors.white38)),
        const SizedBox(height: 6),
        Text(value,
            style: GoogleFonts.inter(
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.88))),
      ],
    );
  }
}

class _Socials extends StatelessWidget {
  const _Socials();

  static const _items = [
    ('LinkedIn', 'https://www.linkedin.com/in/kjtabinas/'),
    ('GitHub', 'https://github.com/lestify12'),
    ('Facebook', 'https://www.facebook.com/kjtabinas'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ELSEWHERE', style: AppTheme.eyebrow(color: Colors.white38)),
        const SizedBox(height: 10),
        for (final (label, url) in _items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: _SocialBtn(label: label, url: url),
          ),
      ],
    );
  }
}

class _SocialBtn extends StatefulWidget {
  final String label;
  final String url;
  const _SocialBtn({required this.label, required this.url});
  @override
  State<_SocialBtn> createState() => _SocialBtnState();
}

class _SocialBtnState extends State<_SocialBtn> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 160),
              style: GoogleFonts.inter(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: _hovered ? AppTheme.mint : Colors.white.withValues(alpha: 0.88)),
              child: Text(widget.label),
            ),
            const SizedBox(width: 6),
            AnimatedSlide(
              duration: const Duration(milliseconds: 160),
              offset: Offset(_hovered ? 0.25 : 0, _hovered ? -0.25 : 0),
              child: Icon(Icons.arrow_outward_rounded,
                  size: 13, color: _hovered ? AppTheme.mint : Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}
