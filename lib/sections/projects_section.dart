import 'dart:math' as math;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/section_wrapper.dart';
// ignore: unused_import
import 'package:flutter_animate/flutter_animate.dart';

/// One slice of a repository's language breakdown, as GitHub reports it.
class Lang {
  final String name;
  final double percent;
  const Lang(this.name, this.percent);

  /// GitHub's own linguist colours, so the bar reads the way people expect.
  Color get color => switch (name) {
        'TypeScript' => const Color(0xFF3178C6),
        'JavaScript' => const Color(0xFFF1E05A),
        'HTML' => const Color(0xFFE34C26),
        'CSS' => const Color(0xFF663399),
        'Swift' => const Color(0xFFF05138),
        'PLpgSQL' => const Color(0xFF336790),
        'Dart' => const Color(0xFF00B4AB),
        'Python' => const Color(0xFF3572A5),
        _ => const Color(0xFFBDB7AC),
      };
}

class ProjectItem {
  final String title;
  final String subtitle;
  final String description;
  /// Extra context shown under the description — e.g. why a build stopped.
  final String? note;
  final String image;
  final String? imageAlt;
  final List<String> extraImages;
  final List<String> tags;
  final List<Lang> languages;
  final Color accentColor;
  final String status;
  final bool isMobileApp;
  /// True when the screenshots already ship inside a rendered device frame, so
  /// the site must not wrap them in its own phone shell a second time.
  final bool hasDeviceFrame;
  /// True when the first slide is a wide marketing banner rather than a screen,
  /// so it fills the panel instead of being letterboxed with the phone shots.
  final bool bannerCover;
  final String? liveUrl;
  final String? browserUrl;
  final List<String> imageLabels;

  const ProjectItem({
    required this.title,
    required this.subtitle,
    required this.description,
    this.note,
    required this.image,
    this.imageAlt,
    this.extraImages = const [],
    required this.tags,
    this.languages = const [],
    required this.accentColor,
    required this.status,
    this.isMobileApp = false,
    this.hasDeviceFrame = false,
    this.bannerCover = false,
    this.liveUrl,
    this.browserUrl,
    this.imageLabels = const [],
  });
}

