import 'package:flutter/material.dart';

import '../core/utils/date_formatter.dart';
import '../data/models/note_model.dart';

/// Reusable note card widget
class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onPin;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete,
    required this.onPin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and pin icon
              Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      note.isPinned
                          ? Icons.push_pin_rounded
                          : Icons.push_pin_outlined,
                      color: note.isPinned
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
                    onPressed: onPin,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: onDelete,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Content preview
              if (note.content.isNotEmpty)
                Text(
                  note.content,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 12),

              // Footer with date and reminder
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormatter.getRelativeTime(note.updatedAt),
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  const Spacer(),
                  if (note.reminderDate != null &&
                      note.reminderDate!.isAfter(DateTime.now()))
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.alarm_rounded,
                            size: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormatter.formatDate(note.reminderDate!),
                            style: TextStyle(
                              fontSize: 11,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
