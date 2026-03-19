import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/services/storage_service.dart';
import '../../core/theme/glass_components.dart';

class MarjaSelectionPage extends StatefulWidget {
  final VoidCallback onNext;

  const MarjaSelectionPage({super.key, required this.onNext});

  @override
  State<MarjaSelectionPage> createState() => _MarjaSelectionPageState();
}

class _MarjaSelectionPageState extends State<MarjaSelectionPage> {
  String? _selectedMarja;

  final List<Map<String, String>> marjas = [
    {'id': 'sistani', 'name': 'sistani'},
    {'id': 'khamenei', 'name': 'khamenei'},
    {'id': 'other', 'name': 'other_scholar'},
  ];

  void _selectMarja(String id) {
    setState(() {
      _selectedMarja = id;
    });
    StorageService().saveString(AppStrings.marjaPreference, id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBackground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Text(
                'choose_marja'.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              
              Expanded(
                child: ListView.separated(
                  itemCount: marjas.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final marja = marjas[index];
                    final isSelected = _selectedMarja == marja['id'];
                    
                    return isSelected
                        ? GoldGlassCard(
                            onTap: () => _selectMarja(marja['id']!),
                            child: _buildMarjaContent(marja['name']!.tr(), isSelected),
                          )
                        : GlassCard(
                            onTap: () => _selectMarja(marja['id']!),
                            child: _buildMarjaContent(marja['name']!.tr(), isSelected),
                          );
                  },
                ),
              ),
              
              SizedBox(
                width: double.infinity,
                child: GlassButton(
                  onPressed: _selectedMarja != null ? widget.onNext : null,
                  child: Text(
                    'continue_btn'.tr(),
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

  Widget _buildMarjaContent(String name, bool isSelected) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? AppColors.islamicGold : AppColors.glassBorder,
              width: 2,
            ),
          ),
          child: isSelected
              ? Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.islamicGold,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
