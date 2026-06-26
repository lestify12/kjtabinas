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

class ProjectItem {
  final String title;
  final String subtitle;
  final String description;
  final String image;
  final String? imageAlt;
  final List<String> extraImages;
  final List<String> tags;
  final Color accentColor;
  final String status;
  final bool isMobileApp;
  final bool isCodeProject;
  final String? liveUrl;
  final String? browserUrl;

  const ProjectItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    this.imageAlt,
    this.extraImages = const [],
    required this.tags,
    required this.accentColor,
    required this.status,
    this.isMobileApp = false,
    this.isCodeProject = false,
    this.liveUrl,
    this.browserUrl,
  });
}

const _projects = [
  ProjectItem(
    title: 'Luxe PM',
    subtitle: 'Property Management Platform',
    description:
        'An all-in-one platform for UAE property managers. Features automatic rent collection, '
        'digital tenant onboarding, contract management, and real-time property analytics — '
        'built to streamline Luxe Signature Holiday Homes operations.',
    image: 'assets/images/luxe_pm.png',
    imageAlt: 'assets/images/luxe_pm_dashboard.png',
    tags: ['HTML/CSS/JS', 'Supabase', 'Cloudflare', 'Real Estate', 'UAE'],
    accentColor: Color(0xFF00D4FF),
    status: 'Live',
  ),
  ProjectItem(
    title: 'Luxe HRIS',
    subtitle: 'Human Resource Information System',
    description:
        'A complete HRIS built from scratch for Luxe Signature. Handles employee records, '
        'biometric attendance sync, leave and cash-advance requests, approval workflows, '
        'payroll, and recruitment — with role-based dashboards and self-service for every employee.',
    image: 'assets/images/hris_dashboard.png',
    tags: ['Web App', 'Supabase', 'Workflow Automation', 'Biometric Sync', 'UAE'],
    accentColor: Color(0xFF4F46E5),
    status: 'Live',
    browserUrl: 'hris.luxesignature.ae',
  ),
  ProjectItem(
    title: 'Excel VBA Automation',
    subtitle: 'Quotation Management System',
    description:
        'Leverages Visual Basic for Applications (VBA) within Microsoft Excel to automate '
        'quotation generation for Suliter International Building Materials. Features dynamic data '
        'handling, automated pricing calculations, and user-friendly interfaces — significantly '
        'reducing turnaround time and improving consistency in client communications.',
    image: '',
    tags: ['Excel VBA', 'Macros', 'Automation', 'Microsoft 365'],
    accentColor: Color(0xFF16A34A),
    status: 'Live',
    isCodeProject: true,
  ),
  ProjectItem(
    title: 'LuvPark & LuvPay',
    subtitle: 'Automated Parking + Consumer Payment App',
    description:
        'Two Flutter apps built for GC&C Group of Companies under Cleverminds Digital Solutions Inc. '
        'LuvPark lets operators manage parking slots in real time, while LuvPay is the consumer-facing '
        'app — find a space, book it, and pay cashlessly, all in one flow.',
    image: 'assets/images/luvpark.png',
    extraImages: [
      'assets/images/luvpark1.png',
      'assets/images/luvpark3.png',
    ],
    tags: ['Flutter', 'Mobile App', 'Oracle', 'Philippines'],
    accentColor: Color(0xFF2563EB),
    status: 'Live',
    isMobileApp: true,
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
            const SectionLabel(number: '02', title: 'Recent Projects'),
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
                  : IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 6,
                            child:
                                _Screenshot(project: widget.project),
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
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      _next();
    });
  }

  Future<void> _next() async {
    final images = _images;
    if (images.length < 2) return;
    await _fadeCtrl.reverse();
    if (!mounted) return;
    setState(() => _index = (_index + 1) % images.length);
    await _fadeCtrl.forward();
    _startTimer();
  }

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
    // Code placeholder for projects without screenshots
    if (widget.project.isCodeProject) {
      return SizedBox(
        height: 360,
        child: Container(
          color: const Color(0xFF0F1117),
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Editor title bar
              Row(
                children: [
                  Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFF5F57))),
                  const SizedBox(width: 6),
                  Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFFBD2E))),
                  const SizedBox(width: 6),
                  Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF28C840))),
                  const SizedBox(width: 14),
                  Text('QuotationManager.bas', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF6B7280))),
                ],
              ),
              const SizedBox(height: 20),
              ..._codeLines.map((line) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: RichText(text: TextSpan(children: line)),
              )),
            ],
          ),
        ),
      );
    }

    // Phone mockup for mobile apps
    if (widget.project.isMobileApp) {
      final images = _images;
      final img = images[_index];
      return Container(
        height: 384,
        color: AppTheme.bgLight,
        child: Stack(
          alignment: const Alignment(0, -0.22),
          children: [
            _PhoneMockup(
              accentColor: widget.project.accentColor,
              child: FadeTransition(
                opacity: _fade,
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -0.78),
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFEEF2FF),
                    child: Center(
                      child: Icon(Icons.smartphone_rounded,
                          size: 48, color: widget.project.accentColor),
                    ),
                  ),
                ),
              ),
            ),
            // Dot indicators below phone
            if (images.length > 1)
              Positioned(
                bottom: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (i) {
                    final active = i == _index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: active ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: active
                            ? widget.project.accentColor
                            : AppTheme.textLight.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
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

          // Dot indicators
          if (images.length > 1)
            Positioned(
              bottom: 14,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (i) {
                  final active = i == _index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: active ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: active
                          ? AppTheme.textBlack
                          : AppTheme.textLight.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ),

          // Label chip bottom-right
          if (images.length > 1)
            Positioned(
              bottom: 10,
              right: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.bgCream.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Text(
                  _index < _labels.length ? _labels[_index] : '',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppTheme.textGray,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── VBA code snippet lines ──────────────────────────────────────────────────

TextSpan _kw(String s) => TextSpan(text: s, style: const TextStyle(color: Color(0xFF569CD6), fontSize: 13, fontFamily: 'monospace'));
TextSpan _fn(String s) => TextSpan(text: s, style: const TextStyle(color: Color(0xFFDCDCAA), fontSize: 13, fontFamily: 'monospace'));
TextSpan _st(String s) => TextSpan(text: s, style: const TextStyle(color: Color(0xFFCE9178), fontSize: 13, fontFamily: 'monospace'));
TextSpan _cm(String s) => TextSpan(text: s, style: const TextStyle(color: Color(0xFF6A9955), fontSize: 13, fontFamily: 'monospace'));
TextSpan _tx(String s) => TextSpan(text: s, style: const TextStyle(color: Color(0xFFD4D4D4), fontSize: 13, fontFamily: 'monospace'));

final _codeLines = <List<TextSpan>>[
  [_cm("' Excel VBA — Quotation Automation")],
  [_tx("")],
  [_kw("Sub "), _fn("GenerateQuotation"), _tx("()")],
  [_tx("  "), _kw("Dim "), _tx("ws "), _kw("As "), _tx("Worksheet")],
  [_tx("  "), _kw("Dim "), _tx("total "), _kw("As "), _tx("Double")],
  [_tx("  "), _kw("Set "), _tx("ws = ThisWorkbook.Sheets("), _st('"Quotation"'), _tx(")")],
  [_tx("")],
  [_tx("  "), _cm("' Auto-fill client & pricing data")],
  [_tx("  "), _fn("ApplyPricingRules"), _tx(" ws, unitQty, discount")],
  [_tx("  "), _fn("FormatQuotationSheet"), _tx(" ws")],
  [_tx("  "), _fn("ExportToPDF"), _tx(" ws, clientName")],
  [_tx("")],
  [_tx("  MsgBox "), _st('"Quotation generated!"'), _tx(", vbInformation")],
  [_kw("End Sub")],
];

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
              color: AppTheme.accentGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppTheme.accentGreen.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.accentGreen,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  project.status,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppTheme.accentGreen,
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
