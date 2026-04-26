import 'package:decoze/utils/app_routes_name.dart';
import 'package:decoze/utils/bottom_navigaion.dart';
import 'package:decoze/views/home_actions/search/search_view.dart';
import 'package:decoze/views/onboarding/create_account_view.dart';
import 'package:decoze/views/onboarding/login_view.dart';
import 'package:decoze/views/onboarding/onboarding_view.dart';
import 'package:decoze/views/onboarding/splash_view.dart';
import 'package:decoze/views/onboarding/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: "initial",
        path: "/",
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        name: AppRoutesName.onboarding,
        path: AppRoutesName.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        name: AppRoutesName.createAccount,
        path: AppRoutesName.createAccount,
        builder: (context, state) => const CreateAccountView(),
      ),
      GoRoute(
        name: AppRoutesName.login,
        path: AppRoutesName.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        name: AppRoutesName.welcome,
        path: AppRoutesName.welcome,
        builder: (context, state) => const WelcomeView(),
      ),
      GoRoute(
        name: AppRoutesName.bottomNavigation,
        path: AppRoutesName.bottomNavigation,
        builder: (context, state) => const BottomNavigationView(),
      ),
      GoRoute(
        name: AppRoutesName.search,
        path: AppRoutesName.search,
        builder: (context, state) => const SearchView(),
      ),
    ],
  );
}
