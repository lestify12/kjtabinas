// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onScrollDown;
  const HeroSection({super.key, required this.onScrollDown});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isNarrow = size.width < 768;

    return Container(
      width: double.infinity,
      color: AppTheme.bgCream,
      child: isNarrow ? _NarrowHero(onScrollDown: onScrollDown) : _WideHero(onScrollDown: onScrollDown),
    );
  }
}

// ─── Wide layout ─────────────────────────────────────────────────────────────

class _WideHero extends StatelessWidget {
  final VoidCallback onScrollDown;
  const _WideHero({required this.onScrollDown});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: [
          // ── Big serif greeting top-center ──
          Positioned(
            top: size.height * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Hey, there',
                style: GoogleFonts.playfairDisplay(
                  fontSize: size.width * 0.072,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.textBlack,
                  height: 1.0,
                ),
              )
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .slideY(begin: -0.1, end: 0, duration: 800.ms),
            ),
          ),

          // ── Profile photo center ──
          Positioned(
            top: size.height * 0.08,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: size.width * 0.28,
                height: size.height * 0.78,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Image.asset(
                    'assets/images/me.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFDDD8CE),
                      child: Center(
                        child: Text(
                          'KJT',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 72,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 900.ms)
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                    delay: 200.ms,
                    duration: 900.ms,
                  ),
            ),
          ),

          // ── Available badge ──
          Positioned(
            top: size.height * 0.36,
            left: size.width * 0.08,
            child: _AvailableBadge()
                .animate()
                .fadeIn(delay: 600.ms, duration: 600.ms)
                .slideX(begin: -0.2, end: 0, delay: 600.ms),
          ),

          // ── Role right side ──
          Positioned(
            top: size.height * 0.38,
            right: size.width * 0.06,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'AI',
                  style: GoogleFonts.inter(
                    fontSize: size.width * 0.038,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textBlack,
                    letterSpacing: -1,
                    height: 0.95,
                  ),
                ),
                Text(
                  'AUTOMATION',
                  style: GoogleFonts.inter(
                    fontSize: size.width * 0.038,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textBlack,
                    letterSpacing: -1,
                    height: 0.95,
                  ),
                ),
                Text(
                  'ENGINEER',
                  style: GoogleFonts.inter(
                    fontSize: size.width * 0.038,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textBlack,
                    letterSpacing: -1,
                    height: 0.95,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'AI Agents · Workflows · API Integrations',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppTheme.textGray,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(delay: 500.ms, duration: 700.ms)
                .slideX(begin: 0.15, end: 0, delay: 500.ms),
          ),

          // ── Big name bottom-left ──
          Positioned(
            bottom: size.height * 0.06,
            left: size.width * 0.04,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'KRYSTLER JOHN',
                  style: GoogleFonts.inter(
                    fontSize: size.width * 0.055,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textBlack,
                    letterSpacing: -2,
                    height: 0.9,
                  ),
                ),
                Text(
                  'TABINAS',
                  style: GoogleFonts.inter(
                    fontSize: size.width * 0.055,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textBlack,
                    letterSpacing: -2,
                    height: 0.9,
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(delay: 300.ms, duration: 800.ms)
                .slideY(begin: 0.15, end: 0, delay: 300.ms),
          ),

          // ── CTA buttons bottom-right ──
          Positioned(
            bottom: size.height * 0.08,
            right: size.width * 0.06,
            child: Row(
              children: [
                _DarkBtn(
                  label: 'View Work',
                  onTap: onScrollDown,
                ),
                const SizedBox(width: 12),
                _OutlineBtn(
                  label: 'Download CV',
                  onTap: _downloadCV,
                ),
              ],
            )
                .animate()
                .fadeIn(delay: 700.ms, duration: 600.ms),
          ),

          // ── Scroll indicator ──
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: onScrollDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Scroll',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppTheme.textLight,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppTheme.textLight, size: 20),
                  ],
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(
                      begin: 0,
                      end: 4,
                      duration: 1200.ms,
                      curve: Curves.easeInOut,
                    ),
              ),
            ),
          ),

          // ── Decorative number ──
          Positioned(
            top: size.height * 0.18,
            left: size.width * 0.05,
            child: Text(
              '01',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: AppTheme.textLight,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
            ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
          ),
        ],
      ),
    );
  }
}

// ─── Narrow layout ────────────────────────────────────────────────────────────

class _NarrowHero extends StatelessWidget {
  final VoidCallback onScrollDown;
  const _NarrowHero({required this.onScrollDown});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 100, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hey, there',
            style: GoogleFonts.playfairDisplay(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              color: AppTheme.textBlack,
            ),
          ).animate().fadeIn(duration: 700.ms),

          const SizedBox(height: 24),

          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.asset(
                'assets/images/me.png',
                height: 280,
                width: 220,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (_, __, ___) => Container(
                  height: 280,
                  width: 220,
                  color: const Color(0xFFDDD8CE),
                  child: Center(
                    child: Text('KJT',
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 48,
                            color: AppTheme.textLight,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 700.ms),

          const SizedBox(height: 24),

          _AvailableBadge().animate().fadeIn(delay: 400.ms),

          const SizedBox(height: 20),

          Text(
            'KRYSTLER\nJOHN\nTABINAS',
            style: GoogleFonts.inter(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: AppTheme.textBlack,
              letterSpacing: -2,
              height: 0.9,
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 700.ms),

          const SizedBox(height: 16),

          Text(
            'AI AUTOMATION ENGINEER\nAI Agents · Workflows · API Integrations',
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppTheme.textGray,
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 500.ms),

          const SizedBox(height: 28),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _DarkBtn(label: 'View Work', onTap: onScrollDown),
              _OutlineBtn(label: 'Download CV', onTap: _downloadCV),
            ],
          ).animate().fadeIn(delay: 600.ms),
        ],
      ),
    );
  }
}

// ─── Shared widgets ───────────────────────────────────────────────────────────

class _AvailableBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.bgWhite,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppTheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.accentGreen,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Available for new opportunities',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _DarkBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _DarkBtn({required this.label, required this.onTap});

  @override
  State<_DarkBtn> createState() => _DarkBtnState();
}

class _DarkBtnState extends State<_DarkBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFF333333)
                : AppTheme.textBlack,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineBtn({required this.label, required this.onTap});

  @override
  State<_OutlineBtn> createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<_OutlineBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? AppTheme.textBlack.withValues(alpha: 0.06)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppTheme.borderDark, width: 1.5),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textBlack,
            ),
          ),
        ),
      ),
    );
  }
}

void _downloadCV() {
  final anchor =
      html.AnchorElement(href: 'Krystler_John_Tabinas_CV.pdf')
        ..setAttribute('download', 'Krystler_John_Tabinas_CV.pdf')
        ..style.display = 'none';
  html.document.body!.append(anchor);
  anchor.click();
  anchor.remove();
}
