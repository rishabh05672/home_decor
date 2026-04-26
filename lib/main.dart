import 'package:decoze/provider/auth_provider.dart';
import 'package:decoze/provider/home_provider.dart';
import 'package:decoze/provider/onboarding_provider.dart';
import 'package:decoze/utils/app_color.dart';
import 'package:decoze/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Decoze',
        theme: ThemeData(
          primaryColor: AppColor.backgroundColor,
          scaffoldBackgroundColor: AppColor.backgroundColor,
        ),
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
