class AmaalModel {
  final String id;
  final String nameEn;
  final String nameUr;
  final String nameFa;
  final String nameAr;
  final String nameBn;
  final String category;
  final String occasion;
  final List<String> actions;

  AmaalModel({
    required this.id,
    required this.nameEn,
    required this.nameUr,
    required this.nameFa,
    required this.nameAr,
    required this.nameBn,
    required this.category,
    required this.occasion,
    required this.actions,
  });

  factory AmaalModel.fromJson(Map<String, dynamic> json) {
    return AmaalModel(
      id: json['id'] ?? '',
      nameEn: json['name_en'] ?? '',
      nameUr: json['name_ur'] ?? '',
      nameFa: json['name_fa'] ?? '',
      nameAr: json['name_ar'] ?? '',
      nameBn: json['name_bn'] ?? '',
      category: json['category'] ?? '',
      occasion: json['occasion'] ?? '',
      actions: List<String>.from(json['actions'] ?? []),
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
}
