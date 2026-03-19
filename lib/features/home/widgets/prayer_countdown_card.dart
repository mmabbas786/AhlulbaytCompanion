import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/theme/glass_components.dart';

class PrayerCountdownCard extends StatelessWidget {
  const PrayerCountdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Maghrib',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('18:45', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '-02:15:40',
            style: TextStyle(
              color: AppColors.islamicGold,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: const LinearProgressIndicator(
              value: 0.7,
              backgroundColor: AppColors.glassBorder,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.islamicGold),
              minHeight: 4,
            ),
          )
        ],
      ),
    );
  }
}
