import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Figma: "Splash Screen" (6001:1479)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..forward();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2600), _next);
  }

  void _next() {
    if (mounted) Navigator.of(context).pushReplacementNamed(AppRoutes.selectLanguage);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fade = CurvedAnimation(parent: _c, curve: Curves.easeOut);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _next,
        child: DesignCanvas(
          background: AppColors.background,
          children: [
            const Positioned.fill(child: LanternBackdrop()),
            // Logo + tagline group: 273×182 at y 331.1, column gap 19.
            CanvasCenter(
              top: 331.1,
              child: FadeTransition(
                opacity: fade,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Logo.splash(width: 153),
                  const SizedBox(height: 19),
                  Text('RECITE | UNDERSTAND | TRANSFORM', style: ts(AppFonts.inter, 12, w400, AppColors.green72, lsPct: 14)),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
