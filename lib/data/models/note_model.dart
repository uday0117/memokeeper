import 'package:hive/hive.dart';

part 'note_model.g.dart';

/// Note model for storing memo data
@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime updatedAt;

  @HiveField(5)
  bool isPinned;

  @HiveField(6)
  DateTime? reminderDate;

  @HiveField(7)
  String? category;

  @HiveField(8)
  List<String>? tags;

  @HiveField(9)
  int? colorCode;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.isPinned = false,
    this.reminderDate,
    this.category,
    this.tags,
    this.colorCode,
  });

  /// Create a copy of note with updated fields
  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPinned,
    DateTime? reminderDate,
    String? category,
    List<String>? tags,
    int? colorCode,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPinned: isPinned ?? this.isPinned,
      reminderDate: reminderDate ?? this.reminderDate,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      colorCode: colorCode ?? this.colorCode,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isPinned': isPinned,
      'reminderDate': reminderDate?.toIso8601String(),
      'category': category,
      'tags': tags,
      'colorCode': colorCode,
    };
  }

  /// Create from JSON
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isPinned: json['isPinned'] ?? false,
      reminderDate: json['reminderDate'] != null
          ? DateTime.parse(json['reminderDate'])
          : null,
      category: json['category'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      colorCode: json['colorCode'],
    );
  }
}
