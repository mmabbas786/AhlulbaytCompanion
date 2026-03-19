import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';
import '../../models/quiz_question_model.dart';
import 'dart:math';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuizQuestionModel? _currentQuestion;
  int? _selectedIndex;
  bool _hasAnswered = false;

  @override
  void initState() {
    super.initState();
    _loadRandomQuestion();
  }

  Future<void> _loadRandomQuestion() async {
    final String response = await rootBundle.loadString('assets/data/quiz_questions.json');
    final data = await json.decode(response) as List<dynamic>;
    
    if (data.isNotEmpty) {
      final random = Random();
      final randomIndex = random.nextInt(data.length);
      
      setState(() {
        _currentQuestion = QuizQuestionModel.fromJson(data[randomIndex]);
        _selectedIndex = null;
        _hasAnswered = false;
      });
    }
  }

  void _submitAnswer() {
    if (_selectedIndex == null) return;
    
    setState(() {
      _hasAnswered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestion == null) {
      return const Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: Center(child: CircularProgressIndicator(color: AppColors.islamicGold)),
      );
    }

    final currentLang = context.locale.languageCode;
    final options = _currentQuestion!.getOptionsByLang(currentLang);
    final isCorrect = _selectedIndex == _currentQuestion!.correctIndex;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text('quiz'.tr()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard_outlined),
            onPressed: () {
              // Placeholder for leaderboard
            },
          ),
        ],
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
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              // Category/Difficulty Pill
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.glassFill,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryTeal.withOpacity(0.5)),
                    ),
                    child: Text(
                      _currentQuestion!.category,
                      style: const TextStyle(color: AppColors.primaryTeal, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.islamicGold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: AppColors.islamicGold, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          _currentQuestion!.difficulty,
                          style: const TextStyle(color: AppColors.islamicGold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Question
              Text(
                'Daily Challenge',
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                _currentQuestion!.getQuestionByLang(currentLang),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 48),
              
              // Options
              ...List.generate(options.length, (index) {
                final isSelected = _selectedIndex == index;
                final isCorrectOption = index == _currentQuestion!.correctIndex;
                
                Color borderColor = AppColors.glassBorder;
                Color bgColor = AppColors.glassFill;
                
                if (_hasAnswered) {
                  if (isCorrectOption) {
                    borderColor = Colors.green;
                    bgColor = Colors.green.withOpacity(0.2);
                  } else if (isSelected && !isCorrect) {
                    borderColor = Colors.red;
                    bgColor = Colors.red.withOpacity(0.2);
                  }
                } else if (isSelected) {
                  borderColor = AppColors.islamicGold;
                  bgColor = AppColors.islamicGold.withOpacity(0.1);
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor, width: isSelected || (_hasAnswered && isCorrectOption) ? 2 : 1),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: _hasAnswered ? null : () => setState(() => _selectedIndex = index),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: borderColor),
                                  color: isSelected && !_hasAnswered ? AppColors.islamicGold : Colors.transparent,
                                ),
                                child: _hasAnswered
                                    ? Icon(
                                        isCorrectOption ? Icons.check : (isSelected ? Icons.close : null),
                                        size: 18,
                                        color: isCorrectOption ? Colors.green : Colors.red,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  options[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              
              const SizedBox(height: 32),
              
              // Explanation box (if answered)
              if (_hasAnswered)
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isCorrect ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isCorrect ? Icons.check_circle : Icons.cancel,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isCorrect ? 'Correct!' : 'Incorrect',
                              style: TextStyle(
                                color: isCorrect ? Colors.green : Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _currentQuestion!.getExplanationByLang(currentLang),
                          style: const TextStyle(color: Colors.white70, height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: GlassButton(
                            onPressed: _loadRandomQuestion,
                            child: const Text('Next Question', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: GlassButton(
                    onPressed: _selectedIndex != null ? _submitAnswer : null,
                    child: const Text(
                      'Submit Answer',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
