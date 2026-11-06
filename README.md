# QuranPro — Flutter app

Built from **Quran Pro App UI Design V1** (Figma). Every frame is implemented as a working, clickable Flutter screen with mock data, rebuilt **pixel-for-pixel from the Figma node specs** (positions, auto-layout gaps/padding, fills, radii, shadows, exact text styles) after the client's design review. The project targets **Flutter 3.44.8** (Dart 3.12) and uses **no third-party runtime packages**. Fonts and images are bundled.

## Getting started

**Windows 10/11** (Command Prompt or PowerShell):

```bat
cd quran_pro
setup.bat             :: runs `flutter create .` to add android\ + ios\, then pub get + analyze
flutter run
```

**macOS / Linux:**

```bash
cd quran_pro
./setup.sh
flutter run
```

The setup script only *adds* the missing platform folders. `lib/`, `assets/`, `pubspec.yaml` and `test/` are left as they are.

On Windows you can build and run the **Android** app (emulator or USB device). iOS builds need a Mac with Xcode. Use a Mac, or a cloud Mac CI such as Codemagic or GitHub Actions `macos` runners, when you get to the iOS release.

## Project structure

```
lib/
  main.dart                     App entry (MaterialApp + DesignScale + named routes)
  core/
    theme/                      ── Design system (import theme/theme.dart) ──
      app_colors.dart           Every colour (AppColors) + gradients + .o(opacity)
      app_fonts.dart            Font families (AppFonts) + weights w400…w800
      app_text_styles.dart      Type scale (AppTextStyles) + ts() for one-off Figma styles
      app_dimens.dart           AppDesign canvas, AppSpacing, AppGap, AppInsets, AppRadius, AppSizes
      app_shadows.dart          AppShadows presets + fShadow()
      app_theme.dart            Material ThemeData built from the tokens
    design_scale.dart           Scales the 390-wide Figma canvas to every screen width
    routes/app_routes.dart      Every route in the click-flow, named after its Figma frame
    state/app_state.dart        In-memory prototype state (ChangeNotifier)
    l10n/app_language.dart      English / Tamil / Arabic / Urdu (locale + text direction)
    utils/                      validators.dart, formatters.dart, hijri.dart
    assets.dart                 Asset paths (AppImages, AppIcons)
  widgets/                      ── Reusable components (import widgets/widgets.dart) ──
    app_button.dart             AppButton (gold/outline/dark/green/danger, .pill), AppCircleIconButton,
                                AppTextLink, SocialButtons
    app_text_field.dart         AppTextField, AppPasswordField, AppLabeledField, AppTextArea
    app_dialog.dart             showAppModal (centre / bottom, 3 barriers), AppAlertDialog, showConfirmDialog
    app_sheet.dart              showAppSheet, SheetCloseButton
    app_snackbar.dart           showAppSnackBar, showComingSoon
    app_switch.dart             AppSwitch (+ .small)
    app_card.dart               AppCard, GlassCard, CardHeader, AppListRow, AppChevron, AppDecorations
    app_layout.dart             DesignCanvas, CanvasCenter, AppHeader, AppSubPage, AppBackButton, ArrowBackButton
    app_icon.dart               AppIcon (Figma-exported icons), GradientText
    decorations.dart            LanternBackdrop, DecorDivider, OrnamentDivider, OrDivider, Logo, PagerDots, GoldRing
    bottom_nav.dart, verse_card.dart
  data/                         mock_data.dart, dua_data.dart (sample content)
  features/
    onboarding/                 Splash → Language → Welcome → Onboarding 1-5 → Profile → … → Reading setup
    auth/                       Login, Forgot password, OTP, Reset, Success
    home/                       Shell + Home tab, Dua, Virtues, Qibla / Prayer Times / Choose Location sheets
    quran/                      Quran Sanctuary, Surah detail, Tafsir, Share, Audio, Daily Reading, Success, Mushaf
    profile/                    Profile (with progress), Edit Profile, My Goals
    settings/                   Settings, Reading settings, Audio & Recitation, About, Help,
                                Privacy, Terms, Feedback, Logout/Delete dialogs
assets/
  images/                       Raster art exported from the Figma file
  icons/                        Logo, waves, compass and art layers (rendered from Figma @3x)
  icons/fig/                    Every icon used by the screens, exported from its Figma vector node @3x
  fonts/                        Inter, Poppins, Plus Jakarta Sans, Montserrat, Amiri, Amiri Quran,
                                Scheherazade New, Cormorant Garamond, Cinzel, Nunito, Hachi Maru Pop (all OFL)
```

## Design system rules

Screens import two files and nothing else for UI:

```dart
import '../../core/theme/theme.dart';   // tokens
import '../../widgets/widgets.dart';    // components
```

- **Colours** — only `AppColors.*` (no `Color(0x…)` or `Colors.*` in screens). Transparency: `AppColors.outline.o(.3)`.
- **Fonts / text** — the theme's Material type geometry is neutral (no extra letter spacing or line height), so a Figma style renders exactly as specified. Use `AppTextStyles.*` first (`AppTextStyles.title`, `.body`, `.label`…), recolour with `.c(color)`. Use `ts(AppFonts.x, size, weight, color, lh:, ls:)` only for a one-off Figma style.
- **Spacing / radius / sizes** — `AppGap.v16`, `AppInsets.all24`, `AppRadius.br12`, `AppSizes.buttonHeight`, `AppShadows.md`. Odd Figma positions (e.g. 53.8) stay as literal numbers because they belong to one frame only.
- **Components** — buttons, fields, switches, dialogs, sheets, snackbars, cards and headers come from `widgets/`. Need a variation? Add a parameter to the component instead of building it inline.
- **Logic helpers** — `Validators` (e-mail, password strength) and `Formatters` (initials, Arabic digits, month/year).