const _projects = [
  ProjectItem(
    title: 'Maal',
    subtitle: 'Offline-First Budget Tracker for the Gulf',
    description:
        'A personal finance app built for how money actually moves in the Gulf. Tracks '
        'multi-currency accounts and net worth, pace-aware budgets, savings goals, and '
        'BNPL and loan installments — with full Arabic RTL, a 50+ GCC bank catalog, and '
        'IBAN validation. Everything lives in on-device SQLite: no account, no server, '
        'no analytics.',
    image: 'assets/images/cover_maal.jpg',
    imageAlt: 'assets/images/maal_dashboard.png',
    extraImages: [
      'assets/images/maal_wallet.png',
      'assets/images/maal_budget.png',
      'assets/images/maal_goals.png',
      'assets/images/maal_installments.png',
    ],
    tags: ['React Native', 'Expo', 'SQLite', 'Offline-First', 'UAE / GCC'],
    languages: [
      Lang('TypeScript', 87.3),
      Lang('HTML', 9.1),
      Lang('JavaScript', 1.9),
      Lang('CSS', 1.2),
      Lang('Swift', 0.5),
    ],
    accentColor: Color(0xFF0A2C63),
    status: 'Live',
    isMobileApp: true,
    hasDeviceFrame: true,
    bannerCover: true,
    imageLabels: [
      'Overview',
      'Dashboard',
      'Wallet',
      'Budget',
      'Goals',
      'Installments',
    ],
  ),
  ProjectItem(
    title: 'Waggo',
    subtitle: 'Pet Care Marketplace',
    description:
        'A pet-care platform for the UAE. Pet parents keep a profile for every '
        'animal, find verified PawRovers and PawKeepers nearby, and book walks, '
        'play sessions, potty breaks, drop-in visits or house sitting — then '
        'follow each booking through to handover. The sitter side is built too: '
        'onboarding, verification badges, services, rates and availability.',
    note:
        'Discontinued. Waggo needs a registered business behind it — trade licence, '
        'insurance and a properly vetted sitter network — before it could safely take '
        'a real booking, so the build stopped at a finished prototype rather than ship '
        'half a duty of care. It stays in the portfolio because the product work is '
        'worth showing: every screen here is designed, built and working.',
    image: 'assets/images/cover_waggo.jpg',
    imageAlt: 'assets/images/waggo_discover.jpg',
    extraImages: [
      'assets/images/waggo_provider.jpg',
      'assets/images/waggo_bookings.jpg',
      'assets/images/waggo_booking_detail.jpg',
      'assets/images/waggo_pets.jpg',
      'assets/images/waggo_pet_profile.jpg',
      'assets/images/waggo_pet_new.jpg',
      'assets/images/waggo_become_provider.jpg',
      'assets/images/waggo_profile.jpg',
      'assets/images/waggo_settings.jpg',
    ],
    tags: ['React Native', 'Expo', 'Supabase', 'Marketplace', 'UAE'],
    languages: [
      Lang('TypeScript', 80.9),
      Lang('PLpgSQL', 16.7),
      Lang('JavaScript', 2.4),
    ],
    accentColor: Color(0xFF1B5E3A),
    status: 'Discontinued',
    isMobileApp: true,
    bannerCover: true,
    imageLabels: [
      'Overview',
      'Discover',
      'Sitter Profile',
      'Bookings',
      'Booking Detail',
      'My Pets',
      'Pet Profile',
      'Add a Pet',
      'Become a Sitter',
      'Profile',
      'Settings',
    ],
  ),
  ProjectItem(
    title: 'Property Management System',
    subtitle: 'All-in-One Platform for Holiday Homes & Rentals',
    description:
        'An all-in-one platform for UAE property managers — 412 units across 68 properties. '
        'Covers properties, leases, tenants, landlords and agents, with automated rent '
        'collection, invoicing, approval workflows, maintenance tracking, commission and '
        'income reporting, and real-time portfolio analytics.',
    image: 'assets/images/cover_pm.jpg',
    imageAlt: 'assets/images/pm_dashboard.jpg',
    extraImages: [
      'assets/images/pm_properties.jpg',
      'assets/images/pm_leases.jpg',
      'assets/images/pm_invoices.jpg',
      'assets/images/pm_landlords.jpg',
      'assets/images/pm_agents.jpg',
      'assets/images/pm_approvals.jpg',
      'assets/images/pm_maintenance.jpg',
      'assets/images/pm_reports.jpg',
      'assets/images/pm_income.jpg',
    ],
    tags: ['Supabase', 'Cloudflare', 'Real Estate', 'UAE'],
    languages: [
      Lang('HTML', 85.1),
      Lang('JavaScript', 14.2),
      Lang('Other', 0.7),
    ],
    accentColor: Color(0xFF00D4FF),
    status: 'Live',
    browserUrl: 'luxe-pm.app',
    imageLabels: [
      'Overview',
      'Dashboard',
      'Properties',
      'Leases',
      'Invoices',
      'Landlords',
      'Agents',
      'Approvals',
      'Maintenance',
      'Reports',
      'Company Income',
    ],
  ),
  ProjectItem(
    title: 'HRIS',
    subtitle: 'Human Resource Information System',
    description:
        'A complete HRIS built from scratch. Handles employee records, biometric '
        'attendance sync, leave and cash-advance requests, approval workflows, payroll, '
        'and recruitment — with role-based dashboards and self-service for every employee.',
    image: 'assets/images/cover_hris.jpg',
    imageAlt: 'assets/images/hris_dashboard.jpg',
    extraImages: [
      'assets/images/hris_directory.jpg',
      'assets/images/hris_approvals.jpg',
      'assets/images/hris_profile.jpg',
    ],
    tags: ['Web App', 'Supabase', 'Workflow Automation', 'Biometric Sync', 'UAE'],
    languages: [
      Lang('JavaScript', 63.6),
      Lang('TypeScript', 32.9),
      Lang('HTML', 2.4),
      Lang('Other', 1.1),
    ],
    accentColor: Color(0xFF4F46E5),
    status: 'Live',
    browserUrl: 'hris.luxesignature.ae',
    imageLabels: ['Overview', 'Dashboard', 'Directory', 'Approvals', 'Profile'],
  ),
];

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      color: AppTheme.bgWhite,
      padding: EdgeInsets.symmetric(
          horizontal: isNarrow ? 24 : 80, vertical: 80),
      child: SectionWrapper(
        sectionKey: 'projects',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel(number: '03', title: 'Recent Projects'),
            Text(
              "Things I've\nBuilt",
              style: GoogleFonts.playfairDisplay(
                fontSize: 46,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: AppTheme.textBlack,
                letterSpacing: -1,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 48),
            ..._projects.map(
              (p) => _ProjectCard(project: p, isNarrow: isNarrow),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── 3D tilt card ───────────────────────────────────────────────────────────

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  final bool isNarrow;
  const _ProjectCard({required this.project, required this.isNarrow});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  // 3D tilt values
  double _tiltX = 0;
  double _tiltY = 0;
  bool _hovered = false;

  // Floating animation
  late final AnimationController _floatCtrl;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    super.dispose();
  }

  void _updateTilt(Offset local, Size cardSize) {
    final cx = cardSize.width / 2;
    final cy = cardSize.height / 2;
    setState(() {
      _tiltY = ((local.dx - cx) / cx).clamp(-1.0, 1.0) * 10;
      _tiltX = -((local.dy - cy) / cy).clamp(-1.0, 1.0) * 6;
    });
  }

  void _resetTilt() {
    setState(() {
      _tiltX = 0;
      _tiltY = 0;
      _hovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.project.accentColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: AnimatedBuilder(
        animation: _floatCtrl,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0008)
              ..rotateX(_tiltX * math.pi / 180)
              ..rotateY(_tiltY * math.pi / 180)
              ..translate(0.0, _hovered ? 0.0 : _floatAnim.value),
            child: child,
          );
        },
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => _resetTilt(),
          onHover: (e) {
            if (!_hovered) return;
            // Use a fixed card size estimate — avoids LayoutBuilder
            _updateTilt(e.localPosition,
                widget.isNarrow ? const Size(600, 600) : const Size(1200, 420));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppTheme.bgCream,
              border: Border.all(
                color: _hovered
                    ? accentColor.withValues(alpha: 0.5)
                    : accentColor.withValues(alpha: 0.12),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(
                      alpha: _hovered ? 0.18 : 0.05),
                  blurRadius: _hovered ? 50 : 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: widget.isNarrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Screenshot(project: widget.project),
                        _Info(
                            project: widget.project, hovered: _hovered),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _Screenshot(project: widget.project),
                        ),
                        Expanded(
                          flex: 4,
                          child: _Info(
                              project: widget.project,
                              hovered: _hovered),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 700.ms)
        .slideY(
            begin: 0.1,
            end: 0,
            duration: 700.ms,
            curve: Curves.easeOutCubic);
  }
}

// ─── Screenshot panel ────────────────────────────────────────────────────────

class _Screenshot extends StatefulWidget {
  final ProjectItem project;
  const _Screenshot({required this.project});

  @override
  State<_Screenshot> createState() => _ScreenshotState();
}

class _ScreenshotState extends State<_Screenshot>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeInOut);
    _fadeCtrl.value = 1.0;
  }

  /// Slides only move when the visitor asks them to — arrows and dots.
  ///
  /// Deliberately does not await the controller: a TickerFuture is cancelled
  /// whenever the animation is interrupted, and awaiting one that never
  /// resolves would strand the panel at zero opacity. Swap the image, then
  /// fade the new one in from scratch.
  void _goTo(int target) {
    final images = _images;
    if (images.length < 2) return;
    // Dart's % is never negative for a positive divisor, so stepping back from
    // the first slide wraps round to the last.
    final next = target % images.length;
    if (next == _index) return;
    setState(() => _index = next);
    _fadeCtrl
      ..value = 0
      ..forward();
  }

  /// Prev/next affordances pinned to the sides of the screenshot panel.
  List<Widget> _arrows(int count, {bool light = false}) => [
        Positioned(
          left: 10,
          top: 0,
          bottom: 0,
          child: Center(
            child: _ArrowButton(
              icon: Icons.chevron_left_rounded,
              light: light,
              onTap: () => _goTo(_index - 1),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 0,
          bottom: 0,
          child: Center(
            child: _ArrowButton(
              icon: Icons.chevron_right_rounded,
              light: light,
              onTap: () => _goTo(_index + 1),
            ),
          ),
        ),
      ];

  List<String> get _images => [
        widget.project.image,
        if (widget.project.imageAlt != null) widget.project.imageAlt!,
        ...widget.project.extraImages,
      ];

  static const _labels = ['Login', 'Dashboard'];
  static const _urls = ['luxe-pm.app', 'luxe-pm.app/dashboard'];

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mobile projects. Three shapes share one panel: a wide banner cover fills
    // it edge to edge, screenshots that already ship inside a rendered device
    // are shown as-is, and raw screenshots get the site's own phone shell.
    if (widget.project.isMobileApp) {
      final images = _images;
      final isBanner = widget.project.bannerCover && _index == 0;
      final framed = widget.project.hasDeviceFrame;

      final Widget shot = FadeTransition(
        opacity: _fade,
        child: Image.asset(
          images[_index],
          fit: isBanner
              ? BoxFit.cover
              : (framed ? BoxFit.contain : BoxFit.cover),
          alignment:
              (isBanner || framed) ? Alignment.center : const Alignment(0, -0.78),
          errorBuilder: (_, __, ___) => Center(
            child: Icon(Icons.smartphone_rounded,
                size: 48, color: widget.project.accentColor),
          ),
        ),
      );

      return Container(
        height: 384,
        color: AppTheme.bgLight,
        child: Stack(
          alignment: const Alignment(0, -0.22),
          children: [
            if (isBanner || framed)
              Positioned.fill(
                child: Padding(
                  padding: isBanner
                      ? EdgeInsets.zero
                      : const EdgeInsets.fromLTRB(24, 14, 24, 34),
                  child: shot,
                ),
              )
            else
              _PhoneMockup(
                accentColor: widget.project.accentColor,
                child: shot,
              ),
            if (images.length > 1) ..._arrows(images.length, light: isBanner),
            if (images.length > 1)
              Positioned(
                bottom: 14,
                left: 0,
                right: 0,
                child: _DotRow(
                  count: images.length,
                  index: _index,
                  onTap: _goTo,
                  activeColor:
                      isBanner ? Colors.white : widget.project.accentColor,
                  inactiveColor: isBanner
                      ? Colors.white.withValues(alpha: 0.45)
                      : AppTheme.textLight.withValues(alpha: 0.4),
                ),
              ),
            if (images.length > 1 && widget.project.imageLabels.length > _index)
              Positioned(
                bottom: 10,
                right: 14,
                child: _LabelChip(widget.project.imageLabels[_index]),
              ),
          ],
        ),
      );
    }

    final images = _images;
    final img = images[_index];
    final url = widget.project.browserUrl ??
        (_index < _urls.length ? _urls[_index] : _urls[0]);

    return SizedBox(
      height: 360,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          FadeTransition(
            opacity: _fade,
            child: Image.asset(
              img,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF0D1829),
                child: Center(
                  child: Text(
                    widget.project.title,
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.accentCyan.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom fade
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 80,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppTheme.bgCream.withValues(alpha: 0.95),
                  ],
                ),
              ),
            ),
          ),

          // Browser bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 28,
              color: const Color(0xFF1A1F2E),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  _Dot(const Color(0xFFFF5F57)),
                  const SizedBox(width: 6),
                  _Dot(const Color(0xFFFFBD2E)),
                  const SizedBox(width: 6),
                  _Dot(const Color(0xFF28C840)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1829),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          url,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),

          // Navigation
          if (images.length > 1) ..._arrows(images.length),

          // Dot indicators
          if (images.length > 1)
            Positioned(
              bottom: 14,
              left: 0,
              right: 0,
              child: _DotRow(
                count: images.length,
                index: _index,
                onTap: _goTo,
                activeColor: AppTheme.textBlack,
                inactiveColor: AppTheme.textLight.withValues(alpha: 0.5),
              ),
            ),

          // Label chip bottom-right
          if (images.length > 1)
            Positioned(
              bottom: 10,
              right: 14,
              child: _LabelChip((() {
                final labels = widget.project.imageLabels.isNotEmpty
                    ? widget.project.imageLabels
                    : _labels;
                return _index < labels.length ? labels[_index] : '';
              })()),
            ),
        ],
      ),
    );
  }
}

