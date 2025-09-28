import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/feature/auth/view/widgets/overlay_clipper.dart';
import 'package:tang_tem_pao_mb/feature/auth/view/widgets/sign_in_form.dart';
import 'package:tang_tem_pao_mb/feature/auth/view/widgets/sign_up_form.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  bool _isSignUp = false;
  double _overlayTopPosition = 0; // State to control overlay position
  bool _isAnimating = false;

  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize the overlay position to be off-screen at the bottom
    _overlayTopPosition = MediaQuery.of(context).size.height;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleToggle() {
    // Prevent spamming the toggle button while animating
    if (_isAnimating) return;

    setState(() {
      _isAnimating = true;
      // Move overlay up to cover the screen
      _overlayTopPosition = 0;
    });

    // Wait for the slide-up animation to complete
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        // Switch the form underneath
        _isSignUp = !_isSignUp;
      });

      // After a short delay to ensure the form has switched,
      // move the overlay back down to reveal the new form
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _overlayTopPosition = MediaQuery.of(context).size.height;
          _isAnimating = false; // Animation cycle complete
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppPallete.backgroundDark,
      body: Stack(
        children: [
          if (_isSignUp)
            SignupForm(handleToggle: _handleToggle,),
          if(!_isSignUp)
            SigninForm(handleToggle: _handleToggle,),
          
          // Animated Overlay using AnimatedPositioned
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: _overlayTopPosition,
            left: 0,
            right: 0,
            bottom: -80, // Allow the curve to be fully drawn off-screen
            child: ClipPath(
              clipper: OverlayClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppPallete.primaryDark, AppPallete.accentDark],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
