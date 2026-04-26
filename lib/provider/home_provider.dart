import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:decoze/services/api_url.dart';
import 'package:decoze/models/home_data_model.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HomeDataModel? _homeData;
  HomeDataModel? get homeData => _homeData;

  Future<void> fetchHomeData() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final response = await http.get(Uri.parse(ApiUrl.home));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          _homeData = HomeDataModel.fromJson(data['data']);
        }
      }
    } catch (e) {
      debugPrint("API Error or not deployed yet: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
