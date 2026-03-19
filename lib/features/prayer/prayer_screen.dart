import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.5,
          colors: [
            Color(0xFF145355), // Teal glow
            AppColors.darkBackground,
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'prayers'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      // Navigate to prayer settings
                    },
                  ),
                ],
              ),
            ),
            
            // Big Circle Chart placeholder
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.islamicGold, width: 8),
                color: AppColors.glassFill,
              ),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Maghrib',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '-02:15:40',
                      style: TextStyle(
                        color: AppColors.islamicGold,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // List of 6 times
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _PrayerTimeRow(name: 'Imsak', time: '04:10 AM', isPassed: true),
                  _PrayerTimeRow(name: 'Fajr', time: '04:25 AM', isPassed: true),
                  _PrayerTimeRow(name: 'Sunrise', time: '05:40 AM', isPassed: true),
                  _PrayerTimeRow(name: 'Dhuhr', time: '12:15 PM', isPassed: true),
                  _PrayerTimeRow(name: 'Asr', time: '03:45 PM', isPassed: true),
                  _PrayerTimeRow(name: 'Maghrib', time: '06:45 PM', isNext: true),
                  _PrayerTimeRow(name: 'Isha', time: '07:10 PM'),
                  _PrayerTimeRow(name: 'Midnight', time: '11:30 PM'),
                  const SizedBox(height: 100), // Space for bottom nav AND fab
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrayerTimeRow extends StatelessWidget {
  final String name;
  final String time;
  final bool isPassed;
  final bool isNext;

  const _PrayerTimeRow({
    required this.name,
    required this.time,
    this.isPassed = false,
    this.isNext = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isNext) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GoldGlassCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                color: isPassed ? AppColors.textMuted : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                color: isPassed ? AppColors.textMuted : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
