import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../features/prayer/prayer_screen.dart';
import 'widgets/prayer_countdown_card.dart';
import 'widgets/occasion_card.dart';
import 'widgets/quick_access_grid.dart';
import 'widgets/daily_hadith_card.dart';
import '../duas/duas_list_screen.dart';
import '../hadith/hadith_screen.dart';
import '../more/more_screen.dart';
import '../settings/settings_screen.dart';
import '../../core/services/admob_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // For floating bottom nav bar
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const _HomeTab(),
          const PrayerScreen(),
          const DuasListScreen(title: 'Daily Duas', jsonFile: 'duas.json'),
          const HadithScreen(),
          const MoreScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.glassFill,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.islamicGold,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: 'home'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.mosque_outlined),
              activeIcon: const Icon(Icons.mosque),
              label: 'prayers'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.back_hand_outlined), // hands icon approximation
              activeIcon: const Icon(Icons.back_hand),
              label: 'duas'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.menu_book_outlined),
              activeIcon: const Icon(Icons.menu_book),
              label: 'hadith'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.grid_view_outlined),
              activeIcon: const Icon(Icons.grid_view),
              label: 'more'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.5,
          colors: [
            Color(0xFF145355), // Teal glow at top
            AppColors.darkBackground,
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            // 1. Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'assalamu_alaikum'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      '14 Shawwal 1447', // Fixed for placeholder, replace with hijri pkg
                      style: TextStyle(
                        color: AppColors.islamicGold,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                  },
                )
              ],
            ),
            const SizedBox(height: 24),
            
            // 2. Next Prayer Countdown
            const PrayerCountdownCard(),
            const SizedBox(height: 16),
            
            // 3. Today's Occasion
            const OccasionCard(),
            const SizedBox(height: 24),
            
            // 4. Quick Access Grid
            const QuickAccessGrid(),
            const SizedBox(height: 24),
            
            // 5. Daily Hadith
            const DailyHadithCard(),
            const SizedBox(height: 16),
            
            // 6. Muharram Countdown Pill
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.glassFill,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.islamicGold.withOpacity(0.5)),
                ),
                child: const Text(
                  '85 Days until Muharram',
                  style: TextStyle(color: AppColors.islamicGold, fontSize: 13),
                ),
              ),
            ),
            
            // 7. Space for AdMob banner
            Container(
              margin: const EdgeInsets.only(top: 16),
              alignment: Alignment.center,
              child: AdMobService().getHomeBanner(),
            ),
            const SizedBox(height: 100), // padding for bottom nav
          ],
        ),
      ),
    );
  }
}