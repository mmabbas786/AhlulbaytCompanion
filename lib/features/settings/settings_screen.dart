import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';
import '../../core/constants/strings.dart';
import '../../core/services/storage_service.dart';
import '../../app.dart'; // To access ThemeProvider

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final StorageService _storage = StorageService();
  double _fontSize = 24.0;
  bool _showTranslation = true;
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    setState(() {
      _showTranslation = _storage.getBool('show_translation', defaultValue: true);
      _notificationsEnabled = _storage.getBool('notifications_enabled', defaultValue: true);
      // A full implementation would save font size as well
    });
  }

  void _changeLanguage(String langCode) {
    context.setLocale(Locale(langCode));
  }

  void _changeTheme(ThemeMode mode) {
    Provider.of<ThemeProvider>(context, listen: false).setTheme(mode);
  }

  void _changeMarja(String marjaId) {
    _storage.saveString(AppStrings.marjaPreference, marjaId);
    setState(() {}); // Trigger rebuild
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentMarja = _storage.getString(AppStrings.marjaPreference) ?? 'sistani';

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Settings'),
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
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionHeader('Appearance'),
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _ListTileOption(
                    title: 'Dark Theme',
                    trailing: Radio<ThemeMode>(
                      value: ThemeMode.dark,
                      groupValue: themeProvider.themeMode,
                      activeColor: AppColors.islamicGold,
                      onChanged: (val) => _changeTheme(val!),
                    ),
                  ),
                  _ListTileOption(
                    title: 'AMOLED Black',
                    trailing: Radio<ThemeMode>(
                      value: ThemeMode.system, // Placeholder for AMOLED in the provider logic
                      groupValue: themeProvider.themeMode,
                      activeColor: AppColors.islamicGold,
                      onChanged: (val) => _changeTheme(val!),
                    ),
                  ),
                  _ListTileOption(
                    title: 'Light Theme',
                    trailing: Radio<ThemeMode>(
                      value: ThemeMode.light,
                      groupValue: themeProvider.themeMode,
                      activeColor: AppColors.islamicGold,
                      onChanged: (val) => _changeTheme(val!),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSectionHeader('Language'),
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                   _buildLanguageOption('English', 'en'),
                   _buildLanguageOption('اردو', 'ur'),
                   _buildLanguageOption('فارسی', 'fa'),
                   _buildLanguageOption('العربية', 'ar'),
                   _buildLanguageOption('বাংলা', 'bn'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Fiqh / Marja Preference'),
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _ListTileOption(
                    title: 'Ayatollah Sistani',
                    trailing: Radio<String>(
                      value: 'sistani',
                      groupValue: currentMarja,
                      activeColor: AppColors.islamicGold,
                      onChanged: (val) => _changeMarja(val!),
                    ),
                  ),
                  _ListTileOption(
                    title: 'Ayatollah Khamenei',
                    trailing: Radio<String>(
                      value: 'khamenei',
                      groupValue: currentMarja,
                      activeColor: AppColors.islamicGold,
                      onChanged: (val) => _changeMarja(val!),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Reading Preferences'),
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ListTileOption(
                    title: 'Show Translation',
                    trailing: Switch(
                      value: _showTranslation,
                      activeThumbColor: AppColors.islamicGold,
                      onChanged: (val) {
                        setState(() => _showTranslation = val);
                        _storage.saveBool('show_translation', val);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Arabic Font Size', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Slider(
                    value: _fontSize,
                    min: 16,
                    max: 48,
                    activeColor: AppColors.islamicGold,
                    inactiveColor: AppColors.glassBorder,
                    onChanged: (val) => setState(() => _fontSize = val),
                  ),
                  Center(
                    child: Text(
                      'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                      style: TextStyle(fontFamily: 'Amiri', fontSize: _fontSize, color: AppColors.islamicGold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Notifications'),
            GlassCard(
              padding: const EdgeInsets.all(16),
              child: _ListTileOption(
                title: 'Prayer Time Alerts',
                trailing: Switch(
                  value: _notificationsEnabled,
                  activeThumbColor: AppColors.islamicGold,
                  onChanged: (val) {
                    setState(() => _notificationsEnabled = val);
                    _storage.saveBool('notifications_enabled', val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.islamicGold,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String name, String code) {
    final isSelected = context.locale.languageCode == code;
    return _ListTileOption(
      title: name,
      trailing: isSelected ? const Icon(Icons.check, color: AppColors.islamicGold) : const SizedBox(),
      onTap: () => _changeLanguage(code),
    );
  }
}

class _ListTileOption extends StatelessWidget {
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  const _ListTileOption({
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
            trailing,
          ],
        ),
      ),
    );
  }
}
