import 'package:bloodbanks/widgets/theme_toggle.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emergencyAlertsEnabled = true;
  bool _soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: ThemeModeSelector(),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                  title: const Text('Notifications'),
                  subtitle: const Text(
                    'Receive app updates and request responses',
                  ),
                ),
                const Divider(height: 0),
                SwitchListTile(
                  value: _emergencyAlertsEnabled,
                  onChanged: (value) {
                    setState(() => _emergencyAlertsEnabled = value);
                  },
                  title: const Text('Emergency Alerts'),
                  subtitle: const Text(
                    'Priority alerts for urgent blood requests',
                  ),
                ),
                const Divider(height: 0),
                SwitchListTile(
                  value: _soundEnabled,
                  onChanged: (value) {
                    setState(() => _soundEnabled = value);
                  },
                  title: const Text('Sound'),
                  subtitle: const Text(
                    'Enable sound for alerts and confirmations',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.lock_outline_rounded),
                  title: Text('Privacy'),
                  subtitle: Text(
                    'Manage data visibility and safety preferences',
                  ),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(Icons.help_outline_rounded),
                  title: Text('Help & Support'),
                  subtitle: Text(
                    'Get assistance with account and blood requests',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
