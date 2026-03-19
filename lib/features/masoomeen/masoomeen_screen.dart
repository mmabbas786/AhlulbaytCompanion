import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';

class MasoomeenScreen extends StatefulWidget {
  const MasoomeenScreen({super.key});

  @override
  State<MasoomeenScreen> createState() => _MasoomeenScreenState();
}

class _MasoomeenScreenState extends State<MasoomeenScreen> {
  List<dynamic> _masoomeen = [];

  @override
  void initState() {
    super.initState();
    _loadMasoomeenData();
  }

  Future<void> _loadMasoomeenData() async {
    final String response = await rootBundle.loadString('assets/data/masoomeen.json');
    final data = await json.decode(response);
    setState(() {
      _masoomeen = data;
    });
  }

  void _showMasoomeenModal(BuildContext context, dynamic masoom) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
             color: AppColors.glassFill,
             borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Center(
                 child: Container(
                   width: 40, height: 4,
                   decoration: BoxDecoration(
                     color: AppColors.glassBorder,
                     borderRadius: BorderRadius.circular(2),
                   ),
                 ),
               ),
               const SizedBox(height: 24),
               Text(
                 masoom['name_en'],
                 style: const TextStyle(
                   color: AppColors.islamicGold,
                   fontSize: 24,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               const SizedBox(height: 8),
               Text(
                 masoom['title'],
                 style: const TextStyle(
                   color: Colors.white,
                   fontSize: 16,
                 ),
               ),
               const SizedBox(height: 24),
               _DetailRow(label: 'Father', value: masoom['father']),
               const SizedBox(height: 12),
               _DetailRow(label: 'Mother', value: masoom['mother']),
               const SizedBox(height: 12),
               _DetailRow(label: 'Birth', value: masoom['birth_date']),
               const SizedBox(height: 12),
               _DetailRow(label: 'Martyrdom/Death', value: masoom['death_date']),
               const SizedBox(height: 24),
               const Text(
                  'About',
                  style: TextStyle(
                    color: AppColors.islamicGold,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
               ),
               const SizedBox(height: 8),
               Text(
                 masoom['short_bio_en'] ?? 'Biography not available.',
                 style: const TextStyle(
                   color: Colors.white70,
                   fontSize: 15,
                   height: 1.5,
                 ),
               ),
               const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('14 Masoomeen'),
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
          itemCount: _masoomeen.length,
          itemBuilder: (context, index) {
            final masoom = _masoomeen[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GlassCard(
                onTap: () => _showMasoomeenModal(context, masoom),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.islamicGold, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          '\${index + 1}',
                          style: const TextStyle(
                            color: AppColors.islamicGold,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            masoom['name_en'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            masoom['title'],
                            style: const TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.white54),
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
