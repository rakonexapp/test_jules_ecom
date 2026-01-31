import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _dotsController;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7528F0),
      body: Stack(
        children: [
          // Decorative Background Elements
          Positioned(
            top: -100,
            left: -100,
            child: _BlurredCircle(
              size: 400,
              color: Colors.white.withOpacity(0.03),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: _BlurredCircle(
              size: 300,
              color: Colors.white.withOpacity(0.05),
            ),
          ),

          // Central Content
          Center(
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.05).animate(
                CurvedAnimation(
                  parent: _logoController,
                  curve: Curves.easeInOut,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo Container
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          size: 50,
                          color: Color(0xFF7528F0),
                        ),
                      ),
                      // Badge
                      Positioned(
                        top: -5,
                        right: -5,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF7528F0),
                              width: 4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Brand Name
                  const Text(
                    'Flipkart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'EXPLORE PLUS',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Footer
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Bouncing Dots
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(3, (index) {
                      return _BouncingDot(
                        index: index,
                        controller: _dotsController,
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "INDIA'S FAVORITE STORE",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlurredCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _BlurredCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}

class _BouncingDot extends StatelessWidget {
  final int index;
  final AnimationController controller;

  const _BouncingDot({required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Create a staggered bounce effect
        double start = index * 0.2;
        double end = start + 0.6;
        double value = 0.0;

        double curveValue = (controller.value * 1.5); // Speed it up a bit
        if (curveValue > start && curveValue < end) {
          double localValue = (curveValue - start) / 0.6;
          value = Curves.easeInOut.transform(
            localValue < 0.5 ? localValue * 2 : (1 - localValue) * 2,
          );
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          transform: Matrix4.translationValues(0, -10 * value, 0),
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
