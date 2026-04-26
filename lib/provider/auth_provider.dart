import 'package:decoze/services/api_status.dart';
import 'package:flutter/material.dart';
import 'package:decoze/services/api_helper.dart'; //
import 'package:decoze/services/api_url.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:decoze/utils/app_routes_name.dart';

class AuthProvider with ChangeNotifier {
  final _apiHelper = ApiHelper(); //

  // 1. Status track karne ke liye variable
  ApiStatus _status = ApiStatus.success; //
  ApiStatus get status => _status;

  // Status badalne ka function
  void setStatus(ApiStatus value) {
    _status = value;
    notifyListeners();
  }

  // 2. Login Function
  Future<void> login(Map<String, dynamic> data, BuildContext context) async {
    // Loading shuru karo
    setStatus(ApiStatus.loading); //

    try {
      // ApiHelper ka use karke call karo
      await _apiHelper.postApi(ApiUrl.login, data); //

      // Success logic
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      
      setStatus(ApiStatus.success); //

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login Successful!')));
        context.pushReplacement(AppRoutesName.bottomNavigation);
      }
    } catch (e) {
      // Error logic
      setStatus(ApiStatus.error); //

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  Future<void> signUp(Map<String, dynamic> data, BuildContext context) async {
    setStatus(ApiStatus.loading);

    try {
      // ApiUrl.signUp use karenge (jo aapki api_url.dart file mein hai)
      await _apiHelper.postApi(ApiUrl.signUp, data);

      setStatus(ApiStatus.success);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Created Successfully!')),
        );
        // Account banne ke baad login screen par bhej dein
        context.pop();
      }
    } catch (e) {
      setStatus(ApiStatus.error);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup Failed: ${e.toString()}')),
        );
      }
    }
  }
}
