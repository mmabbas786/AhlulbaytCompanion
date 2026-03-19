import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';
import '../../models/amaal_model.dart';

class AmaalsScreen extends StatefulWidget {
  const AmaalsScreen({super.key});

  @override
  State<AmaalsScreen> createState() => _AmaalsScreenState();
}

class _AmaalsScreenState extends State<AmaalsScreen> {
  List<AmaalModel> _amaals = [];

  @override
  void initState() {
    super.initState();
    _loadAmaals();
  }

  Future<void> _loadAmaals() async {
    final String response = await rootBundle.loadString('assets/data/amaals.json');
    final data = await json.decode(response) as List<dynamic>;
    setState(() {
      _amaals = data.map((e) => AmaalModel.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Amaal (Deeds)'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          itemCount: _amaals.length,
          itemBuilder: (context, index) {
            final amaal = _amaals[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.islamicGold.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.star, color: AppColors.islamicGold, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                amaal.getNameByLang(currentLang),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                amaal.occasion,
                                style: const TextStyle(
                                  color: AppColors.primaryTeal,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.glassBorder),
                    const SizedBox(height: 16),
                    ...amaal.actions.map((action) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 6.0, right: 12.0),
                                child: Icon(Icons.check_circle, color: AppColors.primaryTeal, size: 16),
                              ),
                              Expanded(
                                child: Text(
                                  action,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
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
