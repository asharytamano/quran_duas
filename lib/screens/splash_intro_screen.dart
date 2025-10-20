import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/router.dart';

class SplashIntroScreen extends StatelessWidget {
  const SplashIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF0F3D2E), const Color(0xFF19624A), const Color(0xFFFFB300)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
          ),
          // Subtle pattern overlay (optional)
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.08,
                child: SvgPicture.asset(
                  'assets/patterns/islamic-tile.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              child: Column(
                children: [
                  const Spacer(),
                  // Logo circle
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        )
                      ],
                      border: Border.all(color: Colors.white24, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/dua.png', width: 84, height: 84, fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Qur’anic Duas',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 26,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'A heartfelt collection of all supplications in the Qur’an — organized by Surah and theme. Read in Arabic (Amiri), with English meaning and transliteration. Save favorites, search quickly, and share easily.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                  const Spacer(),
                  // 3D Get Started button
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacementNamed(AppRouter.home),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [c.tertiaryContainer, c.primaryContainer],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.35),
                            offset: const Offset(0, 10),
                            blurRadius: 22,
                          ),
                        ],
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
