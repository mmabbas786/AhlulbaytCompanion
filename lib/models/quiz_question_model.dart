class QuizQuestionModel {
  final String id;
  final String questionEn;
  final String questionUr;
  final String questionFa;
  final String questionAr;
  final String questionBn;
  final List<String> optionsEn;
  final List<String> optionsUr;
  final List<String> optionsFa;
  final List<String> optionsAr;
  final List<String> optionsBn;
  final int correctIndex;
  final String explanationEn;
  final String explanationUr;
  final String explanationFa;
  final String explanationAr;
  final String explanationBn;
  final String category;
  final String difficulty;

  QuizQuestionModel({
    required this.id,
    required this.questionEn,
    required this.questionUr,
    required this.questionFa,
    required this.questionAr,
    required this.questionBn,
    required this.optionsEn,
    required this.optionsUr,
    required this.optionsFa,
    required this.optionsAr,
    required this.optionsBn,
    required this.correctIndex,
    required this.explanationEn,
    required this.explanationUr,
    required this.explanationFa,
    required this.explanationAr,
    required this.explanationBn,
    required this.category,
    required this.difficulty,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      id: json['id'] ?? '',
      questionEn: json['question_en'] ?? '',
      questionUr: json['question_ur'] ?? '',
      questionFa: json['question_fa'] ?? '',
      questionAr: json['question_ar'] ?? '',
      questionBn: json['question_bn'] ?? '',
      optionsEn: List<String>.from(json['options_en'] ?? []),
      optionsUr: List<String>.from(json['options_ur'] ?? []),
      optionsFa: List<String>.from(json['options_fa'] ?? []),
      optionsAr: List<String>.from(json['options_ar'] ?? []),
      optionsBn: List<String>.from(json['options_bn'] ?? []),
      correctIndex: json['correct_index'] ?? 0,
      explanationEn: json['explanation_en'] ?? '',
      explanationUr: json['explanation_ur'] ?? '',
      explanationFa: json['explanation_fa'] ?? '',
      explanationAr: json['explanation_ar'] ?? '',
      explanationBn: json['explanation_bn'] ?? '',
      category: json['category'] ?? '',
      difficulty: json['difficulty'] ?? '',
    );
  }

  String getQuestionByLang(String lang) {
    switch (lang) {
      case 'ar': return questionAr;
      case 'ur': return questionUr;
      case 'fa': return questionFa;
      case 'bn': return questionBn;
      default: return questionEn;
    }
  }

  List<String> getOptionsByLang(String lang) {
    switch (lang) {
      case 'ar': return optionsAr;
      case 'ur': return optionsUr;
      case 'fa': return optionsFa;
      case 'bn': return optionsBn;
      default: return optionsEn;
    }
  }

  String getExplanationByLang(String lang) {
    switch (lang) {
      case 'ar': return explanationAr;
      case 'ur': return explanationUr;
      case 'fa': return explanationFa;
      case 'bn': return explanationBn;
      default: return explanationEn;
    }
  }
}
