import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/presentation/pages/splash_screen.dart';
import '../features/auth/presentation/pages/onboarding_screen.dart';
import '../features/auth/presentation/pages/login_screen.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../features/animal_details/presentation/pages/animal_details_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String animalDetails = '/animal-details';
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: Routes.onboarding, builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: Routes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: Routes.home, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '${Routes.animalDetails}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return AnimalDetailsScreen(animalId: id);
        },
      ),
    ],
    initialLocation: Routes.splash,
    errorBuilder: (context, state) => Scaffold(body: Center(child: Text('Page not found: ${state.uri.path}'))),
  );
});