// ─── Phone mockup frame ──────────────────────────────────────────────────────

class _PhoneMockup extends StatelessWidget {
  final Widget child;
  final Color accentColor;
  const _PhoneMockup({required this.child, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow
        Container(
          width: 175,
          height: 340,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(38),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.18),
                blurRadius: 40,
                offset: const Offset(0, 12),
              ),
            ],
          ),
        ),
        // Phone shell
        Container(
          width: 175,
          height: 340,
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(38),
            border: Border.all(color: const Color(0xFF374151), width: 7),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(31),
            child: Stack(
              fit: StackFit.expand,
              children: [
                child,
                // Dynamic Island pill
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 52,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF111827),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Volume buttons left
        Positioned(
          left: 0,
          top: 90,
          child: Container(
            width: 4,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF374151),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 126,
          child: Container(
            width: 4,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF374151),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        // Power button right
        Positioned(
          right: 0,
          top: 108,
          child: Container(
            width: 4,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF374151),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}

class _DotRow extends StatelessWidget {
  final int count;
  final int index;
  final Color activeColor;
  final Color? inactiveColor;
  final ValueChanged<int>? onTap;
  const _DotRow({
    required this.count,
    required this.index,
    required this.activeColor,
    this.inactiveColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (i) {
          final active = i == index;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onTap == null ? null : () => onTap!(i),
              // Keep the tap target finger-friendly while the dot stays small.
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 9),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: active ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: active
                        ? activeColor
                        : (inactiveColor ??
                            AppTheme.textLight.withValues(alpha: 0.4)),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          );
        }),
      );
}

class _LanguageBar extends StatelessWidget {
  final List<Lang> languages;
  const _LanguageBar({required this.languages});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: SizedBox(
            height: 6,
            child: Row(
              // ColoredBox has no intrinsic height, so without stretch the
              // segments collapse and the bar renders empty.
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: languages
                  // A sub-1% slice still needs to be visible, so give every
                  // language a floor before splitting the width.
                  .map((l) => Expanded(
                        flex: (l.percent * 100).round().clamp(60, 1 << 20),
                        child: ColoredBox(color: l.color),
                      ))
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 14,
          runSpacing: 6,
          children: languages
              .map((l) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: l.color,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        l.name,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textBlack,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${l.percent}%',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final bool light;
  final VoidCallback onTap;
  const _ArrowButton(
      {required this.icon, required this.onTap, this.light = false});

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: light
                  ? Colors.white.withValues(alpha: 0.22)
                  : AppTheme.bgCream.withValues(alpha: 0.92),
              border: Border.all(
                color: light
                    ? Colors.white.withValues(alpha: 0.55)
                    : AppTheme.border,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon,
                size: 22, color: light ? Colors.white : AppTheme.textBlack),
          ),
        ),
      );
}

class _LabelChip extends StatelessWidget {
  final String label;
  const _LabelChip(this.label);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppTheme.bgCream.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.border),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppTheme.textGray,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot(this.color);

  @override
  Widget build(BuildContext context) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );
}

