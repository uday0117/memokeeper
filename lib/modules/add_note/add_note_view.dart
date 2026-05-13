import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/note_colors.dart';
import '../../core/utils/date_formatter.dart';
import 'add_note_controller.dart';

/// Premium Add/Edit note screen with modern design
class AddNoteView extends GetView<AddNoteController> {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.isEditMode.value ? 'Edit Note' : 'Create Note',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          Obx(
            () => controller.isSaving.value
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      onPressed: controller.saveNote,
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title field with premium design
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    hintText: 'Note Title',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.title_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: controller.validateTitle,
                ),
              ),
              const SizedBox(height: 20),

              // Content field with premium design
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: controller.contentController,
                  decoration: InputDecoration(
                    hintText: 'Write your thoughts here...',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, top: 12),
                      child: Icon(
                        Icons.edit_note_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    contentPadding: const EdgeInsets.all(20),
                  ),
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: isDark ? Colors.grey[300] : Colors.grey[800],
                  ),
                  maxLines: 12,
                  minLines: 12,
                  textInputAction: TextInputAction.newline,
                  validator: controller.validateContent,
                ),
              ),
              const SizedBox(height: 24),

              // Category selector
              _buildCategorySection(context),
              const SizedBox(height: 24),

              // Tags input
              _buildTagsSection(context),
              const SizedBox(height: 24),

              // Color picker
              _buildColorSection(context),
              const SizedBox(height: 24),

              // Reminder section with premium design
              _buildReminderSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Build vibrant category selector
  Widget _buildCategorySection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.withOpacity(0.2),
                      Colors.purple.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.category_rounded,
                  color: Colors.purple,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Category',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...NoteCategories.categories.map((category) {
                return Obx(() {
                  final isSelected =
                      controller.selectedCategory.value == category.name;
                  return GestureDetector(
                    onTap: () => controller.setCategory(
                      isSelected ? null : category.name,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [
                                  Color(category.colorCode),
                                  Color(category.colorCode).withOpacity(0.7),
                                ],
                              )
                            : null,
                        color: isSelected
                            ? null
                            : (isDark
                                  ? const Color(0xFF2D2D2D)
                                  : Colors.grey[100]),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Color(
                                    category.colorCode,
                                  ).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            category.icon,
                            size: 18,
                            color: isSelected
                                ? Colors.white
                                : Color(category.colorCode),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            category.name,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : (isDark ? Colors.white : Colors.black87),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  /// Build vibrant tags input section
  Widget _buildTagsSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.withOpacity(0.2),
                      Colors.orange.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.local_offer_rounded,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Tags',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.tagController,
                  decoration: InputDecoration(
                    hintText: 'Add a tag...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: isDark
                        ? const Color(0xFF2D2D2D)
                        : Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: controller.addTag,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.deepOrange],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add_rounded, color: Colors.white),
                  onPressed: () {
                    controller.addTag(controller.tagController.text);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() {
            if (controller.tags.isEmpty) {
              return Text(
                'No tags yet',
                style: TextStyle(color: Colors.grey[500], fontSize: 13),
              );
            }
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: controller.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.tag, size: 14, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => controller.removeTag(tag),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  /// Build vibrant color picker section
  Widget _buildColorSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.pink.withOpacity(0.2),
                      Colors.pink.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.palette_rounded,
                  color: Colors.pink,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Color',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: NoteColors.colorSchemes.map((scheme) {
              return Obx(() {
                final isSelected =
                    controller.selectedColorCode.value ==
                    scheme.primaryColor.value;
                return GestureDetector(
                  onTap: () => controller.setColor(
                    isSelected ? null : scheme.primaryColor.value,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: scheme.gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: scheme.primaryColor.withOpacity(0.4),
                          blurRadius: isSelected ? 12 : 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 28,
                          )
                        : null,
                  ),
                );
              });
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Build premium reminder section
  Widget _buildReminderSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.2),
                      Theme.of(context).primaryColor.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.notifications_active_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Set Reminder',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() {
            if (controller.reminderDate.value != null) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.1),
                      Theme.of(context).primaryColor.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.alarm_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reminder Set',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormatter.formatDateTime(
                              controller.reminderDate.value!,
                            ),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                      onPressed: controller.clearReminder,
                    ),
                  ],
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () => controller.pickReminderDate(context),
                icon: const Icon(Icons.add_alarm_rounded, size: 22),
                label: const Text(
                  'Set Reminder',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
