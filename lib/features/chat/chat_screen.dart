import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/glass_components.dart';
import '../../core/services/claude_api_service.dart';
import '../../core/services/storage_service.dart';
import '../../core/constants/strings.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _messages.add({
      'role': 'ai',
      'content': 'Salam! I am Ahlulbayt AI. How can I help you regarding Twelver Shia Islam today?'
    });
  }

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userText = _controller.text.trim();
    setState(() {
      _messages.add({'role': 'user', 'content': userText});
      _isLoading = true;
    });
    
    _controller.clear();

    try {
      final marja = StorageService().getString(AppStrings.marjaPreference) ?? 'sistani';
      final lang = context.locale.languageCode;
      
      String langName = 'English';
      if (lang == 'ur') langName = 'Urdu';
      if (lang == 'ar') langName = 'Arabic';
      if (lang == 'fa') langName = 'Farsi';
      if (lang == 'bn') langName = 'Bengali';

      final response = await ClaudeApiService().getResponse(
        message: userText,
        marjaName: marja,
        languageName: langName,
      );

      setState(() {
        _messages.add({'role': 'ai', 'content': response});
      });
    } catch (e) {
      setState(() {
        _messages.add({'role': 'ai', 'content': 'Error: Could not connect to the service. Please check your internet connection and API key.'});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.smart_toy, color: AppColors.islamicGold),
            const SizedBox(width: 8),
            Text('ai_chat'.tr()),
          ],
        ),
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg['role'] == 'user';
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isUser 
                              ? AppColors.primaryTeal.withOpacity(0.8) 
                              : AppColors.glassFill,
                          border: Border.all(
                            color: isUser 
                                ? AppColors.primaryTeal 
                                : AppColors.glassBorder,
                          ),
                          borderRadius: BorderRadius.circular(20).copyWith(
                            bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(20),
                            bottomLeft: !isUser ? const Radius.circular(0) : const Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          msg['content']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text('Ahlulbayt AI is typing...', style: TextStyle(color: AppColors.textMuted)),
              ),
            
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Ask a question...',
                          hintStyle: TextStyle(color: AppColors.textMuted),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: AppColors.islamicGold),
                      onPressed: _isLoading ? null : _sendMessage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