// ─── Info panel ──────────────────────────────────────────────────────────────

class _Info extends StatelessWidget {
  final ProjectItem project;
  final bool hovered;
  const _Info({required this.project, required this.hovered});

  @override
  Widget build(BuildContext context) {
    // Green reads as "running". Anything else gets a neutral treatment.
    final live = project.status.toLowerCase() == 'live';
    final badge = live ? AppTheme.accentGreen : AppTheme.textGray;
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Live badge
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badge.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: badge.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: badge,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  project.status,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: badge,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Text(
            project.title,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: AppTheme.textBlack,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            project.subtitle,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: project.accentColor,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            project.description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppTheme.textGray,
              height: 1.7,
            ),
          ),

          if (project.note != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              decoration: BoxDecoration(
                color: AppTheme.bgLight.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  left: BorderSide(color: project.accentColor, width: 3),
                ),
              ),
              child: Text(
                project.note!,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppTheme.textGray,
                  height: 1.65,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],

          if (project.languages.isNotEmpty) ...[
            const SizedBox(height: 22),
            _LanguageBar(languages: project.languages),
          ],

          const SizedBox(height: 20),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.tags
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: project.accentColor
                            .withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: project.accentColor
                              .withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        t,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: project.accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ))
                .toList(),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Icon(Icons.lock_outline,
                  size: 13, color: AppTheme.textLight),
              const SizedBox(width: 6),
              Text(
                'Private Repository',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppTheme.textLight,
                ),
              ),
            ],
          ),

          if (project.liveUrl != null) ...[
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => html.window.open(project.liveUrl!, '_blank'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: project.accentColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: project.accentColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.open_in_new_rounded,
                        size: 13, color: project.accentColor),
                    const SizedBox(width: 7),
                    Text(
                      'Visit Site',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: project.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
