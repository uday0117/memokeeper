import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings_controller.dart';

/// Premium Settings screen with modern design
class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Premium App Bar with Gradient
          SliverAppBar.large(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Settings',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.settings_rounded,
                    size: 80,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Appearance Section
                  _buildSectionHeader(
                    'Appearance',
                    Icons.palette_rounded,
                    context,
                  ),
                  const SizedBox(height: 12),
                  _buildPremiumCard(
                    context,
                    child: Obx(() => _buildThemeToggle(context)),
                  ),
                  const SizedBox(height: 32),

                  // App Info Section
                  _buildSectionHeader(
                    'App Information',
                    Icons.info_outline_rounded,
                    context,
                  ),
                  const SizedBox(height: 12),
                  _buildPremiumCard(
                    context,
                    child: Column(
                      children: [
                        _buildInfoTile(
                          context,
                          icon: Icons.note_alt_rounded,
                          title: 'App Name',
                          value: controller.appName,
                          color: Colors.blue,
                        ),
                        _buildDivider(context),
                        _buildInfoTile(
                          context,
                          icon: Icons.code_rounded,
                          title: 'Version',
                          value: controller.appVersion,
                          color: Colors.purple,
                        ),
                        _buildDivider(context),
                        _buildInfoTile(
                          context,
                          icon: Icons.description_outlined,
                          title: 'Description',
                          value: 'A simple and elegant offline notes app',
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Features Section
                  _buildSectionHeader('Features', Icons.star_rounded, context),
                  const SizedBox(height: 12),
                  _buildPremiumCard(
                    context,
                    child: Column(
                      children: [
                        _buildFeatureTile(
                          context,
                          icon: Icons.cloud_off_rounded,
                          title: 'Offline Storage',
                          description: 'All notes saved locally',
                          color: Colors.green,
                        ),
                        _buildDivider(context),
                        _buildFeatureTile(
                          context,
                          icon: Icons.search_rounded,
                          title: 'Smart Search',
                          description: 'Real-time note search',
                          color: Colors.blue,
                        ),
                        _buildDivider(context),
                        _buildFeatureTile(
                          context,
                          icon: Icons.push_pin_rounded,
                          title: 'Pin Notes',
                          description: 'Keep important notes at top',
                          color: Colors.amber,
                        ),
                        _buildDivider(context),
                        _buildFeatureTile(
                          context,
                          icon: Icons.notifications_active_rounded,
                          title: 'Reminders',
                          description: 'Set notifications for notes',
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Developer Info with Premium Design
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.1),
                            Theme.of(context).primaryColor.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Developed with',
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.grey[700],
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'by',
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.grey[700],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'UK Solutions',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build premium section header
  Widget _buildSectionHeader(
    String title,
    IconData icon,
    BuildContext context,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
      ],
    );
  }

  /// Build premium card container
  Widget _buildPremiumCard(BuildContext context, {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(20), child: child),
    );
  }

  /// Build theme toggle with premium design
  Widget _buildThemeToggle(BuildContext context) {
    final isDark = controller.isDarkMode.value;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDark ? 'Dark Mode' : 'Light Mode',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Switch between light and dark theme',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Switch(
            value: isDark,
            onChanged: (_) => controller.toggleTheme(),
            activeThumbColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  /// Build info tile
  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build feature tile
  Widget _buildFeatureTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: color, size: 16),
          ),
        ],
      ),
    );
  }

  /// Build divider
  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: Colors.grey.withOpacity(0.2),
    );
  }
}
