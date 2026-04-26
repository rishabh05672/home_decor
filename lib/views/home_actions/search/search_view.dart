import 'dart:async';
import 'package:decoze/provider/home_provider.dart';
import 'package:decoze/utils/app_color.dart';
import 'package:decoze/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().fetchTopSearches();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<HomeProvider>().searchProducts(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 17),
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: AppColor.whitePure,
                      ),
                    ),
                  ),
                  Text(
                    "Search",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.getTextStyle(
                      fontSize: AppFontSize.heading20,
                      color: AppColor.whitePure,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              _buildTextField(),
              const SizedBox(height: 32),
              Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  if (_searchController.text.isNotEmpty) {
                    // Search Results
                    if (provider.searchResults.isEmpty) {
                      return Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(color: AppColor.textSecondary300),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.searchResults.length,
                      itemBuilder: (context, index) {
                        final product = provider.searchResults[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              product.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            product.title,
                            style: const TextStyle(color: AppColor.whitePure),
                          ),
                          subtitle: Text(
                            "\$${product.price}",
                            style: const TextStyle(color: AppColor.primary500),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: AppColor.textSecondary300,
                          ),
                        );
                      },
                    );
                  } else {
                    // Top Searches
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Top Searches",
                          style: AppTextStyle.getTextStyle(
                            color: AppColor.whitePure,
                            fontSize: AppFontSize.large,
                            fontWeight: AppFontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: provider.topSearches.map((search) {
                            return GestureDetector(
                              onTap: () {
                                _searchController.text = search;
                                provider.searchProducts(search);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.textSecondary400,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  search,
                                  style: AppTextStyle.getTextStyle(
                                    color: AppColor.textSecondary100,
                                    fontSize: AppFontSize.medium,
                                    fontWeight: AppFontWeight.medium,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColor.textSecondary400,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.only(left: 24, right: 8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              cursorColor: AppColor.textSecondary50,
              style: AppTextStyle.getTextStyle(
                color: AppColor.whitePure,
                fontSize: AppFontSize.medium,
                fontWeight: AppFontWeight.medium,
              ),
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: AppTextStyle.getTextStyle(
                  color: AppColor.textSecondary200,
                  fontSize: AppFontSize.medium,
                  fontWeight: AppFontWeight.medium,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: AppColor.primary500,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.tune, color: AppColor.textSecondary500, size: 20),
          ),
        ],
      ),
    );
  }
}
