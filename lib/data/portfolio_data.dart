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
  static const String phone = '+63 954 442 0970';
  static const String location = 'Bacolod, Negros Occidental, Philippines';

  static const String profileSummary =
      'Software Engineer & Marketing Specialist with a passion for building elegant digital solutions. '
      'Experienced in business process automation, AI-driven systems, Flutter development, '
      'and digital transformation — turning complex workflows into scalable, beautiful products.';

  static const List<String> roles = [
    'Software Engineer',
    'Flutter Developer',
    'Business Solutions Architect',
    'AI & Automation Specialist',
  ];

  static const List<String> technicalSkills = [
    'Flutter & Dart',
    'Microsoft Power Platform',
    'Power Apps',
    'Power Automate',
    'Power BI',
    'Excel VBA',
    'SQL',
    'API Integration',
    'Git',
    'HTML / CSS / JS',
    'CMS Management',
    'Microsoft 365',
  ];

  static const List<String> softSkills = [
    'Business Process Automation',
    'Software Development',
    'AI & Digital Transformation',
    'Real Estate Marketing',
    'Workflow Optimization',
    'Data Analysis & Reporting',
    'IT Administration',
    'Project Coordination',
    'Executive Assistance',
    'Communication & Leadership',
  ];

  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      title: 'Software Engineer (Business Solutions) / Marketing Specialist',
      company: 'Luxe Signature Holiday Homes',
      location: 'Dubai, UAE',
      period: 'Current',
      color: '00D4FF',
      highlights: [
        'Develop web applications and automation tools for operational efficiency',
        'Build AI-driven systems for business insights and decision-making',
        'Manage real estate digital marketing across multiple platforms',
        'Integrate systems, databases, and third-party platforms',
      ],
    ),
    ExperienceItem(
      title: 'Sales Admin & Collections | Operations',
      company: 'Suliter International Building Materials',
      location: 'Dubai, UAE',
      period: '',
      color: '7B2FBE',
      highlights: [
        'Managed purchase orders and supplier negotiations',
        'Generated sales performance and collection status reports',
        'Tracked order fulfillment ensuring on-time delivery',
        'Maintained accurate records for reporting and auditing',
      ],
    ),
    ExperienceItem(
      title: 'DX Solutions Developer',
      company: 'Lexmark Corporation',
      location: 'Philippines',
      period: '',
      color: '00FF88',
      highlights: [
        'Built custom web apps using Microsoft PowerApps for internal workflows',
        'Automated business processes with Power Automate',
        'Created Power BI dashboards for performance tracking',
        'Delivered scalable digital solutions for cross-functional teams',
      ],
    ),
    ExperienceItem(
      title: 'Web and Mobile Developer',
      company: 'GC&C Group of Companies',
      location: 'Philippines',
      period: '',
      color: 'FF6B6B',
      highlights: [
        'Developed a cross-platform Parking Management app using Flutter',
        'Integrated RESTful APIs for real-time data exchange',
        'Implemented state management with Provider pattern',
        'Provided IT support and cybersecurity protocols',
      ],
    ),
    ExperienceItem(
      title: 'Mobile Application Support / Tech Support',
      company: 'Zetta Solutions Inc.',
      location: 'Philippines',
      period: '',
      color: 'FFD93D',
      highlights: [
        'Designed E-Wallet UIs for Modern Jeepney operations in Flutter',
        'Resolved bugs and technical issues in deployed mobile apps',
        'Collaborated on smooth deployment and maintenance of mobile solutions',
      ],
    ),
    ExperienceItem(
      title: 'Internal Business Data Analyst (Intern)',
      company: 'Lear Corporation',
      location: 'Philippines',
      period: '',
      color: 'FF8C42',
      highlights: [
        'Developed VBA scripts and Excel macros to streamline internal processes',
        'Created Power BI dashboards for data-driven decision-making',
        'Delivered actionable insights for weekly team meetings',
      ],
    ),
    ExperienceItem(
      title: 'Virtual Assistant — IT / SEO / Web / Automation',
      company: 'YLifestyle Design and Management',
      location: 'New York, USA (Remote)',
      period: '',
      color: 'C77DFF',
      highlights: [
        'Managed tenant payments, tracking balances in AppFolio',
        'Built Excel reporting with pivot tables and data validation',
        'Provided CEO-level administrative and operational support',
        'Handled SEO, social media management, and website development',
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
    EducationItem(
      degree: 'Science, Technology, Engineering & Mathematics',
      school: 'Sotero B. Cabahug FORUM for Literacy',
      year: '2019',
      icon: '🔬',
    ),
  ];
}
