import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/note_model.dart';
import '../../data/services/hive_service.dart';
import '../../data/services/notification_service.dart';

/// Add/Edit note controller
class AddNoteController extends GetxController {
  final HiveService _hiveService = HiveService();
  final NotificationService _notificationService = NotificationService();

  // Text controllers
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Observables
  final Rx<DateTime?> reminderDate = Rx<DateTime?>(null);
  final RxBool isEditMode = false.obs;
  final RxString noteId = ''.obs;
  final RxBool isSaving = false.obs;

  // New organization fields
  final Rxn<String> selectedCategory = Rxn<String>();
  final RxList<String> tags = <String>[].obs;
  final Rxn<int> selectedColorCode = Rxn<int>();
  final tagController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _checkEditMode();
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    tagController.dispose();
    super.onClose();
  }

  /// Check if in edit mode and load existing note
  void _checkEditMode() {
    final args = Get.arguments;
    if (args != null && args is NoteModel) {
      isEditMode.value = true;
      noteId.value = args.id;
      titleController.text = args.title;
      contentController.text = args.content;
      reminderDate.value = args.reminderDate;
      selectedCategory.value = args.category;
      tags.value = args.tags ?? [];
      selectedColorCode.value = args.colorCode;
    }
  }

  /// Save note
  Future<void> saveNote() async {
    if (!formKey.currentState!.validate()) return;

    isSaving.value = true;

    try {
      final now = DateTime.now();
      final id = isEditMode.value
          ? noteId.value
          : now.millisecondsSinceEpoch.toString();

      final note = NoteModel(
        id: id,
        title: titleController.text.trim(),
        content: contentController.text.trim(),
        createdAt: isEditMode.value
            ? _hiveService.getNoteById(id)!.createdAt
            : now,
        updatedAt: now,
        isPinned: isEditMode.value
            ? _hiveService.getNoteById(id)!.isPinned
            : false,
        reminderDate: reminderDate.value,
        category: selectedCategory.value,
        tags: tags.isNotEmpty ? tags : null,
        colorCode: selectedColorCode.value,
      );

      if (isEditMode.value) {
        await _hiveService.updateNote(note);
      } else {
        await _hiveService.addNote(note);
      }

      // Schedule notification if reminder is set
      if (reminderDate.value != null &&
          reminderDate.value!.isAfter(DateTime.now())) {
        await _notificationService.scheduleNotification(
          id: id.hashCode,
          title: 'Reminder: ${note.title}',
          body: note.content.isEmpty
              ? 'You have a note reminder'
              : note.content.substring(
                  0,
                  note.content.length > 100 ? 100 : note.content.length,
                ),
          scheduledDate: reminderDate.value!,
        );
      } else if (reminderDate.value == null && isEditMode.value) {
        // Cancel notification if reminder was removed
        await _notificationService.cancelNotification(id.hashCode);
      }

      Get.back(result: true);
      Get.snackbar(
        'Success',
        isEditMode.value
            ? 'Note updated successfully'
            : 'Note added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save note: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSaving.value = false;
    }
  }

  /// Pick reminder date and time
  Future<void> pickReminderDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate:
          reminderDate.value ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        reminderDate.value = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }

  /// Clear reminder
  void clearReminder() {
    reminderDate.value = null;
  }

  /// Add tag
  void addTag(String tag) {
    final trimmedTag = tag.trim();
    if (trimmedTag.isNotEmpty && !tags.contains(trimmedTag)) {
      tags.add(trimmedTag);
      tagController.clear();
    }
  }

  /// Remove tag
  void removeTag(String tag) {
    tags.remove(tag);
  }

  /// Set category
  void setCategory(String? category) {
    selectedCategory.value = category;
  }

  /// Set color
  void setColor(int? colorCode) {
    selectedColorCode.value = colorCode;
  }

  /// Validate title
  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  /// Validate content
  String? validateContent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Content is required';
    }
    return null;
  }
}