## Layout check (CI)

`test/layout/layout_check_test.dart` renders every screen, tab, sheet and dialog with the bundled fonts at 360 × 752 (a 1080 × 2400 Android phone) and 412 × 868. It reports:

- every Flutter layout error (RenderFlex overflow, infinite size, missing Material…)
- text that is clipped, truncated or wraps onto more lines than the design's line breaks

It runs automatically on every push to `main` (GitHub Actions → *Layout check*). The report (`report.md`) and screenshots of every screen are published to the **`layout-results`** branch. Run it locally with:

```bash
flutter test test/layout --update-goldens   # writes test/layout/report.md + shots/
```

## Click flow

**01 · Onboarding & auth**
Splash (auto 2.6 s) → Select Language → *Bismillah* → Welcome
- *Let’s get started* → Onboarding 1-5 (swipe / Next / Skip) → Create Profile → Daily Recitation Time → Notifications → Enable Location (*Set City Manually* opens the Choose Location sheet) → Widget (*Add Widget* opens the Add-to-home sheet) → Reading Settings → **Home**
- *I already have an account* → Login → *Submit* / Google / Apple → **Home**
  - *Forget Password?* → Forgot Password → Verify Email (OTP) → Reset Password → Success → *Back to Login*
  - *Register* ↔ Create Profile *Login*

**02 · Home** (bottom bar: Home · Feedback · Setting · Profile)
- Bell / Prayer tool → Prayer Times sheet (location → Choose Location sheet; date → calendar view; *Adjust in Settings* → Settings tab)
- Qibla tool → Qibla Direction sheet
- *Let’s Read Now* → Daily Reading → *Finish for Today* → Success (*Back to Home*) · *Continue Reading* → Al-Baqarah
- Target ✎ → My Goals
- Tools: *Dua* → Dua list (accordion, detail popup) · *Virtues* → Virtues of Deeds

**03 · Translation reading:** *Quran in Translation* → Quran Sanctuary (Surahs/Juz tabs, search) → Al Baqara → verse **Tafsir** (sheet) · **Play** (mini audio player) · **Share** (sheet)

**04 · Arabic reading:** *Quran in Arabic* → Quran Sanctuary → Surah Al-Mulk Mushaf page → **long-press any ayah** → the ayah is highlighted and a popup shows its translation with Tafsir / Play / Share, page prev/next, bookmark

**05 · Profile & settings**
- Profile (journey ring, surahs completed, time spent, current target, streaks) → Edit Profile · Update Target → My Goals · Sign out → Logout dialog
- Settings → Reading Preferences · Audio & Recitation · Prayer Times · Qibla · App Language · Privacy Policy · Terms · Help & About (FAQ, How to Use tour, Feedback, About QuranPro) · Logout dialog · Delete Account dialog (both return to Welcome)

## Pixel-perfect notes
- Layout values come straight from the Figma node tree. Fixed-height frames use `FigCanvas` (a 390-wide design canvas that scrolls on short phones). Scrolling frames use the Figma auto-layout gaps and padding.
- `ts(family, size, weight, color, lh:, ls:)` converts Figma line-height (px) and letter-spacing (px or %) into Flutter `TextStyle` values, so text metrics match the design.
- Font substitutions (the design uses fonts that cannot be bundled): Satoshi → Inter, Noto Serif / Liberation Serif → Amiri, Playfair Display italic → Cormorant Garamond italic.

### Design deviations (inconsistencies in the Figma file)
- Bottom-bar order follows the main Home frame: Home · Feedback · Setting · Profile.
- "AI Baqara" in frame titles is shown as "Al Baqara".
- The OTP screen's button reads "Send OTP" in the design. The build uses "Verify".
- About QuranPro's *Certified Audit Complete* card contains Lorem Ipsum. A placeholder sentence is used until the client sends the real text.
- My Progress and Achievements frames are intentionally **not** built: per the client brief, progress lives on Profile.

## Next round (from the client brief)
- Quran.com API for 100% accurate text: Uthmani + Indo-Pak scripts, and exact Madani page/line layout for the Mushaf view.
- Reading plan built on the client's section data (currently 1,280 sample sections; 5 min → 3 sections/day).
- ARB localisation for Tamil, Arabic (RTL) and Urdu (RTL). The language model and picker are already in place.
- Email/password auth and cloud sync (favourites, last read, settings) behind a repository interface. The backend is still to be chosen.
- Home-screen widget (Android App Widget + iOS WidgetKit).

## Notes / next steps
- Data is mocked (`lib/data/mock_data.dart`). Swap in a Quran text/translation API and a persistence layer (e.g. shared_preferences / Hive) when ready.
- Qibla compass, audio playback, location and notifications are simulated. Plug in `flutter_compass`, `just_audio`, `geolocator` and `flutter_local_notifications`.
