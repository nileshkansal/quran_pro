# QuranPro — Flutter app

Built from **Quran Pro App UI Design V1** (Figma). Every frame is implemented as a working, clickable Flutter screen with mock data, rebuilt **pixel-for-pixel from the Figma node specs** (positions, auto-layout gaps/padding, fills, radii, shadows, exact text styles) after the client's design review. The project targets **Flutter 3.44.8** (Dart 3.12) and uses **no third-party runtime packages**. Fonts and images are bundled.

## Getting started

```bash
cd quran_pro
./setup.sh            # runs `flutter create .` to add android/ + ios/, then pub get + analyze
flutter run
```

`setup.sh` only *adds* the missing platform folders. `lib/`, `assets/`, `pubspec.yaml` and `test/` are left as they are.

## Project structure

```
lib/
  main.dart                     App entry (MaterialApp + named routes)
  core/
    routes/app_routes.dart      Every route in the click-flow, named after its Figma frame
    theme/                      Colour tokens + text styles from Figma
    state/app_state.dart        In-memory prototype state (ChangeNotifier)
    utils/hijri.dart            Hijri date conversion for Prayer Times
    assets.dart                 Asset paths
  core/figma.dart               Pixel-perfect helpers: ts() Figma text styles, FigIcon, GradientText, shadows
  core/l10n/app_language.dart   English / Tamil / Arabic / Urdu (locale + text direction)
  data/mock_data.dart           Surahs, verses, tafsir, prayer times, reciters
  data/dua_data.dart            Dua and Virtues of Deeds sample content
  widgets/                      Shared UI: fig_widgets (FigButton, FigInput, GoldRing, FigSubPage…), sheets, bottom nav, verse card
  features/
    onboarding/                 Splash → Language → Welcome → Onboarding 1-5 → Profile → … → Reading setup
    auth/                       Login, Forgot password, OTP, Reset, Success
    home/                       Shell + Home tab, Dua, Virtues, Qibla / Prayer Times / Choose Location sheets
    quran/                      Quran Sanctuary, Surah detail (translation), Tafsir, Share, Audio,
                                Daily Reading, Success, Mushaf (Arabic reading)
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
