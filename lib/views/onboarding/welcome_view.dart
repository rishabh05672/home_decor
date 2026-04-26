import 'package:decoze/utils/app_color.dart';
import 'package:decoze/utils/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              "assets/images/loco_icon.png",
              height: 46,
              width: 42,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 24),
            Text(
              "Welcome to",
              style: TextStyle(
                color: AppColor.whitePure,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "decoze",
              style: TextStyle(
                color: AppColor.primary500,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.height * 0.07),
            Text(
              textAlign: TextAlign.center,
              " Style your spaces & shop for all \nyour decor needs",
              style: TextStyle(
                color: AppColor.whitePure,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            SizedBox(
              width: context.width * 0.88,
              height: context.height * 0.06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary500,
                ),
                onPressed: () {
                  context.pushReplacement(AppRoutesName.onboarding);
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    color: AppColor.textSecondary500,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.height * 0.064),
          ],
        ),
      ),
    );
  }
}
