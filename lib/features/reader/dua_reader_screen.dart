import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';
import '../../models/dua_model.dart';

class DuaReaderScreen extends StatefulWidget {
  final DuaModel dua;

  const DuaReaderScreen({super.key, required this.dua});

  @override
  State<DuaReaderScreen> createState() => _DuaReaderScreenState();
}

class _DuaReaderScreenState extends State<DuaReaderScreen> {
  bool _showTransliteration = true;
  double _fontSizeOffset = 0.0;
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;
    
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text(widget.dua.getNameByLang(currentLang)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.text_decrease),
            onPressed: () => setState(() => _fontSizeOffset -= 2),
          ),
          IconButton(
            icon: const Icon(Icons.text_increase),
            onPressed: () => setState(() => _fontSizeOffset += 2),
          ),
          Switch(
            value: _showTransliteration,
            activeThumbColor: AppColors.islamicGold,
            onChanged: (val) => setState(() => _showTransliteration = val),
          ),
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
            // Top Half: Arabic + Transliteration
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: GlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.dua.arabic,
                        textAlign: TextAlign.center,
                        textDirection: ui.TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Amiri', // Needs to be added to pubspec
                          fontSize: 28 + _fontSizeOffset,
                          color: AppColors.islamicGold,
                          height: 1.8,
                        ),
                      ),
                      if (_showTransliteration) ...[
                        const SizedBox(height: 24),
                        const Divider(color: AppColors.glassBorder),
                        const SizedBox(height: 24),
                        Text(
                          widget.dua.transliteration,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18 + _fontSizeOffset,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            
            // Bottom Half: Translation
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 80), // padding for FAB
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  border: Border(top: BorderSide(color: AppColors.glassBorder)),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    widget.dua.getTranslationByLang(currentLang),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18 + _fontSizeOffset,
                      color: Colors.white,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _isPlaying = !_isPlaying;
          });
        },
        backgroundColor: AppColors.islamicGold,
        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: AppColors.darkBackground),
        label: Text(_isPlaying ? 'Pause' : 'Play Audio', style: const TextStyle(color: AppColors.darkBackground, fontWeight: FontWeight.bold)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
