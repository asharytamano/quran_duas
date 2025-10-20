import 'package:flutter/material.dart';
import '../screens/splash_intro_screen.dart';
import '../screens/home_screen.dart';
import '../screens/dua_detail_screen.dart';
import '../models/dua.dart';

class AppRouter {
  static const splash = '/';
  static const home = '/home';
  static const duaDetail = '/dua';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashIntroScreen());
      case home:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 350),
        );
      case duaDetail:
        final dua = settings.arguments as Dua;
        return MaterialPageRoute(builder: (_) => DuaDetailScreen(dua: dua));
      default:
        return MaterialPageRoute(builder: (_) => const SplashIntroScreen());
    }
  }
}
