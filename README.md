# Whisker Works: Mouse Colony Tracker

**Whisker Works** is a cross-platform Flutter app designed to help research labs manage mouse colonies. It supports full tracking of mouse metadata (strain, treatment, cage, sex, DOB, etc.), litter information, local notifications, CSV export, and Firestore syncing across macOS, Windows, iOS, Android, and web.

This guide walks through the complete setup process from cloning the repository to running the app across all platforms.

---

## 1. System Requirements

Ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Latest stable)
- Dart (bundled with Flutter)
- Git
- VS Code or Android Studio (for editing)
- Xcode (macOS only, for iOS builds)
- CocoaPods (macOS only):  
  ```bash
  sudo gem install cocoapods
  ```

---

## 2. Clone the Project

```bash
git clone https://github.com/your-username/whisker-works.git
cd whisker-works
```

---

## 3. Flutter Dependency Setup

```bash
flutter pub get
```

This installs all necessary Dart and Flutter packages.

---

## 4. Firebase Setup

> Required for syncing data via Firestore.

### Step-by-Step:

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project (e.g., `whisker-works`)
3. Enable Firestore Database
4. Add all platforms you plan to support:
   - Android
   - iOS
   - macOS
   - Web
   - Windows (if desired)

5. Use the [`flutterfire` CLI](https://firebase.flutter.dev/docs/cli/) to generate `firebase_options.dart`:

```bash
flutterfire configure
```

6. Confirm the file `lib/firebase_options.dart` is created and properly linked in `main.dart`.

---

## 5. iOS/macOS Setup

If you are building for iOS or macOS:

### Precache required Flutter artifacts:
```bash
flutter precache --ios
flutter precache --macos
```

### CocoaPods install (macOS only):
```bash
cd ios
pod install
cd ..
```

### Disable auto-signing in Xcode:
1. Run `open ios/Runner.xcworkspace`
2. In Xcode, select the `Runner` target
3. Go to the **Signing & Capabilities** tab
4. Uncheck “Automatically manage signing”
5. Set team manually (if needed)

---

## 6. Platform-Specific Run Commands

You can now launch the app on your desired platform:

### macOS
```bash
flutter run -d macos
```

### iOS Simulator or Device
```bash
flutter run -d ios
```

### Android Emulator or Device
```bash
flutter run -d android
```

### Chrome (Web)
```bash
flutter run -d chrome
```

### Windows
```bash
flutter run -d windows
```

> Use `flutter devices` to see connected and available targets.

---

## 7. CSV Export

The app includes functionality to export your Firestore or local mouse database into CSV format, compatible with Excel or REDCap. This will be handled via the `csv` and `path_provider` packages.

No extra setup is required once the feature is integrated.

---

## 8. Data Model

Mouse records support the following fields:

- Auto-generated 6-digit ID
- Strain
- Treatment
- Sex
- Procedure
- Researcher
- Date of Birth
- Status (Alive, CO2, Natural)
- Cage
- Timestamp
- Litter info (DOB, wean date, sex count)

Data is autosaved to Firestore and can be locally exported.

---

## 9. Feature Checklist (In Progress)

- [x] Add/edit/delete mouse records
- [x] Autosave to Firestore
- [x] Search/filter records
- [x] CSV export
- [x] Local notifications (scheduled treatments)
- [x] Cage and litter tracking
- [ ] Experimental tracking module (coming soon)
- [ ] Multi-user roles (coming soon)

---

## 10. Troubleshooting

**Missing `Generated.xcconfig`?**  
Run:
```bash
flutter pub get
```

**Missing `Flutter.xcframework`?**  
Run:
```bash
flutter precache --ios
```

**CocoaPods error?**  
Run:
```bash
cd ios
pod install
cd ..
```

**Build still fails?**  
Run:
```bash
flutter clean
flutter pub get
```

---

## Author

**Caroline Lee**  
Research Assistant I  
Boston Children’s Hospital | Smith College '25  
Contact: caroline@example.com

