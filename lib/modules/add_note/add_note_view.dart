import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/date_formatter.dart';
import 'add_note_controller.dart';

/// Add/Edit note screen view
class AddNoteView extends GetView<AddNoteController> {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(controller.isEditMode.value ? 'Edit Note' : 'Add Note'),
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
                : IconButton(
                    icon: const Icon(Icons.check_rounded),
                    onPressed: controller.saveNote,
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title field
              TextFormField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  prefixIcon: Icon(Icons.title_rounded),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textInputAction: TextInputAction.next,
                validator: controller.validateTitle,
              ),
              const SizedBox(height: 16),

              // Content field
              TextFormField(
                controller: controller.contentController,
                decoration: const InputDecoration(
                  hintText: 'Write your note here...',
                  prefixIcon: Icon(Icons.notes_rounded),
                  alignLabelWithHint: true,
                ),
                maxLines: 15,
                textInputAction: TextInputAction.newline,
                validator: controller.validateContent,
              ),
              const SizedBox(height: 24),

              // Reminder section
              _buildReminderSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Build reminder section
  Widget _buildReminderSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.alarm_rounded),
                const SizedBox(width: 8),
                const Text(
                  'Reminder',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(() {
              if (controller.reminderDate.value != null) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          DateFormatter.formatDateTime(
                            controller.reminderDate.value!,
                          ),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: controller.clearReminder,
                    ),
                  ],
                );
              }

              return ElevatedButton.icon(
                onPressed: () => controller.pickReminderDate(context),
                icon: const Icon(Icons.add_alarm_rounded),
                label: const Text('Set Reminder'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
