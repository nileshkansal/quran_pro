// Layout check: renders every screen, tab, sheet and dialog with the real
// fonts at real phone sizes, records every Flutter layout error (RenderFlex
// overflow etc.) and saves screenshots.
//
//   flutter test test/layout --update-goldens
//
// Output: test/layout/report.md and test/layout/shots/<size>/*.png
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_pro/core/routes/app_routes.dart';
import 'package:quran_pro/core/theme/theme.dart';
import 'package:quran_pro/data/mock_data.dart';
import 'package:quran_pro/features/home/prayer_sheets.dart';
import 'package:quran_pro/features/quran/quran_sheets.dart';
import 'package:quran_pro/features/settings/account_dialogs.dart';
import 'package:quran_pro/widgets/widgets.dart';

/// Logical screen sizes to check (width, height incl. status bar).
const sizes = <String, Size>{
  '360x752': Size(360, 752), // Samsung 1080×2400 @3x with 3-button nav
  '412x868': Size(412, 868), // Pixel 7/8
};

final report = StringBuffer();
final navKey = GlobalKey<NavigatorState>();
final shotKey = GlobalKey();

Future<void> loadFonts() async {
  final pubspec = File('pubspec.yaml').readAsStringSync();
  final fam = RegExp(r'- family: (\S+)\n\s+fonts:\n((?:\s+- asset: \S+\n(?:\s+(?:weight|style): \S+\n)*)+)');
  for (final m in fam.allMatches(pubspec)) {
    final loader = FontLoader(m.group(1)!);
    for (final a in RegExp(r'- asset: (\S+)').allMatches(m.group(2)!)) {
      loader.addFont(rootBundle.load(a.group(1)!));
    }
    await loader.load();
  }
  final root = Platform.environment['FLUTTER_ROOT'];
  if (root != null) {
    final f = File('$root/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf');
    if (f.existsSync()) {
      final bytes = f.readAsBytesSync();
      await (FontLoader('MaterialIcons')..addFont(Future.value(ByteData.view(bytes.buffer)))).load();
    }
  }
}

Widget app(String route) => RepaintBoundary(
      key: shotKey,
      child: MaterialApp(
        navigatorKey: navKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        onGenerateInitialRoutes: (r) => [AppRoutes.onGenerateRoute(RouteSettings(name: route))],
        initialRoute: route,
        builder: (context, child) => DesignScale(child: child ?? const SizedBox()),
      ),
    );

Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.runAsync(() async {
    for (final e in find.byType(Image).evaluate().toList()) {
      try {
        await precacheImage((e.widget as Image).image, e);
      } catch (_) {}
    }
  });
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump(const Duration(milliseconds: 100));
}

final _loc = RegExp(r'lib/[\w/]+\.dart:\d+');

String? _location(FlutterErrorDetails d) {
  for (final n in d.informationCollector?.call() ?? const <DiagnosticsNode>[]) {
    final m = _loc.firstMatch(n.toStringDeep());
    if (m != null) return m.group(0);
  }
  return null;
}

