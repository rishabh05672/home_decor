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

  List<ProductModel> _searchResults = [];
  List<ProductModel> get searchResults => _searchResults;

  List<String> _topSearches = [];
  List<String> get topSearches => _topSearches;

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
      debugPrint("API Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTopSearches() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.topSearches));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          _topSearches = List<String>.from(data['data']);
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Top Searches API Error: $e");
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    try {
      final response = await http.get(Uri.parse("${ApiUrl.search}?q=$query"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          _searchResults = (data['data'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Search API Error: $e");
    }
  }
}
