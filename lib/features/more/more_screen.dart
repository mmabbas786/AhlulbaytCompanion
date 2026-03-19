import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';

// Import all screens to navigate to
import '../quran/quran_screen.dart';
import '../amaals/amaals_screen.dart';
import '../books/books_screen.dart';
import '../quiz/quiz_screen.dart';
import '../chat/chat_screen.dart';
import '../khums/khums_screen.dart';
import '../settings/settings_screen.dart';
import '../duas/duas_list_screen.dart';
import '../calendar/calendar_screen.dart';
import '../masoomeen/masoomeen_screen.dart';
import '../qibla/qibla_screen.dart';
import '../tasbih/tasbih_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text('more'.tr()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.5,
            colors: [Color(0xFF145355), AppColors.darkBackground],
            stops: [0.0, 1.0],
          ),
        ),
        child: GridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
          children: [
            _buildGridItem(context, 'Quran', Icons.menu_book, const QuranScreen()),
            _buildGridItem(context, 'Calendar', Icons.calendar_month, const CalendarScreen()),
            _buildGridItem(context, 'Qibla', Icons.explore, const QiblaScreen()),
            
            _buildGridItem(context, 'Tasbih', Icons.ads_click, const TasbihScreen()),
            _buildGridItem(context, 'Ziyarat', Icons.place, const DuasListScreen(title: 'Ziyarat', jsonFile: 'ziyarat.json')),
            _buildGridItem(context, 'Amaals', Icons.star, const AmaalsScreen()),
            
            _buildGridItem(context, 'Masoomeen', Icons.people, const MasoomeenScreen()),
            _buildGridItem(context, 'Library', Icons.library_books, const BooksScreen()),
            _buildGridItem(context, 'Khums', Icons.calculate, const KhumsScreen()),
            
            _buildGridItem(context, 'AI Chat', Icons.smart_toy, const ChatScreen()),
            _buildGridItem(context, 'Quiz', Icons.quiz, const QuizScreen()),
            _buildGridItem(context, 'Settings', Icons.settings, const SettingsScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, IconData icon, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: GlassCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.islamicGold, size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
