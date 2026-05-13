import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants/app_constants.dart';
import '../models/note_model.dart';

/// Service class for managing Hive database operations
class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  /// Initialize Hive database
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(NoteModelAdapter());

    // Open boxes
    await Hive.openBox<NoteModel>(AppConstants.notesBox);
    await Hive.openBox(AppConstants.settingsBox);
  }

  /// Get notes box
  Box<NoteModel> get notesBox => Hive.box<NoteModel>(AppConstants.notesBox);

  /// Get settings box
  Box get settingsBox => Hive.box(AppConstants.settingsBox);

  /// Add a new note
  Future<void> addNote(NoteModel note) async {
    await notesBox.put(note.id, note);
  }

  /// Update an existing note
  Future<void> updateNote(NoteModel note) async {
    await notesBox.put(note.id, note);
  }

  /// Delete a note
  Future<void> deleteNote(String id) async {
    await notesBox.delete(id);
  }

  /// Delete all notes
  Future<void> deleteAllNotes() async {
    await notesBox.clear();
  }

  /// Get all notes
  List<NoteModel> getAllNotes() {
    return notesBox.values.toList();
  }

  /// Get a single note by ID
  NoteModel? getNoteById(String id) {
    return notesBox.get(id);
  }

  /// Search notes by title or content
  List<NoteModel> searchNotes(String query) {
    if (query.isEmpty) return getAllNotes();

    final lowercaseQuery = query.toLowerCase();
    return notesBox.values.where((note) {
      return note.title.toLowerCase().contains(lowercaseQuery) ||
          note.content.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  /// Get pinned notes
  List<NoteModel> getPinnedNotes() {
    return notesBox.values.where((note) => note.isPinned).toList();
  }

  /// Get unpinned notes
  List<NoteModel> getUnpinnedNotes() {
    return notesBox.values.where((note) => !note.isPinned).toList();
  }

  /// Close all boxes
  Future<void> closeBoxes() async {
    await Hive.close();
  }
}
