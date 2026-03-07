import 'package:critijoy_note/features/auth/presentation/providers/auth_provider.dart';
import 'package:critijoy_note/shared/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _welcomeName = 'Usuario';
  bool _hasSession = false;

  @override
  void initState() {
    super.initState();
    _loadSessionName();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed && mounted) {
        final repo = ref.read(authRepositoryProvider);
        final user = await repo.restoreSession();
        if (!mounted) return;
        if (user != null) {
          ref.read(authStateProvider.notifier).setUser(user);
          context.go('/home');
        } else {
          context.go('/signin');
        }
      }
    });

    _controller.forward();
  }

  /// Loads the user name early so the welcome text is correct during animation.
  Future<void> _loadSessionName() async {
    final repo = ref.read(authRepositoryProvider);
    final user = await repo.restoreSession();
    if (mounted && user != null) {
      setState(() {
        _welcomeName = user.name;
        _hasSession = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final progress = _animation.value;
    final progressPercent = progress.toInt();

    // Theme-aware colors
    final backgroundColor =
        isDarkMode ? const Color(0xFF1B2230) : const Color(0xFFF0F4F8);
    final titleColor = isDarkMode ? Colors.white : const Color(0xFF1B2230);
    final subtitleColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];
    final trackColor =
        isDarkMode ? const Color(0xFF2D3748) : Colors.grey.shade300;
    final labelColor = isDarkMode ? Colors.grey[500] : Colors.grey[600];
    final borderColor =
        isDarkMode
            ? Colors.orange.shade800.withValues(alpha: 0.6)
            : Colors.orange.shade400.withValues(alpha: 0.7);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // --- Circular Avatar with Star Badge ---
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Outer ring
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: borderColor, width: 3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/Logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Star badge
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Color(0xFF3B82F6),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF3B82F6).withValues(alpha: 0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- App Title "CritiJoy" ---
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Criti',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                        letterSpacing: 1,
                      ),
                    ),
                    TextSpan(
                      text: 'Joy',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3B82F6),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // --- Welcome subtitle ---
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  textAlign: TextAlign.center,
                  _hasSession
                      ? '¡Hola $_welcomeName!\n ¿Qué calificamos hoy?'
                      : '¡Bienvenido, $_welcomeName!',
                  style: TextStyle(
                    fontSize: 16,
                    color: subtitleColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // --- Loading Section ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    // Labels Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'INICIANDO EXPERIENCIA',
                          style: TextStyle(
                            color: labelColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          '$progressPercent%',
                          style: TextStyle(
                            color: Color(0xFF3B82F6),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Stack(
                        children: [
                          // Background track
                          Container(
                            height: 6,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: trackColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          // Orange foreground fill
                          FractionallySizedBox(
                            widthFactor: progress / 100,
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: Color(0xFF3B82F6),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
