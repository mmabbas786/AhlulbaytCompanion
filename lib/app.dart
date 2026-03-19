import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import 'core/theme/app_theme.dart';
import 'core/services/storage_service.dart';

// Placeholder screen imports
import 'features/onboarding/onboarding_screen.dart';
import 'features/home/home_screen.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const _AppRoot(),
    );
  }
}

class _AppRoot extends StatelessWidget {
  const _AppRoot();

  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;
    const rtlLanguages = ['ur', 'fa', 'ar'];
    
    // Always LTR for Bengali and English
    // RTL for Urdu, Farsi, Arabic
    final textDirection = rtlLanguages.contains(currentLang) 
        ? ui.TextDirection.rtl 
        : ui.TextDirection.ltr;

    final themeProvider = Provider.of<ThemeProvider>(context);

    // Initial route depends on onboarding status
    final hasOnboarded = StorageService().getBool('onboarding_done', defaultValue: false);
    final initialRoute = hasOnboarded ? '/home' : '/onboarding';

    final router = GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        // Add other routes as we build them out
      ],
    );

    return Directionality(
      textDirection: textDirection,
      child: MaterialApp.router(
        title: 'Ahlulbayt Companion',
        debugShowCheckedModeBanner: false,
        
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        
        themeMode: themeProvider.themeMode,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        // Using high contrast dark theme slot to hold amoled theme easily (or manage dynamically)
        highContrastDarkTheme: AppTheme.amoledTheme,
        
        routerConfig: router,
      ),
    );
  }
}
