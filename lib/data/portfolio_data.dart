class ExperienceItem {
  final String title;
  final String company;
  final String location;
  final String period;
  final List<String> highlights;
  final String color;

  const ExperienceItem({
    required this.title,
    required this.company,
    required this.location,
    required this.period,
    required this.highlights,
    required this.color,
  });
}

class EducationItem {
  final String degree;
  final String school;
  final String year;
  final String icon;

  const EducationItem({
    required this.degree,
    required this.school,
    required this.year,
    required this.icon,
  });
}

class PortfolioData {
  static const String name = 'Krystler John Tabinas';
  static const String email = 'krystlertabinas1999@gmail.com';
  static const String phone = '+971 55 933 9921';
  static const String location = 'Dubai, United Arab Emirates';

  static const String profileSummary =
      'AI Automation Engineer specializing in designing and deploying production-ready '
      'workflow automations, AI agents, and API integrations. I build internal business '
      'systems, automate operational workflows, and rapidly ship solutions using modern '
      'AI-assisted development tools like Claude Code, ChatGPT, and Gemini — owning '
      'projects end-to-end with minimal supervision.';

  static const List<String> roles = [
    'AI Automation Engineer',
    'Workflow Automation Specialist',
    'AI Agent Developer',
    'Low-Code Developer',
  ];

  static const List<String> technicalSkills = [
    'Claude Code',
    'AI Agents',
    'MCP',
    'Workflow Automation',
    'REST APIs',
    'Webhooks',
    'n8n',
    'Power Platform',
    'Flutter',
    'Python',
    'JavaScript',
    'Power BI',
  ];

  static const List<String> softSkills = [
    'Business Process Automation',
    'AI-Assisted Development',
    'API Integration',
    'Prompt Engineering',
    'Data Analysis & Reporting',
    'IT Administration',
    'Requirements Gathering',
    'End-to-End Ownership',
    'Process Documentation',
    'Communication & Collaboration',
  ];

  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      title: 'AI Automation Engineer | Business Systems Engineer',
      company: 'Luxe Signature Holiday Homes',
      location: 'Dubai, UAE',
      period: 'Dec 2025 — Present',
      color: '00D4FF',
      highlights: [
        'Designed and built a complete Property Management System for holiday homes and long-term rentals',
        'Created modules for leases, tenant onboarding, payments, invoices, approvals, dashboards, and reporting',
        'Designed and developed a full HRIS from scratch — attendance sync, leave, payroll, records, and self-service',
        'Built workflow automations and AI agents using Claude Code, ChatGPT, and Model Context Protocol (MCP)',
        'Integrated REST APIs, webhooks, databases, and cloud storage to eliminate manual processes',
      ],
    ),
    ExperienceItem(
      title: 'Business Systems & IT Administrator',
      company: 'Suliter International Building Materials Trading L.L.C',
      location: 'Dubai, UAE',
      period: 'Apr 2025 — Dec 2025',
      color: 'FF6B35',
      highlights: [
        'Developed internal automation tools that reduced manual administrative work',
        'Built approval workflows, document generation, and reporting systems for operations',
        'Created business apps to streamline quotations, purchase orders, inventory, and collections',
        'Automated repetitive Excel processes using formulas, VBA, and workflow automation',
        'Maintained company IT infrastructure, user accounts, networks, and business systems',
      ],
    ),
    ExperienceItem(
      title: 'IT Administrator / Flutter Developer',
      company: 'GC&C Group — Cleverminds Digital Solutions Inc.',
      location: 'Philippines',
      period: 'Feb 2024 — Feb 2025',
      color: '2563EB',
      highlights: [
        'Built a cross-platform Parking Management app in Flutter with real-time availability and QR-based access',
        'Integrated REST APIs and backend services for real-time data synchronization',
        'Developed responsive UIs and optimized app performance for Android and iOS',
        'Implemented state management, testing, debugging, and version control',
        'Administered company IT infrastructure and provided technical support',
      ],
    ),
    ExperienceItem(
      title: 'DX Solutions Developer (Power Platform)',
      company: 'Lexmark International Philippines',
      location: 'Philippines',
      period: 'Jul 2023 — Dec 2023',
      color: '16A34A',
      highlights: [
        'Built enterprise business apps with Microsoft Power Apps to digitize internal processes',
        'Automated workflows with Power Automate, cutting manual effort across departments',
        'Developed interactive Power BI dashboards for real-time reporting and KPI tracking',
        'Integrated apps with Microsoft 365, SharePoint, Excel, and SQL databases',
        'Collaborated with cross-functional teams to deliver scalable low-code solutions',
      ],
    ),
    ExperienceItem(
      title: 'IT Operations & Automation Specialist — Virtual Assistant',
      company: 'YLifestyle Design & Management',
      location: 'Remote — US Client',
      period: 'Feb 2023 — Apr 2025',
      color: 'C77DFF',
      highlights: [
        'Administered AppFolio and maintained accurate tenant, lease, owner, and financial records',
        'Automated operational reports, KPI dashboards, and owner statements using Microsoft Excel',
        'Developed and maintained internal websites, business tools, and process improvements',
        'Built automated reporting for collections, occupancy, and financial performance',
        'Managed IT operations, user support, and SEO/website updates for remote teams',
      ],
    ),
  ];

  static const List<EducationItem> education = [
    EducationItem(
      degree: 'BS Computer Engineering',
      school: 'Cebu Institute of Technology - University',
      year: '2023',
      icon: '🎓',
    ),
  ];
}
