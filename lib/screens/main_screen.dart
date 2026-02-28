import 'package:bloodbanks/screens/request_blood_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'community_chat_screen.dart';
import 'community_guidelines_screen.dart';
import 'dashboard_screen.dart';
import 'donor_ranking_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

enum _DrawerDestination {
  home,
  request,
  donorRanking,
  communityChat,
  communityGuidelines,
  profile,
  settings,
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    const DashboardScreen(),
    const RequestBloodScreen(showAppBar: false),
    const ProfileScreen(),
  ];

  final List<String> _titles = ['Home', 'Request Blood', 'Profile'];
  int _currentIndex = 0;
  _DrawerDestination _activeDrawerDestination = _DrawerDestination.home;

  void _syncDrawerWithTab() {
    if (_currentIndex == 0) {
      _activeDrawerDestination = _DrawerDestination.home;
    } else if (_currentIndex == 1) {
      _activeDrawerDestination = _DrawerDestination.request;
    } else {
      _activeDrawerDestination = _DrawerDestination.profile;
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _syncDrawerWithTab();
    });
  }

  Future<void> _openRanking() async {
    Navigator.of(context).pop();
    setState(() => _activeDrawerDestination = _DrawerDestination.donorRanking);
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const DonorRankingScreen()));
    if (mounted) {
      setState(_syncDrawerWithTab);
    }
  }

  Future<void> _openCommunityChat() async {
    Navigator.of(context).pop();
    setState(() => _activeDrawerDestination = _DrawerDestination.communityChat);
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 260),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CommunityChatScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(0.0, 0.04),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: slide, child: child),
          );
        },
      ),
    );
    if (mounted) {
      setState(_syncDrawerWithTab);
    }
  }

  Future<void> _openGuidelines() async {
    Navigator.of(context).pop();
    setState(
      () => _activeDrawerDestination = _DrawerDestination.communityGuidelines,
    );
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CommunityGuidelinesScreen()),
    );
    if (mounted) {
      setState(_syncDrawerWithTab);
    }
  }

  Future<void> _openSettings() async {
    Navigator.of(context).pop();
    setState(() => _activeDrawerDestination = _DrawerDestination.settings);
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
    if (mounted) {
      setState(_syncDrawerWithTab);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: 36,
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          tooltip: 'Open menu',
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              _DrawerHeader(isDarkMode: isDarkMode),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    _DrawerNavItem(
                      icon: Icons.home_rounded,
                      title: 'Home',
                      selected:
                          _activeDrawerDestination == _DrawerDestination.home,
                      onTap: () {
                        Navigator.of(context).pop();
                        _onTabTapped(0);
                      },
                    ),
                    _DrawerNavItem(
                      icon: Icons.bloodtype_rounded,
                      title: 'Request Blood',
                      selected:
                          _activeDrawerDestination ==
                          _DrawerDestination.request,
                      onTap: () {
                        Navigator.of(context).pop();
                        _onTabTapped(1);
                      },
                    ),
                    _DrawerNavItem(
                      icon: Icons.emoji_events_rounded,
                      title: 'Donor Ranking',
                      selected:
                          _activeDrawerDestination ==
                          _DrawerDestination.donorRanking,
                      onTap: _openRanking,
                    ),
                    _DrawerNavItem(
                      icon: Icons.chat_bubble_rounded,
                      title: 'Community Chat',
                      selected:
                          _activeDrawerDestination ==
                          _DrawerDestination.communityChat,
                      onTap: _openCommunityChat,
                    ),
                    _DrawerNavItem(
                      icon: Icons.policy_rounded,
                      title: 'Community Guidelines',
                      selected:
                          _activeDrawerDestination ==
                          _DrawerDestination.communityGuidelines,
                      onTap: _openGuidelines,
                    ),
                    _DrawerNavItem(
                      icon: Icons.person_rounded,
                      title: 'Profile',
                      selected:
                          _activeDrawerDestination ==
                          _DrawerDestination.profile,
                      onTap: () {
                        Navigator.of(context).pop();
                        _onTabTapped(2);
                      },
                    ),
                    _DrawerNavItem(
                      icon: Icons.settings_rounded,
                      title: 'Settings',
                      selected:
                          _activeDrawerDestination ==
                          _DrawerDestination.settings,
                      onTap: _openSettings,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Theme.of(context).hintColor,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bloodtype_rounded),
                label: 'Request',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final bool isDarkMode;

  const _DrawerHeader({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [const Color(0xFF35070D), Colors.black]
              : [const Color(0xFFFFCDD2), const Color(0xFFE57373)],
        ),
        boxShadow: isDarkMode
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: AppColors.primary, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            'John Doe',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _MetaChip(label: 'O+', icon: Icons.water_drop_rounded),
              _MetaChip(label: '12 Donations', icon: Icons.favorite_rounded),
              _MetaChip(label: 'Rank #4', icon: Icons.military_tech_rounded),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _MetaChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerNavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool selected;

  const _DrawerNavItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = selected
        ? AppColors.primary
        : (Theme.of(context).brightness == Brightness.dark
              ? Colors.white70
              : Colors.black87);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        minVerticalPadding: 10,
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected
                ? AppColors.primary
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: selected ? AppColors.primary.withValues(alpha: 0.1) : null,
        selected: selected,
        onTap: onTap,
      ),
    );
  }
}
