import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';
import '../../models/hadith_model.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({super.key});

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  List<HadithModel> _hadiths = [];
  String _searchQuery = '';
  
  // Nahjul Balagha toggle
  bool _showNahjulBalagha = false;

  @override
  void initState() {
    super.initState();
    _loadHadiths();
  }

  Future<void> _loadHadiths() async {
    final String response = await rootBundle.loadString('assets/data/hadiths.json');
    final data = await json.decode(response) as List<dynamic>;
    setState(() {
      _hadiths = data.map((e) => HadithModel.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;
    
    final filteredHadiths = _hadiths.where((h) {
      final textMatches = h.getTranslationByLang(currentLang).toLowerCase().contains(_searchQuery.toLowerCase()) || 
                          h.topic.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final bookMatches = _showNahjulBalagha ? h.book.contains('Nahj al-Balagha') : true;

      return textMatches && bookMatches;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text('hadith'.tr()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_showNahjulBalagha ? Icons.book : Icons.menu_book),
            onPressed: () => setState(() => _showNahjulBalagha = !_showNahjulBalagha),
            tooltip: 'Toggle Nahjul Balagha',
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search hadiths by keyword or topic...',
                    hintStyle: const TextStyle(color: AppColors.textMuted),
                    icon: const Icon(Icons.search, color: AppColors.islamicGold),
                    border: InputBorder.none,
                  ),
                  onChanged: (val) => setState(() => _searchQuery = val),
                ),
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredHadiths.length,
                itemBuilder: (context, index) {
                  final h = filteredHadiths[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GlassCard(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                h.imam,
                                style: const TextStyle(
                                  color: AppColors.islamicGold,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryTeal.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  h.topic,
                                  style: const TextStyle(color: AppColors.primaryTeal, fontSize: 12),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            h.arabic,
                            textAlign: TextAlign.right,
                            textDirection: ui.TextDirection.rtl,
                            style: const TextStyle(
                              fontFamily: 'Amiri',
                              color: Colors.white,
                              fontSize: 22,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(color: AppColors.glassBorder),
                          const SizedBox(height: 16),
                          Text(
                            h.getTranslationByLang(currentLang),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\${h.book}, \${h.number}',
                                style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy, size: 18, color: AppColors.textMuted),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: '\${h.arabic}\\n\\n\${h.getTranslationByLang(currentLang)}\\n- \${h.imam} (\${h.book})'));
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
