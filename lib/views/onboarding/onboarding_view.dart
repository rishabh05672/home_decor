import 'package:decoze/provider/onboarding_provider.dart';
import 'package:decoze/utils/app_color.dart';
import 'package:decoze/utils/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int currentIndex = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnboardingProvider>(
        builder: (context, provider, child) {
          return PageView.builder(
            controller: controller,
            itemCount: provider.onboardingScreens.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final onboard = provider.onboardingScreens[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: context.height * 0.12),
                  Image.asset(
                    onboard.image,
                    height: index == 2
                        ? context.height * 0.26
                        : context.height * 0.304,
                    width: index == 2
                        ? context.width * 0.89
                        : context.width * 0.68,
                    fit: BoxFit.contain,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      provider.onboardingScreens.length,
                      (index) => _buildDot(index),
                    ),
                  ),
                  Spacer(),
                  Text(
                    onboard.title,
                    style: TextStyle(
                      color: AppColor.whitePure,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    onboard.description,
                    style: TextStyle(
                      color: AppColor.textSecondary100,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
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
                        if (currentIndex <
                            provider.onboardingScreens.length - 1) {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          context.pushNamed(AppRoutesName.createAccount);
                        }
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: AppColor.textSecondary500,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: context.width * 0.88,
                    height: context.height * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.textSecondary600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(50),
                          side: BorderSide(color: AppColor.primary500),
                        ),
                      ),
                      onPressed: () {
                        context.pushNamed(AppRoutesName.createAccount);
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: AppColor.primary500,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.height * 0.064),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: currentIndex == index ? 24 : 8,
      decoration: BoxDecoration(
        color: currentIndex == index
            ? AppColor.primary500
            : AppColor.textSecondary400,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
