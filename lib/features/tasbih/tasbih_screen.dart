import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int _count = 0;
  int _totalCount = 0;
  int _target = 34; // Start with Allahu Akbar

  // State for Tasbih of Fatima Zahra
  int _phase = 0; // 0=Allahu Akbar, 1=Alhamdulillah, 2=Subhanallah

  final List<Map<String, dynamic>> _phases = [
    {'name': 'Allahu Akbar', 'target': 34, 'color': AppColors.islamicGold},
    {'name': 'Alhamdulillah', 'target': 33, 'color': AppColors.primaryTeal},
    {'name': 'Subhanallah', 'target': 33, 'color': Colors.blueGrey},
  ];

  void _increment() {
    setState(() {
      _count++;
      _totalCount++;

      // Haptic feedback
      if (_count == _target) {
        HapticFeedback.heavyImpact();
      } else {
        HapticFeedback.selectionClick();
      }
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
      _totalCount = 0;
      _phase = 0;
      _target = _phases[_phase]['target'];
    });
    HapticFeedback.mediumImpact();
  }

  void _nextPhase() {
    if (_phase < 2) {
      setState(() {
        _phase++;
        _count = 0;
        _target = _phases[_phase]['target'];
      });
      HapticFeedback.mediumImpact();
    } else {
      _reset(); // Completed full tasbih
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text('tasbih'.tr()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
          )
        ],
      ),
      body: GestureDetector(
        onTap: _increment, // Tap anywhere to count
        behavior: HitTestBehavior.opaque, // Entire screen acts as button
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [Color(0xFF145355), AppColors.darkBackground],
              stops: [0.0, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                
                // Active Phrase
                Text(
                  _phases[_phase]['name'],
                  style: TextStyle(
                    color: _phases[_phase]['color'],
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48),
                
                // Main Counter
                Center(
                  child: GlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 48),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$_count / $_target',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Next Phase Button (Only show if target reached)
                if (_count >= _target)
                  GlassButton(
                    onPressed: _nextPhase,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                      child: Text(
                        _phase < 2 ? 'Next Phrase' : 'Finish',
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 64),
                  
                const Spacer(),
                
                // Total Count
                Text(
                  'Total: $_totalCount',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
