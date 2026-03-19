import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/services/admob_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Environment variables
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    print('Failed to load .env file: \$e');
  }

  // Initialize Localization
  await EasyLocalization.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization failed (probably missing configuration files): \$e');
  }

  // Initialize Services
  await StorageService().initialize();
  await AdMobService().initialize();
  
  try {
    await NotificationService().initialize();
  } catch (e) {
    print('Notification/FCM initialization failed: \$e');
  }

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ur'),
        Locale('fa'),
        Locale('ar'),
        Locale('bn'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}