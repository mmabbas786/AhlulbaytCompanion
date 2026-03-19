import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';

class WelcomePage extends StatelessWidget {
  final VoidCallback onNext;

  const WelcomePage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [
            Color(0xFF145355), // Subtle teal glow
            AppColors.darkBackground,
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Gold crescent moon placeholder
              const Icon(
                Icons.brightness_3,
                color: AppColors.islamicGold,
                size: 80,
              ),
              const SizedBox(height: 32),
              
              Text(
                'app_name'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              
              const Text(
                "Your complete Shia companion",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 15,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Features Pills
              Wrap(
                spacing: 8.0,
                runSpacing: 12.0,
                alignment: WrapAlignment.center,
                children: [
                  _FeaturePill(text: 'prayers'.tr()),
                  _FeaturePill(text: 'ai_chat'.tr()),
                  _FeaturePill(text: 'duas'.tr()),
                ],
              ),
              
              const Spacer(),
              
              SizedBox(
                width: double.infinity,
                child: GlassButton(
                  onPressed: onNext,
                  child: Text(
                    'get_started'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturePill extends StatelessWidget {
  final String text;
  
  const _FeaturePill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.glassFill,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }
}