/// Finds visible text that is clipped, truncated or wrapped onto more lines
/// than the design's explicit line breaks allow.
List<String> textProblems(WidgetTester tester) {
  final out = <String>[];
  final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
  for (final o in tester.allRenderObjects) {
    if (o is! RenderParagraph || !o.hasSize || !o.attached) continue;
    final text = o.text.toPlainText();
    if (text.trim().isEmpty) continue;
    var hasWidget = false;
    o.text.visitChildren((span) {
      if (span is WidgetSpan) hasWidget = true;
      return !hasWidget;
    });
    if (hasWidget) continue;
    Offset pos;
    try {
      pos = o.localToGlobal(Offset.zero);
    } catch (_) {
      continue;
    }
    if (pos.dy > screen.height || pos.dy + o.size.height < 0 || pos.dx > screen.width) continue;
    final label = text.replaceAll('\n', '⏎');
    final short = label.length > 50 ? '${label.substring(0, 50)}…' : label;
    final painter = TextPainter(
      text: o.text,
      textAlign: o.textAlign,
      textDirection: o.textDirection,
      textScaler: o.textScaler,
      maxLines: o.maxLines,
      locale: o.locale,
      strutStyle: o.strutStyle,
      textWidthBasis: o.textWidthBasis,
      textHeightBehavior: o.textHeightBehavior,
    )..layout(maxWidth: o.size.width);
    final lines = painter.computeLineMetrics();
    painter.dispose();
    final expected = '\n'.allMatches(text).length + 1;
    if (o.didExceedMaxLines) {
      out.add('TEXT truncated: «$short»');
      continue;
    }
    if (lines.isNotEmpty) {
      final last = lines.last;
      final textH = last.baseline + last.descent;
      if (textH > o.size.height + 1.5) {
        out.add('TEXT clipped (needs ${textH.toStringAsFixed(1)}, has ${o.size.height.toStringAsFixed(1)}): «$short»');
        continue;
      }
    }
    if (text.contains('\n') && lines.length > expected) {
      out.add('TEXT wraps into ${lines.length} lines (design $expected): «$short» width ${o.size.width.toStringAsFixed(1)}');
    } else if (!text.contains('\n') && text.length <= 24 && lines.length > 1 && o.maxLines == null) {
      out.add('TEXT label wraps into ${lines.length} lines: «$short» width ${o.size.width.toStringAsFixed(1)}');
    }
  }
  return out;
}

/// Runs [body] while collecting Flutter errors, then writes them to the report.
Future<void> check(WidgetTester tester, String sizeName, String name, Future<void> Function() body, {bool shot = true}) async {
  final errors = <String>[];
  final old = FlutterError.onError;
  FlutterError.onError = (d) {
    final msg = d.exceptionAsString().split('\n').first;
    final where = _location(d);
    errors.add(where == null ? msg : '$msg  ($where)');
  };
  try {
    await body();
    errors.addAll(textProblems(tester));
    if (shot) {
      await expectLater(find.byKey(shotKey), matchesGoldenFile('shots/$sizeName/$name.png'));
    }
  } catch (e) {
    errors.add('EXCEPTION: ${e.toString().split('\n').take(3).join(' ')}');
  } finally {
    FlutterError.onError = old;
  }
  final ex = tester.takeException();
  if (ex != null) errors.add('EXCEPTION: ${ex.toString().split('\n').first}');
  final unique = errors.toSet().toList();
  report.writeln(unique.isEmpty ? '- ✅ `$name`' : '- ❌ `$name`');
  for (final e in unique) {
    report.writeln('  - $e');
  }
}

/// Pumps without reporting (errors are reported by the screen's own check).
Future<void> quiet(WidgetTester tester, Future<void> Function() body) async {
  final old = FlutterError.onError;
  FlutterError.onError = (_) {};
  try {
    await body();
  } finally {
    FlutterError.onError = old;
  }
  tester.takeException();
}

Future<void> scrollShots(WidgetTester tester, String size, String name) async {
  final scrollables = find.byType(Scrollable).evaluate().toList();
  if (scrollables.isEmpty) return;
  // Biggest vertical scrollable.
  Element? best;
  var area = 0.0;
  for (final e in scrollables) {
    final s = e.widget as Scrollable;
    if (s.axisDirection != AxisDirection.down) continue;
    final box = e.renderObject as RenderBox?;
    if (box == null || !box.hasSize) continue;
    final a = box.size.width * box.size.height;
    if (a > area) {
      area = a;
      best = e;
    }
  }
  if (best == null) return;
  for (var i = 2; i <= 4; i++) {
    final pos = (best.widget as Scrollable).controller?.position ?? Scrollable.of(best).position;
    if (pos.pixels >= pos.maxScrollExtent - 1) break;
    await check(tester, size, '${name}_$i', () async {
      pos.jumpTo((pos.pixels + 500).clamp(0, pos.maxScrollExtent));
      await settle(tester);
    });
  }
}

