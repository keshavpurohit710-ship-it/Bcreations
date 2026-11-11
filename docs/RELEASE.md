# Building & releasing Bcreations (Android)

## One-time machine setup (Windows)
1. **Flutter 3.47.9** at `C:\Users\admin\flutter` (already installed). Add `C:\Users\admin\flutter\bin` to PATH.
2. **Android SDK + JDK 17**: install Android Studio (it bundles a JDK), open it once and let it install the SDK, then run `flutter doctor --android-licenses`.
3. **Developer Mode** on Windows (Settings → System → For developers). Flutter needs symlinks to build plugins.
4. Check: `flutter doctor` shows a green tick for Android toolchain.

## Everyday commands
```bash
flutter pub get
flutter analyze --no-fatal-infos
flutter test
flutter run                      # phone connected with USB debugging on
flutter build apk --release      # output: build/app/outputs/flutter-apk/app-release.apk
```

## Release signing (do once, keep forever)
Android only installs an update if it's signed with the **same key** as the installed app. Losing this key means your mother has to uninstall the app (and lose its data) to update. Back it up in two places, e.g. a password manager and an offline drive.

1. Create the upload keystore **outside the repo** (`keytool` is at `C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe`):
   ```bash
   keytool -genkey -v -keystore C:\Users\admin\keys\bcreations-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. Create `android/key.properties` (git-ignored, never commit it):
   ```properties
   storePassword=<password>
   keyPassword=<password>
   keyAlias=upload
   storeFile=C:\\Users\\admin\\keys\\bcreations-upload.jks
   ```
3. `flutter build apk --release` is now signed with your key. Without `key.properties`, release builds fall back to the debug key (fine for testing, **not** for her phone).

## CI (GitHub Actions)
`.github/workflows/ci.yml` runs analyze and test on every push, then builds a release APK and attaches it to the run as `bcreations-apk`. The CI APK is debug-signed until the keystore is added as repository secrets (planned for Phase 8).

## App icon & splash
Source images live in `assets/branding/` (`logo_original.webp` is the full artwork; `icon.png` and `icon_foreground.png` are the cropped versions). After changing them, regenerate:
```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```
