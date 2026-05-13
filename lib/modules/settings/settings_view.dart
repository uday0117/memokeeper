import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings_controller.dart';

/// Settings screen view
class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Appearance section
          _buildSectionTitle('Appearance'),
          Card(
            child: Obx(
              () => SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Switch between light and dark theme'),
                secondary: Icon(
                  controller.isDarkMode.value
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                ),
                value: controller.isDarkMode.value,
                onChanged: (_) => controller.toggleTheme(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // About section
          _buildSectionTitle('About'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_rounded),
                  title: const Text('App Name'),
                  subtitle: Text(controller.appName),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.code_rounded),
                  title: const Text('Version'),
                  subtitle: Text(controller.appVersion),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.description_rounded),
                  title: const Text('Description'),
                  subtitle: const Text(
                    'A simple and elegant offline notes app',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Features section
          _buildSectionTitle('Features'),
          Card(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                  ),
                  title: Text('Offline Storage'),
                  subtitle: Text('All notes saved locally'),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                  ),
                  title: Text('Search'),
                  subtitle: Text('Real-time note search'),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                  ),
                  title: Text('Pin Notes'),
                  subtitle: Text('Keep important notes at top'),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                  ),
                  title: Text('Reminders'),
                  subtitle: Text('Set notifications for notes'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Developer info
          Center(
            child: Column(
              children: [
                Text(
                  'Developed with ❤️',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  'UK Solutions',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// Build section title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
