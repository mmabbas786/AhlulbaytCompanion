# Ahlulbayt Companion — Project Context

## App
Free Shia Muslim companion app. 100% free, monetised with AdMob.
Built in Flutter for Android + iOS.

## Design system
- Primary: #0D7377 (teal)
- Accent: #C9A84C (gold)
- Background: #0A0F1E (dark navy)
- Themes: Light, Dark, AMOLED Black
- GlassCard: white 8% opacity, blur 20, border white 15%, radius 16
- Font English: Inter | Font Arabic: Scheherazade New | Font Urdu: Noto Nastaliq

## Tech Stack
Flutter 3.24+, Firebase backend, Claude API for AI chatbot,
AdMob for ads, Aladhan API for prayer times, easy_localization for i18n

## Rules for every screen
- Never show ads during Tasbih counting or Qibla compass
- Always use GlassCard from glass_components.dart for cards
- Always use go_router for navigation
- Always use Provider for state management
- Arabic text uses Scheherazade New font, right-aligned, RTL
- Save user preferences to shared_preferences

## Modules to build (in order)
1. Foundation: theme, nav, localization ← START HERE
2. Prayer times + Qibla + Tasbih
3. Islamic Calendar
4. Duas & Ziyarat
5. Hadith library
6. Quiz + streaks
7. Khums calculator
8. Claude AI chatbot
9. AdMob integration
