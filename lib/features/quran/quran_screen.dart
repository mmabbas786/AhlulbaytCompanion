import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  // Mock data for 114 Surahs
  final List<Map<String, dynamic>> _surahs = List.generate(114, (index) => {
    'number': index + 1,
    'nameEn': 'Surah \${index + 1}',
    'nameAr': 'سورة', // Would map to actual Arabic names
    'revelationType': index % 2 == 0 ? 'Meccan' : 'Medinan',
    'numberOfAyahs': (index * 7) % 200 + 3,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Holy Quran'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
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
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _surahs.length,
          itemBuilder: (context, index) {
            final surah = _surahs[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GlassCard(
                onTap: () {
                  // Navigate to Surah Reader
                },
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.star_border, color: AppColors.islamicGold, size: 48),
                        Text(
                          surah['number'].toString(),
                          style: const TextStyle(
                            color: AppColors.darkBackground,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surah['nameEn'],
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                surah['revelationType'].toUpperCase(),
                                style: const TextStyle(color: AppColors.primaryTeal, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.circle, size: 4, color: AppColors.textMuted),
                              const SizedBox(width: 8),
                              Text(
                                "\${surah['numberOfAyahs']} Verses",
                                style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      surah['nameAr'],
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontFamily: 'Amiri',
                        color: AppColors.islamicGold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
