import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/design_scale.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
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
