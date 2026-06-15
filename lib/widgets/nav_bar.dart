import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class NavBar extends StatelessWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;
  final double scrollOffset;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    required this.scrollOffset,
  });

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 768;
    final scrolled = scrollOffset > 20;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: scrolled
            ? AppTheme.bgCream.withValues(alpha: 0.95)
            : AppTheme.bgCream,
        border: Border(
          bottom: BorderSide(
            color: scrolled ? AppTheme.border : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: isNarrow ? 20 : 48, vertical: 18),
      child: Row(
        children: [
          // Logo
          Text(
            'Krystler.',
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.textBlack,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Spacer(),
          if (!isNarrow) ...[
            _Link('Home', () => _scrollTo(sectionKeys[0])),
            _Link('Works', () => _scrollTo(sectionKeys[2])),
            _Link('About', () => _scrollTo(sectionKeys[1])),
            _Link('Skills', () => _scrollTo(sectionKeys[3])),
            const SizedBox(width: 16),
            _ContactBtn(() => _scrollTo(sectionKeys[5])),
          ] else
            _ContactBtn(() => _scrollTo(sectionKeys[5])),
        ],
      ),
    );
  }
}

class _Link extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _Link(this.label, this.onTap);

  @override
  State<_Link> createState() => _LinkState();
}

class _LinkState extends State<_Link> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _hovered ? AppTheme.textBlack : AppTheme.textGray,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _ContactBtn extends StatefulWidget {
  final VoidCallback onTap;
  const _ContactBtn(this.onTap);

  @override
  State<_ContactBtn> createState() => _ContactBtnState();
}

class _ContactBtnState extends State<_ContactBtn> {
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
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.textBlack : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppTheme.textBlack, width: 1.5),
          ),
          child: Text(
            'Contact',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _hovered ? Colors.white : AppTheme.textBlack,
            ),
          ),
        ),
      ),
    );
  }
}
