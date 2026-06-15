import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/education_section.dart';
import 'sections/contact_section.dart';
import 'widgets/nav_bar.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Krystler John Tabinas — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollCtrl = ScrollController();
  double _scrollOffset = 0;

  // Section keys for scroll-to navigation
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      setState(() => _scrollOffset = _scrollCtrl.offset);
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToAbout() {
    final ctx = _aboutKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollCtrl,
            child: Column(
              children: [
                // Hero — full viewport height
                HeroSection(onScrollDown: _scrollToAbout),

                // About
                KeyedSubtree(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),

                // Skills
                KeyedSubtree(
                  key: _skillsKey,
                  child: const SkillsSection(),
                ),

                // Projects
                KeyedSubtree(
                  key: _projectsKey,
                  child: const ProjectsSection(),
                ),

                // Experience
                KeyedSubtree(
                  key: _experienceKey,
                  child: const ExperienceSection(),
                ),

                // Education
                KeyedSubtree(
                  key: _educationKey,
                  child: const EducationSection(),
                ),

                // Contact
                KeyedSubtree(
                  key: _contactKey,
                  child: const ContactSection(),
                ),
              ],
            ),
          ),

          // Sticky NavBar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollController: _scrollCtrl,
              sectionKeys: [
                _aboutKey,
                _skillsKey,
                _projectsKey,
                _experienceKey,
                _educationKey,
                _contactKey,
              ],
              scrollOffset: _scrollOffset,
            ),
          ),

          // Scroll to top FAB
          if (_scrollOffset > 400)
            Positioned(
              bottom: 32,
              right: 32,
              child: _ScrollTopButton(
                onTap: () => _scrollCtrl.animateTo(
                  0,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOutCubic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ScrollTopButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ScrollTopButton({required this.onTap});

  @override
  State<_ScrollTopButton> createState() => _ScrollTopButtonState();
}

class _ScrollTopButtonState extends State<_ScrollTopButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered ? const Color(0xFF333333) : AppTheme.textBlack,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hovered ? 0.25 : 0.12),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.keyboard_arrow_up_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
