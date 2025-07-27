# 🛠 macOS Build Recovery & Setup Guide (Flutter)

This guide helps you fix common macOS build issues in Flutter — especially on Apple Silicon (M1/M2/M3) Macs.

---

## One-Time Setup (Apple Silicon Macs)

1. **Open Terminal using Rosetta:**
   - Go to `Applications > Utilities > Terminal`
   - Right-click on Terminal > **Get Info**
   - Check “Open using Rosetta”
   - Close and reopen Terminal

---

## If You Get a Build Error Like:

```text
Flutter-Generated.xcconfig must exist...
shared_preferences_foundation build error...
multiple matching destinations (arm64, x86_64)...
```

---

## Recovery Steps (Copy/Paste These)

```bash
# Go to your project root
cd ~/mouse_colony_app

# Fully clean your Flutter project
flutter clean
rm -rf macos
rm -rf build/

# Recreate platform folders
flutter create .
flutter pub get

# Set Apple Silicon architecture in Podfile
# (open the file in any editor and add these lines near the top)
# ----
# ENV['ARCHS'] = 'arm64'
# platform :macos, '11.0'
# ----

# Then install CocoaPods
cd macos
arch -x86_64 pod install
cd ..

# Run your app on macOS
flutter run -d macos
```

---

## Done!

You should now be able to launch your app on macOS without errors.

---

**Tip:** Keep this file in your repo as `macos_setup.md` or include in your README so you can quickly restore things later!
