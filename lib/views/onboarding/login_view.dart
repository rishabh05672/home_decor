import 'package:decoze/provider/auth_provider.dart';
import 'package:decoze/services/api_status.dart';
import 'package:decoze/utils/app_color.dart';
import 'package:decoze/utils/app_text_style.dart';
import 'package:decoze/utils/app_routes_name.dart';
import 'package:decoze/utils/common_button.dart';
import 'package:decoze/utils/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isCheckbox = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      if (_isFormValid != false) {
        setState(() {
          _isFormValid = false;
        });
      }
    } else {
      if (_isFormValid != true) {
        setState(() {
          _isFormValid = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // UI layout ko bilkul change nahi kiya gaya hai
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.085),
            InkWell(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(AppRoutesName.createAccount);
                }
              },
              child: Image.asset(
                "assets/images/back_arrow.png",
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 52),
            Center(
              child: Text(
                "Login to decoze",
                textAlign: TextAlign.center,
                style: AppTextStyle.getTextStyle(
                  color: AppColor.whitePure,
                  fontWeight: AppFontWeight.bold,
                  fontSize: AppFontSize.heading32,
                ),
              ),
            ),
            const SizedBox(height: 45),
            commonTextField(
              fieldType: InputFieldType.email,
              hint: "Email",
              prefixIcon: Icons.email_outlined,
              controller: emailController,
              onChanged: (value) => _validateForm(),
            ),
            const SizedBox(height: 26),
            commonTextField(
              fieldType: InputFieldType.password,
              hint: "Password",
              prefixIcon: Icons.lock_open_outlined,
              controller: passwordController,
              suffixIcon: Icons.password_sharp,
              onChanged: (value) => _validateForm(),
            ),
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  activeColor: AppColor.primary500,
                  value: isCheckbox,
                  onChanged: (value) {
                    setState(() {
                      isCheckbox = value ?? false;
                    });
                  },
                ),
                Text(
                  "Remember me",
                  style: AppTextStyle.getTextStyle(
                    color: AppColor.textSecondary300,
                    fontSize: AppFontSize.medium,
                    fontWeight: AppFontWeight.medium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),

            // API Logic Integration
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return commonButton(
                  fontSize: AppFontSize.extraLarge,
                  fontWeight: AppFontWeight.semiBold,
                  label: "Sign In",
                  // Loading state handle ho rahi hai
                  isLoading: authProvider.status == ApiStatus.loading,
                  onTap: authProvider.status == ApiStatus.loading
                      ? () {}
                      : () {
                          if (emailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter email'),
                              ),
                            );
                          } else if (passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter password'),
                              ),
                            );
                          } else {
                            // API data prepare ho raha hai
                            Map<String, dynamic> data = {
                              'email': emailController.text.trim(),
                              'password': passwordController.text.trim(),
                            };
                            // ViewModel ki API call
                            authProvider.login(data, context);
                          }
                        },
                  backgroundColor: _isFormValid
                      ? AppColor.primary500
                      : AppColor.primary50,
                  foregroundColor: AppColor.textSecondary500,
                );
              },
            ),

            SizedBox(height: screenHeight * 0.12),
            Center(
              child: Text(
                "Or continue with",
                style: AppTextStyle.getTextStyle(color: const Color(0xff999999), fontSize: AppFontSize.small),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialLogin(
                  onTap: () {},
                  image: "assets/images/facebook.png",
                  height: 24,
                  width: 23.92,
                ),
                const SizedBox(width: 24),
                _buildSocialLogin(
                  onTap: () {},
                  image: "assets/images/google.png",
                  height: 24,
                  width: 23.49,
                ),
                const SizedBox(width: 24),
                _buildSocialLogin(
                  onTap: () {},
                  image: "assets/images/apple_logo.png",
                  height: 24,
                  width: 20.05,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: AppTextStyle.getTextStyle(
                    fontSize: AppFontSize.medium,
                    color: AppColor.textSecondary100,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.go(AppRoutesName.createAccount);
                  },
                  child: Text(
                    "Sign up",
                    style: AppTextStyle.getTextStyle(
                      fontSize: AppFontSize.medium,
                      color: AppColor.primary500,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLogin({
    required String image,
    required double height,
    required double width,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.textSecondary400, width: 1),
        ),
        child: Image.asset(
          image,
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
