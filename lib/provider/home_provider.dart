import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:decoze/services/api_url.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List _bannerImages = [];
  List get bannerImages => _bannerImages;

  List<Map<String, dynamic>> _sectionImages = [];

  List<Map<String, dynamic>> get sectionImages => _sectionImages;

  List<Map<String, dynamic>> _topSelling = [];

  List<Map<String, dynamic>> get topSelling => _topSelling;

  List<Map<String, dynamic>> _collection = [];

  List<Map<String, dynamic>> get collection => _collection;

  List<Map<String, dynamic>> _outdoorCollection = [];

  List<Map<String, dynamic>> get outddorCollection => _outdoorCollection;

  Future<void> fetchHomeData() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final response = await http.get(Uri.parse(ApiUrl.home));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final resData = data['data'];
          _bannerImages = List.from(resData['bannerImages'] ?? _bannerImages);
          _sectionImages = List<Map<String, dynamic>>.from(resData['sectionImages'] ?? _sectionImages);
          _topSelling = List<Map<String, dynamic>>.from(resData['topSelling'] ?? _topSelling);
          _collection = List<Map<String, dynamic>>.from(resData['collection'] ?? _collection);
          _outdoorCollection = List<Map<String, dynamic>>.from(resData['outdoorCollection'] ?? _outdoorCollection);
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
