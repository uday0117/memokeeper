# 📝 Memo Keeper – Simple Notes

A complete offline notes application built with Flutter, using GetX for state management and Hive for local storage.

## ✨ Features

- ✅ **Offline Storage** - All notes stored locally using Hive database
- 🔍 **Real-time Search** - Search notes by title or content
- 📌 **Pin Notes** - Keep important notes at the top
- 🔔 **Reminders** - Set local notifications for notes
- 🌓 **Dark Mode** - Toggle between light and dark themes
- 📱 **Modern UI** - Material 3 design with smooth animations
- 🎨 **Clean Architecture** - Modular, maintainable code structure

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart       # Application constants
│   ├── theme/
│   │   └── app_theme.dart           # Light and dark theme definitions
│   └── utils/
│       └── date_formatter.dart      # Date formatting utilities
├── data/
│   ├── models/
│   │   ├── note_model.dart          # Note data model
│   │   └── note_model.g.dart        # Generated Hive adapter
│   └── services/
│       ├── hive_service.dart        # Hive database operations
│       └── notification_service.dart # Local notifications handler
├── modules/
│   ├── splash/
│   │   ├── splash_view.dart         # Splash screen UI
│   │   ├── splash_controller.dart   # Splash screen logic
│   │   └── splash_binding.dart      # Dependency injection
│   ├── home/
│   │   ├── home_view.dart           # Home screen UI
│   │   ├── home_controller.dart     # Home screen logic
│   │   └── home_binding.dart        # Dependency injection
│   ├── add_note/
│   │   ├── add_note_view.dart       # Add/Edit note UI
│   │   ├── add_note_controller.dart # Add/Edit note logic
│   │   └── add_note_binding.dart    # Dependency injection
│   └── settings/
│       ├── settings_view.dart       # Settings screen UI
│       ├── settings_controller.dart # Settings logic
│       └── settings_binding.dart    # Dependency injection
├── routes/
│   ├── app_routes.dart              # Route name constants
│   └── app_pages.dart               # Route configuration
├── widgets/
│   ├── note_card.dart               # Reusable note card widget
│   └── empty_state.dart             # Empty state widget
└── main.dart                         # Application entry point
```

## 📦 Dependencies

```yaml
dependencies:
  # State Management
  get: ^4.6.6
  
  # Local Database
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # Utilities
  path_provider: ^2.1.1
  flutter_local_notifications: ^16.3.0
  intl: ^0.18.1
  get_storage: ^2.1.1
  timezone: ^0.9.2

dev_dependencies:
  # Code Generation
  hive_generator: ^2.0.1
  build_runner: ^2.4.7
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.10.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android device or emulator / iOS device or simulator

### Installation

1. **Clone or navigate to the project directory**
   ```bash
   cd /Users/mac/Documents/uksolutions/memokeeper
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters** (if not already generated)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🎯 Key Features Implementation

### 1. State Management with GetX

- Uses `GetX` controllers for reactive state management
- Implements `Bindings` for dependency injection
- Utilizes `GetMaterialApp` for routing and theme management

### 2. Local Storage with Hive

- Offline-first architecture
- Fast and lightweight database
- Type-safe data models with generated adapters
- CRUD operations for notes

### 3. Local Notifications

- Schedule reminders for notes
- Android and iOS support
- Notification channels configured
- Permissions handled properly

### 4. Clean Architecture

```
Presentation Layer (Views)
    ↓
Controller Layer (Business Logic)
    ↓
Service Layer (Data Operations)
    ↓
Data Layer (Hive Database)
```

## 📱 Screens

### Splash Screen
- App branding
- Initial loading
- Auto-navigates to home

### Home Screen
- List of all notes
- Search functionality
- Pin/unpin notes
- Delete notes
- Pull to refresh
- Empty state UI

### Add/Edit Note Screen
- Title and content fields
- Set reminder
- Form validation
- Save functionality

### Settings Screen
- Dark mode toggle
- App information
- Feature list

## 🎨 UI Design

- **Material 3** design system
- **Blue theme** (#2196F3)
- **Rounded cards** with elevation
- **Smooth animations** (200-500ms)
- **Responsive layouts**
- **Empty states** for better UX

## 🔔 Permissions

### Android
The following permissions are configured in `AndroidManifest.xml`:
- `POST_NOTIFICATIONS` - Show notifications
- `SCHEDULE_EXACT_ALARM` - Schedule exact alarms
- `USE_EXACT_ALARM` - Use exact alarms
- `RECEIVE_BOOT_COMPLETED` - Restore notifications after reboot
- `VIBRATE` - Vibrate on notification

### iOS
Notification permissions are requested at runtime through the app.

## 🧪 Code Quality

- ✅ **Null safety** enabled
- ✅ **Proper comments** throughout code
- ✅ **Reusable widgets**
- ✅ **Clean architecture** principles
- ✅ **Production-ready** code
- ✅ **Error handling**
- ✅ **Form validation**

## 📝 Note Model

```dart
@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) String title;
  @HiveField(2) String content;
  @HiveField(3) DateTime createdAt;
  @HiveField(4) DateTime updatedAt;
  @HiveField(5) bool isPinned;
  @HiveField(6) DateTime? reminderDate;
}
```

## 🎯 App Constants

- **App Name**: Memo Keeper – Simple Notes
- **Package Name**: com.apps.uksolutions.memokeeper
- **Version**: 1.0.0
- **Primary Color**: Blue (#2196F3)

## 📋 Available Operations

### Home Controller
- `loadNotes()` - Load all notes from database
- `searchNotes(query)` - Search notes in real-time
- `deleteNote(id)` - Delete a single note
- `deleteAllNotes()` - Delete all notes
- `togglePin(note)` - Pin/unpin a note

### Add Note Controller
- `saveNote()` - Save new or update existing note
- `pickReminderDate()` - Set reminder date and time
- `clearReminder()` - Remove reminder
- `validateTitle()` - Validate note title
- `validateContent()` - Validate note content

### Settings Controller
- `toggleTheme()` - Switch between light/dark mode

## 🔄 App Flow

1. **App Launch** → Splash Screen (2 seconds)
2. **Home Screen** → Display all notes (latest first)
3. **Add Note** → Create new note with optional reminder
4. **Edit Note** → Update existing note
5. **Search** → Real-time filtering
6. **Settings** → Toggle dark mode and view app info

## 🎨 Theme Colors

### Light Theme
- Primary: #2196F3 (Blue)
- Background: #F5F5F5 (Light Gray)
- Cards: #FFFFFF (White)
- Text: Black87

### Dark Theme
- Primary: #2196F3 (Blue)
- Background: #121212 (Dark)
- Cards: #1E1E1E (Dark Gray)
- Text: White

## 🛠️ Build Commands

```bash
# Get dependencies
flutter pub get

# Generate code (Hive adapters)
flutter pub run build_runner build

# Clean build
flutter clean

# Run app
flutter run

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

## 📄 License

This project is created for UK Solutions.

## 👨‍💻 Developer

**UK Solutions**
- Package: com.apps.uksolutions.memokeeper
- Version: 1.0.0

---

**Note**: This is a production-ready application with all features implemented and tested. The code follows Flutter best practices and clean architecture principles.
