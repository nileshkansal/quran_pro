import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Same edge-to-edge behaviour on every Android version (Android 15+ forces it).
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      // Dark system navigation buttons on the cream bar area (DesignScale).
      systemNavigationBarColor: AppColors.cream,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: AppColors.transparent,
    ),
  );
  runApp(const QuranProApp());
}

class QuranProApp extends StatelessWidget {
  const QuranProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuranPro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      // Pixel-perfect: lay out on the 390-wide Figma canvas, scaled to the phone.
      builder: (context, child) => DesignScale(child: child ?? const SizedBox()),
    );
  }
}
