import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../constants.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topDonors = [
      {'name': 'Hassan Ali', 'score': '1,250', 'avatar': 'H'},
      {'name': 'Ayesha Khan', 'score': '2,100', 'avatar': 'A'},
      {'name': 'Omar Sheikh', 'score': '1,100', 'avatar': 'O'},
    ];

    final restDonors = [
      {'rank': '4', 'name': 'Bilal Ahmed', 'score': '950', 'avatar': 'B'},
      {'rank': '5', 'name': 'Sana Javed', 'score': '880', 'avatar': 'S'},
      {'rank': '6', 'name': 'Usman Tariq', 'score': '750', 'avatar': 'U'},
      {'rank': '7', 'name': 'Noor Fatima', 'score': '620', 'avatar': 'N'},
      {'rank': '8', 'name': 'Hamza Lodhi', 'score': '540', 'avatar': 'H'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Leaderboard', style: AppTextStyles.heading2),
                  _buildTabSwitcher(),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Podium
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _PodiumItem(name: topDonors[0]['name']!, score: topDonors[0]['score']!, rank: 2, color: Colors.grey, delay: 400),
                  const SizedBox(width: 12),
                  _PodiumItem(name: topDonors[1]['name']!, score: topDonors[1]['score']!, rank: 1, color: Colors.amber, delay: 200, isMain: true),
                  const SizedBox(width: 12),
                  _PodiumItem(name: topDonors[2]['name']!, score: topDonors[2]['score']!, rank: 3, color: Colors.brown, delay: 600),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Rest of list
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  border: Border.all(color: Colors.white.withOpacity(0.03)),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 32, bottom: 20),
                  itemCount: restDonors.length,
                  itemBuilder: (context, i) {
                    final d = restDonors[i];
                    return FadeInUp(
                      delay: Duration(milliseconds: 100 * i),
                      child: _LeaderboardTile(
                        rank: d['rank']!,
                        name: d['name']!,
                        score: d['score']!,
                        avatar: d['avatar']!,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          _TabItem(label: 'Global', isActive: true),
          _TabItem(label: 'City', isActive: false),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;
  const _TabItem({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label, style: AppTextStyles.caption.copyWith(color: isActive ? Colors.white : Colors.white24, fontWeight: FontWeight.bold)),
    );
  }
}

class _PodiumItem extends StatelessWidget {
  final String name, score;
  final int rank, delay;
  final Color color;
  final bool isMain;

  const _PodiumItem({required this.name, required this.score, required this.rank, required this.color, required this.delay, this.isMain = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FadeInUp(
        delay: Duration(milliseconds: delay),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: isMain ? 80 : 64,
                  height: isMain ? 80 : 64,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  child: Container(
                    decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
                    child: Center(child: Text(name[0], style: TextStyle(color: color, fontSize: isMain ? 24 : 18, fontWeight: FontWeight.bold))),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  child: Text('$rank', style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(name.split(' ')[0], style: AppTextStyles.subtitle2.copyWith(fontSize: 12)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: color.withAlpha(20), borderRadius: BorderRadius.circular(8)),
              child: Text(score, style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeaderboardTile extends StatelessWidget {
  final String rank, name, score, avatar;
  const _LeaderboardTile({required this.rank, required this.name, required this.score, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(width: 24, child: Text(rank, style: AppTextStyles.caption.copyWith(color: Colors.white24, fontWeight: FontWeight.bold))),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
            child: Center(child: Text(avatar, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(name, style: AppTextStyles.body2)),
          Text(score, style: AppTextStyles.subtitle2.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}
