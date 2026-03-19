import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'marja_selection_page.dart';
import 'language_location_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  
  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Only navigate via buttons
        children: [
          WelcomePage(onNext: _nextPage),
          MarjaSelectionPage(onNext: _nextPage),
          const LanguageLocationPage(),
        ],
      ),
    );
  }
}