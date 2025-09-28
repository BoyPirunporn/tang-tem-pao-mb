import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/provider/current_user_notifier.dart';
import 'package:tang_tem_pao_mb/feature/auth/view/pages/auth_page.dart';
import 'package:tang_tem_pao_mb/feature/auth/viewmodel/auth_viewmodel.dart';
import 'package:tang_tem_pao_mb/home_page.dart';
import 'package:tang_tem_pao_mb/splash_screen.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final authInitializer = ref.watch(authInitializerProvider);
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: authInitializer.when(
          loading: () => SplashScreen(),
          error: (error, stackTrace) => const AuthPage(),
          data: (_) {
            print("has data");
            return currentUser != null ? const HomePage() : const AuthPage();
          },
        ),
      ),
    );
  }
}
