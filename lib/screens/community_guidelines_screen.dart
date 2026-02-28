import 'package:flutter/material.dart';

class CommunityGuidelinesScreen extends StatelessWidget {
  const CommunityGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rules = <_GuidelineItem>[
      const _GuidelineItem(
        title: 'Respect & Honesty',
        icon: Icons.handshake_rounded,
        body:
            'Provide real and accurate information. Do not post fake requests.',
      ),
      const _GuidelineItem(
        title: 'Medical Responsibility',
        icon: Icons.local_hospital_rounded,
        body: 'Confirm genuine need before posting and avoid misuse.',
      ),
      const _GuidelineItem(
        title: 'Privacy & Safety',
        icon: Icons.privacy_tip_rounded,
        body:
            'Do not share personal data publicly. Use contact features responsibly.',
      ),
      const _GuidelineItem(
        title: 'No Harassment',
        icon: Icons.gavel_rounded,
        body: 'Respect donors and recipients. No abusive behavior is allowed.',
      ),
      const _GuidelineItem(
        title: 'Emergency Disclaimer',
        icon: Icons.warning_amber_rounded,
        body: 'This app does not replace hospital care during emergencies.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Community Guidelines')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Community Guidelines',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Use Blood Link safely and respectfully. These rules support trust and platform safety.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ...rules.map((rule) => _GuidelineCard(item: rule)),
        ],
      ),
    );
  }
}

class _GuidelineCard extends StatelessWidget {
  final _GuidelineItem item;

  const _GuidelineCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Icon(item.icon),
          title: Text(
            item.title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item.body,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuidelineItem {
  final String title;
  final String body;
  final IconData icon;

  const _GuidelineItem({
    required this.title,
    required this.body,
    required this.icon,
  });
}
