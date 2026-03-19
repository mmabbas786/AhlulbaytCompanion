class ZiyaratModel {
  final String id;
  final String nameEn;
  final String nameUr;
  final String nameFa;
  final String nameAr;
  final String nameBn;
  final String category;
  final String occasion;
  final String arabic;
  final String transliteration;
  final String translationEn;
  final String translationUr;
  final String translationFa;
  final String translationAr;
  final String translationBn;
  final String imam;
  final String source;
  final String audioUrl;
  final int durationMinutes;

  ZiyaratModel({
    required this.id,
    required this.nameEn,
    required this.nameUr,
    required this.nameFa,
    required this.nameAr,
    required this.nameBn,
    required this.category,
    required this.occasion,
    required this.arabic,
    required this.transliteration,
    required this.translationEn,
    required this.translationUr,
    required this.translationFa,
    required this.translationAr,
    required this.translationBn,
    required this.imam,
    required this.source,
    required this.audioUrl,
    required this.durationMinutes,
  });

  factory ZiyaratModel.fromJson(Map<String, dynamic> json) {
    return ZiyaratModel(
      id: json['id'] ?? '',
      nameEn: json['name_en'] ?? '',
      nameUr: json['name_ur'] ?? '',
      nameFa: json['name_fa'] ?? '',
      nameAr: json['name_ar'] ?? '',
      nameBn: json['name_bn'] ?? '',
      category: json['category'] ?? '',
      occasion: json['occasion'] ?? '',
      arabic: json['arabic'] ?? '',
      transliteration: json['transliteration'] ?? '',
      translationEn: json['translation_en'] ?? '',
      translationUr: json['translation_ur'] ?? '',
      translationFa: json['translation_fa'] ?? '',
      translationAr: json['translation_ar'] ?? '',
      translationBn: json['translation_bn'] ?? '',
      imam: json['imam'] ?? '',
      source: json['source'] ?? '',
      audioUrl: json['audio_url'] ?? '',
      durationMinutes: json['duration_minutes'] ?? 0,
    );
  }

  String getNameByLang(String lang) {
    switch (lang) {
      case 'ar': return nameAr;
      case 'ur': return nameUr;
      case 'fa': return nameFa;
      case 'bn': return nameBn;
      default: return nameEn;
    }
  }

  String getTranslationByLang(String lang) {
    switch (lang) {
      case 'ar': return translationAr;
      case 'ur': return translationUr;
      case 'fa': return translationFa;
      case 'bn': return translationBn;
      default: return translationEn;
    }
  }
}
