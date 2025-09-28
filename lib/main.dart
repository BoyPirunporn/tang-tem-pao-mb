import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/core/provider/theme_mode_notifier.dart';
import 'package:tang_tem_pao_mb/core/theme/app_theme.dart';
import 'package:tang_tem_pao_mb/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(
      themeModeProvider,
    ); // ThemeMode.system / dark / light

    return MaterialApp(
      title: 'Tang Tem Pao',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      home: LandingPage(),
    );
  }
}
