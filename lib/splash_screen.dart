import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A splash screen with an animation of coins falling into a piggy bank.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// [!] Use TickerProviderStateMixin to handle multiple AnimationControllers
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _jiggleController;

  // late List<CoinAnimation> _coinAnimations;
  late Animation<double> _iconScaleAnimation;

  @override
  void initState() {
    super.initState();

    // --- Controller for one-time animations (coins, text fade-in) ---
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // --- Controller for the continuous piggy bank jiggle ---
    _jiggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Coins are tied to the main, one-time controller
    // _coinAnimations = List.generate(20, (index) {
    //   return CoinAnimation(
    //     controller: _mainController, // Use the main controller
    //     startDelay: 0.15 + (index * 0.02),
    //     random: Random(index),
    //   );
    // });

    // The jiggle animation is a simple scale tween, driven by its own repeating controller
    _iconScaleAnimation = Tween<double>(begin: 0.98, end: 1.2).animate(
      CurvedAnimation(
        parent: _jiggleController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animations
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        // Run the main animation (coins, text) only once
        _mainController.forward();

        // The jiggle starts after the icon has appeared
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            // Repeat the jiggle animation indefinitely
            _jiggleController.repeat(reverse: true);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _jiggleController.dispose(); // Dispose both controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primaryContainer.withValues(alpha:0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // Rebuild the widget tree whenever any animation value changes
          child: AnimatedBuilder(
            animation: Listenable.merge([_mainController, _jiggleController]),
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  _buildMainContent(),
                  // ..._coinAnimations.map((anim) => anim.build(context)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    // This animation is driven by the main, one-time controller
    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
    ));

    // This animation is also driven by the main, one-time controller
    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // This widget uses the separate, repeating jiggle animation
            ScaleTransition(
              scale: _iconScaleAnimation,
              child: Icon(
                Icons.savings_rounded,
                size: 120,
                color: Theme.of(context).colorScheme.onPrimary,
                 shadows: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.2),
                    blurRadius: 12,
                    offset: const Offset(4, 4),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Tang Tem Pao',
              style: GoogleFonts.kanit(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'เติมเงินให้เต็มกระเป๋า',
              style: GoogleFonts.kanit(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper class to manage the state and animation of a single coin
// This class does not need any changes.
class CoinAnimation {
  final AnimationController controller;
  final double startDelay;
  final Random random;

  late Animation<double> _moveAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotateAnimation;

  final double startX;
  final double endX;
  final double coinSize;

  CoinAnimation({
    required this.controller,
    required this.startDelay,
    required this.random,
  })  : startX = (random.nextDouble() - 0.5) * 400,
        endX = (random.nextDouble() - 0.5) * 60,
        coinSize = 20 + random.nextDouble() * 20 {
    
    final double fallDuration = 0.4 + random.nextDouble() * 0.2;
    final double endDelay = (startDelay + fallDuration).clamp(0.0, 1.0);

    _moveAnimation = CurvedAnimation(
      parent: controller,
      curve: Interval(startDelay, endDelay, curve: Curves.easeIn),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(endDelay - 0.05, endDelay, curve: Curves.easeOut),
      ),
    );
    
    _rotateAnimation = Tween<double>(begin: 0, end: 0.5 + random.nextDouble() * 1.5).animate(
       CurvedAnimation(
        parent: controller,
        curve: Interval(startDelay, endDelay, curve: Curves.linear),
      ),
    );
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final startY = -screenHeight * 0.2;
    final endY = (screenHeight / 2) - 80;

    return Positioned(
      top: startY + (endY - startY) * _moveAnimation.value,
      left: (MediaQuery.of(context).size.width / 2) + startX + (endX - startX) * _moveAnimation.value,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: RotationTransition(
          turns: _rotateAnimation,
          child: Icon(
            Icons.monetization_on,
            color: Colors.amber.shade400,
            size: coinSize,
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(2, 2),
              )
            ],
          ),
        ),
      ),
    );
  }
}

