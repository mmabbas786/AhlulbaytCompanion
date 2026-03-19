class HadithModel {
  final String id;
  final String book;
  final String type;
  final String number;
  final String imam;
  final String arabic;
  final String english;
  final String urdu;
  final String farsi;
  final String bengali;
  final String topic;
  final String authenticity;

  HadithModel({
    required this.id,
    required this.book,
    required this.type,
    required this.number,
    required this.imam,
    required this.arabic,
    required this.english,
    required this.urdu,
    required this.farsi,
    required this.bengali,
    required this.topic,
    required this.authenticity,
  });

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      id: json['id'] ?? '',
      book: json['book'] ?? '',
      type: json['type'] ?? '',
      number: json['number'] ?? '',
      imam: json['imam'] ?? '',
      arabic: json['arabic'] ?? '',
      english: json['english'] ?? '',
      urdu: json['urdu'] ?? '',
      farsi: json['farsi'] ?? '',
      bengali: json['bengali'] ?? '',
      topic: json['topic'] ?? '',
      authenticity: json['authenticity'] ?? '',
    );
  }

  String getTranslationByLang(String lang) {
    switch (lang) {
      case 'ur': return urdu;
      case 'fa': return farsi;
      case 'bn': return bengali;
      case 'ar': return arabic; // Assuming fallback or specific usage
      default: return english;
    }
  }
}
