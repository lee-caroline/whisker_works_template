#!/bin/bash

echo "Starting Whisker Works setup..."

# Step 1: Clean old builds
flutter clean

# Step 2: Get Dart and Flutter dependencies
flutter pub get

# Step 3: Precache iOS and macOS artifacts (macOS only)
flutter precache --ios --macos

# Step 4: Install CocoaPods (macOS/iOS only)
if [ -d "ios" ]; then
  echo "Installing iOS pods..."
  cd ios
  pod install
  cd ..
fi

if [ -d "macos" ]; then
  echo "Installing macOS pods..."
  cd macos
  pod install
  cd ..
fi

echo "Setup complete! You can now run the app with:"
echo "  flutter run -d ios     # iOS simulator"
echo "  flutter run -d macos   # macOS desktop"
echo "  flutter run -d android # Android device/emulator"
echo "  flutter run -d chrome  # Web"
echo "  flutter run -d windows # Windows desktop"
