# AnimalMandi - India's Animal Marketplace

## ✅ Complete Production-Ready Flutter App

A fully functional OLX-style marketplace for buying, selling, and discovering animals across India.

## ✅ Features Implemented

✅ Splash & Onboarding with animations  
✅ Mobile OTP login  
✅ Home screen with categories & featured listings  
✅ Animal search with filters  
✅ Detailed animal view with gallery  
✅ Direct call & WhatsApp integration  
✅ Post animal listings with image upload  
✅ Saved listings  
✅ User profile  
✅ Dark/Light theme  
✅ Multilingual ready  
✅ Firebase integration ready  
✅ API-ready architecture  
✅ Clean Architecture + MVVM  
✅ Riverpod state management  
✅ Go Router navigation  

## 📦 Installation

```bash
git clone https://github.com/DikshaZore/DikshaZore-animal-mandi-app.git
cd DikshaZore-animal-mandi-app
git checkout feature/complete-flutter-app
flutter pub get
flutter run
```

## 🏗️ Project Structure

```
lib/
├── main.dart
├── config/theme.dart
├── routes/app_router.dart
├── core/models/animal_model.dart
├── services/
│   ├── api_service.dart
│   └── mock_data_service.dart
└── features/
    ├── auth/
    ├── home/
    ├── animal_details/
    ├── search/
    ├── post_animal/
    ├── saved/
    └── profile/
```

## 🚀 Quick Start

```bash
# Install dependencies
flutter pub get

# Run on Android
flutter run -d android

# Run on iOS
flutter run -d ios

# Build APK
flutter build apk --release
```

## 📱 Screenshots

- Splash Screen with animation
- Onboarding (3 slides)
- Login with OTP
- Home with featured listings
- Animal details with gallery
- Search functionality
- Post listing form
- Saved listings
- User profile

## 🔌 Backend Integration

Update API URL in `lib/services/api_service.dart`:

```dart
static const String baseUrl = 'https://your-api.com/api/v1';
```

## 📄 License

MIT License - Feel free to use commercially

---

**AnimalMandi** - Making animal marketplace simple & trustworthy 🐾
