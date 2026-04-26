import 'dart:async';
import 'package:decoze/utils/app_color.dart';
import 'package:decoze/utils/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        if (isLoggedIn) {
          context.goNamed(AppRoutesName.bottomNavigation);
        } else {
          context.goNamed(AppRoutesName.welcome);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/loco_icon.png",
              width: 42,
              height: 46,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 6),
            Text(
              "decoze",
              style: TextStyle(
                color: AppColor.primary500,
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
