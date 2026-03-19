import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/services/storage_service.dart';
import '../../core/theme/glass_components.dart';

class LanguageLocationPage extends StatefulWidget {
  const LanguageLocationPage({super.key});

  @override
  State<LanguageLocationPage> createState() => _LanguageLocationPageState();
}

class _LanguageLocationPageState extends State<LanguageLocationPage> {
  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇬🇧', 'dir': 'LTR'},
    {'code': 'ur', 'name': 'اردو', 'flag': '🇵🇰', 'dir': 'RTL'},
    {'code': 'fa', 'name': 'فارسی', 'flag': '🇮🇷', 'dir': 'RTL'},
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦', 'dir': 'RTL'},
    {'code': 'bn', 'name': 'বাংলা', 'flag': '🇧🇩', 'dir': 'LTR'},
  ];

  Future<void> _requestLocationPermission() async {
    await Permission.locationWhenInUse.request();
  }

  void _finishOnboarding() {
    StorageService().saveBool(AppStrings.onboardingDone, true);
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;

    return Container(
      color: AppColors.darkBackground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'choose_language'.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: languages.map((lang) {
                  final isSelected = currentLang == lang['code'];
                  
                  Widget cardContent = Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(lang['flag']!, style: const TextStyle(fontSize: 28)),
                      const SizedBox(height: 8),
                      Text(
                        lang['name']!,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lang['dir']!,
                        style: const TextStyle(
                            color: AppColors.textMuted, fontSize: 11),
                      ),
                    ],
                  );

                  return GestureDetector(
                    onTap: () {
                      context.setLocale(Locale(lang['code']!));
                    },
                    child: SizedBox(
                      width: (MediaQuery.of(context).size.width - 60) / 2,
                      child: isSelected
                          ? GoldGlassCard(child: cardContent)
                          : GlassCard(child: cardContent),
                    ),
                  );
                }).toList(),
              ),
              
              const Spacer(),
              
              // Location Request
              GlassCard(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryTeal.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.location_on, color: AppColors.primaryTeal),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'allow_location'.tr(),
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'location_reason'.tr(),
                            style: const TextStyle(
                                color: AppColors.textMuted, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: _requestLocationPermission,
                      child: Text(
                        'continue_btn'.tr(),
                        style: const TextStyle(color: AppColors.islamicGold),
                      ),
                    )
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                child: GlassButton(
                  onPressed: _finishOnboarding,
                  child: Text(
                    'start_app'.tr(),
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
