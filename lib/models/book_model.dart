class BookModel {
  final String id;
  final String titleEn;
  final String titleAr;
  final String author;
  final String category;
  final String descriptionEn;
  final String descriptionBn;
  final List<String> languageAvailable;
  final String sourceUrl;
  final bool isOffline;

  BookModel({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.author,
    required this.category,
    required this.descriptionEn,
    required this.descriptionBn,
    required this.languageAvailable,
    required this.sourceUrl,
    required this.isOffline,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? '',
      titleEn: json['title_en'] ?? '',
      titleAr: json['title_ar'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      descriptionBn: json['description_bn'] ?? '',
      languageAvailable: List<String>.from(json['language_available'] ?? []),
      sourceUrl: json['source_url'] ?? '',
      isOffline: json['is_offline'] ?? false,
    );
  }

  String getTitleByLang(String lang) {
    if (lang == 'ar' || lang == 'ur' || lang == 'fa') {
      return titleAr.isNotEmpty ? titleAr : titleEn;
    }
    return titleEn;
  }

  String getDescriptionByLang(String lang) {
    if (lang == 'bn') {
      return descriptionBn.isNotEmpty ? descriptionBn : descriptionEn;
    }
    return descriptionEn;
  }
}
