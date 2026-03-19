import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/theme/glass_components.dart';

class DailyHadithCard extends StatelessWidget {
  const DailyHadithCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book, color: AppColors.islamicGold, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Daily Hadith',
                style: TextStyle(
                  color: AppColors.islamicGold,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {},
              )
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '"Verily, the most honorable of you in the sight of Allah is the most righteous of you."',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '- Prophet Muhammad (sawa)',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            'Bihar al-Anwar, v. 67, p. 282',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
