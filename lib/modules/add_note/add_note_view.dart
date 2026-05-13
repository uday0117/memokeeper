import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

              // Reminder section with premium design
              _buildReminderSection(context),
            ],
          ),
        ),
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
