import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/theme/glass_components.dart';
import '../../../core/constants/colors.dart';
import '../../qibla/qibla_screen.dart';
import '../../tasbih/tasbih_screen.dart';
import '../../quiz/quiz_screen.dart';
import '../../chat/chat_screen.dart';

class QuickAccessGrid extends StatelessWidget {
  const QuickAccessGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'quick_access'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _QuickAccessItem(
                icon: Icons.explore_outlined,
                label: 'qibla'.tr(),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const QiblaScreen()));
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickAccessItem(
                icon: Icons.radio_button_checked,
                label: 'tasbih'.tr(),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const TasbihScreen()));
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickAccessItem(
                icon: Icons.quiz_outlined,
                label: 'quiz'.tr(),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _QuickAccessItem(
                icon: Icons.smart_toy_outlined,
                label: 'ai_chat'.tr(),
                isAhlulbaytAI: true,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen()));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickAccessItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isAhlulbaytAI;

  const _QuickAccessItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isAhlulbaytAI = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isAhlulbaytAI) {
      return GoldGlassCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            Icon(icon, color: AppColors.islamicGold, size: 32),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
    
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryTeal, size: 32),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
