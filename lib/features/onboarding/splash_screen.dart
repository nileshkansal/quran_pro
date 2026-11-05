import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/fig_widgets.dart';

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
      backgroundColor: const Color(0xFFFCFBFA),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _next,
        child: FigCanvas(
          background: const Color(0xFFFCFBFA),
          children: [
            const Positioned.fill(child: LanternBackdrop()),
            // Logo + tagline group: 273×182 at y 331.1, column gap 19.
            FigCenter(
              top: 331.1,
              child: FadeTransition(
                opacity: fade,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Logo.splash(width: 153),
                  const SizedBox(height: 19),
                  Text('RECITE | UNDERSTAND | TRANSFORM', style: ts(Ff.inter, 12, w400, const Color(0xFF0A853A), lsPct: 14)),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
