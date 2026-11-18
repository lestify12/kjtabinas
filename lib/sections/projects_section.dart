import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/motion.dart';

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
  /// Colour to sit behind a letterboxed banner cover, sampled from the banner's
  /// own edges so the bars read as part of the artwork rather than as padding.
  final Color? coverBackdrop;
  final String? liveUrl;
  final String? browserUrl;
  final List<String> imageLabels;

  /// Width over height of the gallery frame. Browser shots are 16:9; the
  /// HRIS set was shot at 4:3.
  final double aspect;

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
    this.coverBackdrop,
    this.liveUrl,
    this.browserUrl,
    this.imageLabels = const [],
    this.aspect = 16 / 9,
  });
}

const _projects = [
  ProjectItem(
    title: 'Fleeto',
    subtitle: 'Car Rental Management SaaS',
    description:
        'A multi-tenant platform for car rental companies, from a single lot to a '
        'multi-branch enterprise fleet. Every company runs in its own FleetSpace: fleet '
        'with documents and expiry alerts, reservations with database-enforced '
        'availability so a car can never be double-booked, handovers with mileage, fuel, '
        'photos and damage, branded rental agreements, deposits and payments, flexible '
        'pricing, maintenance that blocks bookings, fines and tolls tied to the right '
        'rental, and car financing that shows real profit per vehicle after the bank. '
        'Role-based access for owners, branch managers, agents, accountants and fleet '
        'managers, with reports and results per branch or across the whole company.',
    image: 'assets/images/fleeto_dashboard.jpg',
    imageAlt: 'assets/images/fleeto_reservations.jpg',
    extraImages: [
      'assets/images/fleeto_fleet.jpg',
      'assets/images/fleeto_payments.jpg',
      'assets/images/fleeto_contracts.jpg',
    ],
    tags: ['Next.js', 'React', 'Vercel', 'SaaS', 'Multi-Branch', 'Car Rental'],
    accentColor: Color(0xFFE5342E),
    status: 'Live',
    liveUrl: 'https://fleeto.digital',
    browserUrl: 'fleeto.digital',
    imageLabels: [
      'Dashboard',
      'Reservations',
      'Fleet',
      'Payments',
      'Contracts',
    ],
  ),
  ProjectItem(
    title: 'Maal',
    subtitle: 'Offline-First Budget Tracker for the Gulf',
    description:
        'A personal finance app built for how money actually moves in the Gulf. Tracks '
        'multi-currency accounts and net worth, pace-aware budgets, savings goals, and '
        'BNPL and loan installments — with full Arabic RTL, a 50+ GCC bank catalog, and '
        'IBAN validation. Everything lives in on-device SQLite: no account, no server, '
        'no analytics.',
    note:
        'Discontinued. Maal is no longer being developed or maintained. It stays in '
        'the portfolio because the product work is worth showing: every screen here '
        'is designed, built and working.',
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
    status: 'Discontinued',
    isMobileApp: true,
    hasDeviceFrame: true,
    bannerCover: true,
    coverBackdrop: Color(0xFF000C27),
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
    image: 'assets/images/pm_unit_history.jpg',
    imageAlt: 'assets/images/pm_add_term.jpg',
    extraImages: [
      'assets/images/pm_tenant_payments.jpg',
      'assets/images/pm_transfer_sublease.jpg',
      'assets/images/pm_sublease_dashboard.jpg',
      'assets/images/pm_owner_statement.jpg',
    ],
    aspect: 4 / 3,
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
      'Unit and contract history',
      'Add contract term',
      'Tenant payments',
      'Transfer to sublease',
      'Sublease dashboard',
      'Owner statement',
    ],
  ),
  ProjectItem(
    title: 'Long-Term Lease System',
    subtitle: 'Annual Tenancy, Cheque & Renewal Management for Dubai',
    description:
        'A third book for the property management platform, built for annual letting '
        'rather than short stays, with its own portfolio of properties, units, landlords '
        'and tenants. Creating a tenancy generates everything at once: the annual contract '
        'terms, an evenly spread post-dated cheque schedule, and the unified tenancy '
        'contract PDF, which the tenant signs through a secure link. A lease tracker then '
        'walks each tenancy from contract drafted, to Ejari registered, to payments '
        'collected, to signed contract on file.',
    image: 'assets/images/cover_longterm.jpg',
    imageAlt: 'assets/images/lt_cheques.jpg',
    extraImages: [
      'assets/images/lt_lease_detail.jpg',
      'assets/images/lt_invoices.jpg',
      'assets/images/lt_landlords.jpg',
      'assets/images/lt_property.jpg',
    ],
    tags: ['Supabase', 'Cloudflare', 'Long-Term Leasing', 'Real Estate', 'UAE'],
    languages: [
      Lang('HTML', 85.1),
      Lang('JavaScript', 14.2),
      Lang('Other', 0.7),
    ],
    accentColor: Color(0xFFB8862B),
    status: 'Live',
    browserUrl: 'luxepm.online',
    imageLabels: [
      'Overview',
      'Cheques',
      'Tenancy',
      'Invoices',
      'Landlords',
      'Property',
    ],
  ),
  ProjectItem(
    title: 'HRIS',
    subtitle: 'Human Resource Information System',
    description:
        'A complete HRIS built from scratch. Handles employee records, biometric '
        'attendance sync, leave and cash-advance requests, approval workflows, payroll, '
        'and recruitment — with role-based dashboards and self-service for every employee.',
    image: 'assets/images/hris_overview.jpg',
    imageAlt: 'assets/images/hris_directory.jpg',
    extraImages: [
      'assets/images/hris_attendance.jpg',
      'assets/images/hris_approvals.jpg',
      'assets/images/hris_leave.jpg',
      'assets/images/hris_warning.jpg',
    ],
    aspect: 4 / 3,
    tags: [
      'Web App',
      'Supabase',
      'Workflow Automation',
      'Biometric Sync',
      'UAE'
    ],
    languages: [
      Lang('JavaScript', 63.6),
      Lang('TypeScript', 32.9),
      Lang('HTML', 2.4),
      Lang('Other', 1.1),
    ],
    accentColor: Color(0xFF4F46E5),
    status: 'Live',
    browserUrl: 'hris.luxesignature.ae',
    imageLabels: [
      'HR overview',
      'Employee directory',
      'Team attendance',
      'Approvals',
      'Leave request',
      'Attendance warning',
    ],
  ),
];

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return SectionShell(
      maxWidth: 1240,
      backdrop: [
        Positioned(
          left: -w * 0.12,
          top: 240,
          child: const ParallaxShift(
              factor: -0.06, child: Glow(size: 620, color: AppTheme.lilac, opacity: 0.35)),
        ),
        Positioned(
          right: -w * 0.10,
          bottom: 200,
          child: const ParallaxShift(
              factor: 0.07, child: Glow(size: 560, color: AppTheme.blush, opacity: 0.35)),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            number: '03',
            label: 'Recent projects',
            title: 'Things I have',
            accent: 'built.',
          ),
          const SizedBox(height: 48),
          LayoutBuilder(builder: (context, c) {
            final cols = c.maxWidth >= 960 ? 2 : 1;
            const gap = 24.0;
            final cw = (c.maxWidth - gap * (cols - 1)) / cols;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (var i = 0; i < _projects.length; i++)
                  SizedBox(
                    width: cw,
                    child: Reveal(
                      index: (i % cols) + 1,
                      scaleFrom: 0.985,
                      child: _GridCard(project: _projects[i], index: i),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

// ─── One card: gallery on top, the essentials beneath ───────────────────────

class _GridCard extends StatelessWidget {
  final ProjectItem project;
  final int index;
  const _GridCard({required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    final p = project;
    final live = p.status.toLowerCase() == 'live';

    return LiftCard(
      padding: EdgeInsets.zero,
      radius: 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Gallery(project: p),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 22, 26, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('0${index + 1}',
                                    style: GoogleFonts.playfairDisplay(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.mint)),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(p.title,
                                      style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.6,
                                          height: 1.1,
                                          color: AppTheme.textBlack)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(p.subtitle,
                                style: GoogleFonts.inter(
                                    fontSize: 13.5, color: AppTheme.textGray)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      StatusMark(p.status,
                          color: live ? AppTheme.accentGreen : AppTheme.textLight,
                          textColor: live ? const Color(0xFF15803D) : AppTheme.textLight),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    p.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.body(size: 14),
                  ),
                  if (p.note != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 1, 0, 1),
                      decoration: const BoxDecoration(
                          border: Border(left: BorderSide(color: AppTheme.mint, width: 2))),
                      child: Text(p.note!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                              fontSize: 12.5,
                              height: 1.55,
                              fontStyle: FontStyle.italic,
                              color: AppTheme.textGray)),
                    ),
                  ],
                  const SizedBox(height: 18),
                  TagLine(p.tags, separator: p.accentColor, size: 10.5),
                  const SizedBox(height: 18),
                  Container(height: 1, color: AppTheme.border),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(Icons.lock_outline, size: 13, color: AppTheme.textLight),
                      const SizedBox(width: 6),
                      Text('Private repository',
                          style: GoogleFonts.inter(fontSize: 12.5, color: AppTheme.textLight)),
                      const Spacer(),
                      if (p.liveUrl != null)
                        ArrowLink(
                            label: p.browserUrl ?? 'Visit site',
                            onTap: () => html.window.open(p.liveUrl!, '_blank'))
                      else if (p.browserUrl != null)
                        Text(p.browserUrl!,
                            style: GoogleFonts.inter(fontSize: 13, color: AppTheme.textGray)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Gallery: a wide frame that crossfades through the screens ──────────────

class _Gallery extends StatefulWidget {
  final ProjectItem project;
  const _Gallery({required this.project});

  @override
  State<_Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<_Gallery> {
  int _i = 0;
  Timer? _timer;
  bool _hovered = false;

  List<String> get _images => [
        widget.project.image,
        if (widget.project.imageAlt != null) widget.project.imageAlt!,
        ...widget.project.extraImages,
      ];

  @override
  void initState() {
    super.initState();
    _arm();
  }

  void _arm() {
    _timer?.cancel();
    if (_images.length < 2) return;
    _timer = Timer.periodic(const Duration(milliseconds: 4200), (_) {
      if (!_hovered && mounted) setState(() => _i = (_i + 1) % _images.length);
    });
  }

  void _go(int d) {
    setState(() => _i = (_i + d) % _images.length);
    _arm();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final images = _images;
    final labels = p.imageLabels;
    final label = _i < labels.length ? labels[_i] : '';
    final backdrop = p.coverBackdrop ?? AppTheme.paper2;
    // Phone screens sit with a little air around them; everything else fills
    // the frame's width and letterboxes if it is wider than 4:3.
    final pad = p.isMobileApp && !(p.bannerCover && _i == 0) ? 18.0 : 0.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: backdrop),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 650),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: Padding(
                key: ValueKey(_i),
                padding: EdgeInsets.all(pad),
                child: Image.asset(
                  images[_i],
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            if (label.isNotEmpty)
              Positioned(
                left: 14,
                bottom: 14,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(label),
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppTheme.textBlack.withValues(alpha: 0.78),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(label.toUpperCase(),
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            letterSpacing: 1.6,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                ),
              ),
            if (images.length > 1) ...[
              Positioned(
                right: 12,
                bottom: 12,
                child: Row(
                  children: [
                    _Arrow(Icons.arrow_back_rounded, () => _go(-1)),
                    const SizedBox(width: 6),
                    _Arrow(Icons.arrow_forward_rounded, () => _go(1)),
                  ],
                ),
              ),
              // Segment bar along the top edge of the frame.
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Row(
                  children: [
                    for (var k = 0; k < images.length; k++)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _i = k);
                            _arm();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 3,
                            margin: const EdgeInsets.only(right: 2),
                            color: k == _i
                                ? AppTheme.textBlack
                                : AppTheme.textBlack.withValues(alpha: 0.12),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Arrow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _Arrow(this.icon, this.onTap);
  @override
  State<_Arrow> createState() => _ArrowState();
}

class _ArrowState extends State<_Arrow> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.textBlack : Colors.white.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 10, offset: const Offset(0, 3))
            ],
          ),
          child: Icon(widget.icon, size: 16, color: _hovered ? Colors.white : AppTheme.textBlack),
        ),
      ),
    );
  }
}