void main() {
  setUpAll(() async {
    await loadFonts();
    report.writeln('# Layout check\n');
  });

  tearDownAll(() {
    File('test/layout/report.md').writeAsStringSync(report.toString());
  });

  const routes = [
    AppRoutes.splash, AppRoutes.selectLanguage, AppRoutes.welcome, AppRoutes.createProfile, AppRoutes.dailyRecitation,
    AppRoutes.notifications, AppRoutes.enableLocation, AppRoutes.widgetPromo, AppRoutes.readingSetup, AppRoutes.login,
    AppRoutes.forgotPassword, AppRoutes.verifyOtp, AppRoutes.resetPassword, AppRoutes.resetSuccess, AppRoutes.dua,
    AppRoutes.virtues, AppRoutes.sanctuary, AppRoutes.surahDetail, AppRoutes.mushaf, AppRoutes.dailyReading,
    AppRoutes.success, AppRoutes.editProfile, AppRoutes.myGoals, AppRoutes.readingSettings, AppRoutes.audioRecitation,
    AppRoutes.about, AppRoutes.helpAbout, AppRoutes.privacy, AppRoutes.terms, AppRoutes.feedback,
  ];

  for (final entry in sizes.entries) {
    final size = entry.key;
    final shots = size == '360x752';

    Future<void> setView(WidgetTester tester) async {
      tester.view.devicePixelRatio = 3;
      tester.view.physicalSize = entry.value * 3;
      tester.view.padding = const FakeViewPadding(top: 72);
      tester.view.viewPadding = const FakeViewPadding(top: 72);
      addTearDown(tester.view.reset);
    }

    Future<void> finish(WidgetTester tester) async {
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 5));
    }

    group(size, () {
      setUpAll(() => report.writeln('\n## $size\n'));

      for (final r in routes) {
        final name = r == '/' ? 'splash' : r.substring(1).replaceAll('/', '_');
        testWidgets(name, (tester) async {
          await setView(tester);
          await check(tester, size, name, () async {
            await tester.pumpWidget(app(r));
            await settle(tester);
          }, shot: shots);
          if (shots) await scrollShots(tester, size, name);
          await finish(tester);
        });
      }

      testWidgets('onboarding pages', (tester) async {
        await setView(tester);
        await tester.pumpWidget(app(AppRoutes.onboarding));
        await settle(tester);
        for (var p = 1; p <= 5; p++) {
          await check(tester, size, 'onboarding_$p', () async {
            if (p > 1) {
              await tester.tap(find.text('Next').last, warnIfMissed: false);
              await tester.pump(const Duration(milliseconds: 600));
            }
            await settle(tester);
          }, shot: shots);
        }
        await finish(tester);
      });

      for (final tab in [0, 1, 2, 3]) {
        testWidgets('home tab $tab', (tester) async {
          await setView(tester);
          mainTabIndex.value = tab;
          final name = ['home', 'tab_feedback', 'tab_settings', 'tab_profile'][tab];
          await check(tester, size, name, () async {
            await tester.pumpWidget(app(AppRoutes.home));
            await settle(tester);
          }, shot: shots);
          if (shots) await scrollShots(tester, size, name);
          mainTabIndex.value = 0;
          await finish(tester);
        });
      }

      final modals = <String, Future<void> Function(BuildContext)>{
        'sheet_qibla': showQiblaSheet,
        'sheet_prayer_times': showPrayerTimesSheet,
        'sheet_choose_location': showChooseLocationSheet,
        'sheet_tafsir': (c) => showTafsirSheet(c, kBaqarahVerses.first),
        'sheet_share': (c) => showShareSheet(c, kBaqarahVerses.first),
        'popup_verse': (c) => showVersePopup(c, kMulkVerses.first, surah: 'Al-Mulk', surahNo: 67),
        'dialog_logout': showLogoutDialog,
        'dialog_delete': showDeleteAccountDialog,
      };
      for (final m in modals.entries) {
        testWidgets(m.key, (tester) async {
          await setView(tester);
          mainTabIndex.value = 0;
          await quiet(tester, () async {
            await tester.pumpWidget(app(AppRoutes.home));
            await settle(tester);
          });
          await check(tester, size, m.key, () async {
            m.value(navKey.currentContext!);
            await tester.pump(const Duration(milliseconds: 500));
            await settle(tester);
          }, shot: shots);
          if (shots) await scrollShots(tester, size, m.key);
          await finish(tester);
        });
      }
    });
  }
}
