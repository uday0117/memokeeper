import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'onboarding_controller.dart';

/// Premium card-based onboarding screen
class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F0F0F)
          : const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header with skip button
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF1A1A1A),
                    ),
                  ),
                  TextButton(
                    onPressed: controller.skip,
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).primaryColor.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Page View with cards
            Expanded(
              child: PageView(
                controller: controller.pageController,
                children: const [
                  _OnboardingCard(
                    gradient: LinearGradient(
                      colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    ),
                    icon: Icons.edit_note_rounded,
                    title: 'Capture Your Thoughts',
                    description:
                        'Create beautiful notes with rich formatting, reminders, and more. Your ideas deserve a premium home.',
                  ),
                  _OnboardingCard(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF6B6B), Color(0xFFFFD93D)],
                    ),
                    icon: Icons.palette_rounded,
                    title: 'Colorful & Vibrant',
                    description:
                        'Choose from 10 stunning gradient colors for your notes. Make every note visually distinct.',
                  ),
                  _OnboardingCard(
                    gradient: LinearGradient(
                      colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
                    ),
                    icon: Icons.category_rounded,
                    title: 'Stay Organized',
                    description:
                        'Organize notes with categories, tags, and colors. Filter and find what you need instantly.',
                  ),
                  _OnboardingCard(
                    gradient: LinearGradient(
                      colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
                    ),
                    icon: Icons.offline_bolt_rounded,
                    title: 'Offline & Private',
                    description:
                        'Your notes are stored securely on your device. No internet required. Your privacy matters.',
                  ),
                ],
              ),
            ),

            // Bottom navigation
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page indicators
                  Obx(
                    () => Row(
                      children: List.generate(
                        controller.totalPages,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 8),
                          width: controller.currentPage.value == index ? 32 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == index
                                ? Theme.of(context).primaryColor
                                : (isDark
                                      ? Colors.white.withOpacity(0.3)
                                      : Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Next/Get Started button
                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).primaryColor.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: controller.nextPage,
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  controller.currentPage.value ==
                                          controller.totalPages - 1
                                      ? 'Get Started'
                                      : 'Next',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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

/// Individual onboarding card
class _OnboardingCard extends StatelessWidget {
  final Gradient gradient;
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingCard({
    required this.gradient,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withOpacity(0.4),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with circle background
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 80, color: Colors.white),
              ),
              const SizedBox(height: 50),

              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Description
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.95),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
