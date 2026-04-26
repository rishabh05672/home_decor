// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:carousel_slider/carousel_slider.dart';
import 'package:decoze/provider/home_provider.dart';
import 'package:decoze/utils/app_color.dart';
import 'package:decoze/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentBannerIndex = 0;
  int _selectedSectionIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/loco_icon.png",
                    width: 27,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "decoze",
                    style: TextStyle(
                      color: AppColor.primary500,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  _buildTopIcon(image: "search.png", onTap: () {}),
                  const SizedBox(width: 10),
                  _buildTopIcon(image: "heart.png", onTap: () {}),
                ],
              ),
            ),
            Expanded(
              child: Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading || provider.bannerImages.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CarouselSlider(
                              items: provider.bannerImages.map((image) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    image,
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: 200,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.85,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentBannerIndex = index;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Dotted Indicators
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: provider.bannerImages
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                    return AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      width: _currentBannerIndex == entry.key
                                          ? 22.0
                                          : 6.0,
                                      height: 4.0,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: _currentBannerIndex == entry.key
                                            ? AppColor.primary500
                                            : Colors.grey.withValues(
                                                alpha: 0.3,
                                              ),
                                      ),
                                    );
                                  })
                                  .toList(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // --- Categories Section ---
                        Consumer<HomeProvider>(
                      builder: (context, provider, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              provider.sectionImages.length,
                              (index) {
                                final section = provider.sectionImages[index];
                                return _buildSectionTitle(
                                  image: section["image"]!,
                                  title: section["title"]!,
                                  isSelected: _selectedSectionIndex == index,
                                  height: 40,
                                  width: 40,
                                  onTap: () {
                                    setState(() {
                                      _selectedSectionIndex = index;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        "Top Selling",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColor.whitePure,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    _buildTopSellingCard(),
                    SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Collection",
                        style: TextStyle(
                          color: AppColor.whitePure,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Consumer<HomeProvider>(
                      builder: (context, provider, child) {
                        final collection = provider.collection;
                        if (collection.isEmpty) return const SizedBox.shrink();
                        
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              // Top Banner (collection[0])
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.asset(
                                      collection[0]["image"],
                                      width: 382,
                                      height: 164,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 9,
                                    left: 13,
                                    child: Text(
                                      collection[0]["title"],
                                      style: AppTextStyle.getTextStyle(
                                        color: AppColor.whitePure,
                                        fontSize: AppFontSize.medium,
                                        fontWeight: AppFontWeight.medium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Bottom Grid
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.asset(
                                          collection[1]["image"],
                                          width: 194,
                                          height: 224,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 9,
                                        left: 13,
                                        child: Text(
                                          collection[1]["title"],
                                          style: AppTextStyle.getTextStyle(
                                            color: AppColor.whitePure,
                                            fontSize: AppFontSize.small,
                                            fontWeight: AppFontWeight.medium,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.asset(
                                                collection[2]["image"],
                                                width: double.infinity,
                                                height: 106,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 9,
                                              left: 13,
                                              child: Text(
                                                collection[2]["title"],
                                                style:
                                                    AppTextStyle.getTextStyle(
                                                      color: AppColor.whitePure,
                                                      fontSize:
                                                          AppFontSize.small,
                                                      fontWeight:
                                                          AppFontWeight.medium,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.asset(
                                                collection[3]["image"],
                                                width: double.infinity,
                                                height: 106,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 9,
                                              left: 13,
                                              child: Text(
                                                collection[3]["title"],
                                                style:
                                                    AppTextStyle.getTextStyle(
                                                      color: AppColor.whitePure,
                                                      fontSize:
                                                          AppFontSize.small,
                                                      fontWeight:
                                                          AppFontWeight.medium,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 52),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        "Outdoor Collection",
                        style: AppTextStyle.getTextStyle(
                          color: AppColor.whitePure,
                          fontSize: AppFontSize.large,
                          fontWeight: AppFontWeight.medium,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    _outdoorCollection(),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
      ),
    );
  }

  Widget _buildTopIcon({required String image, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        "assets/images/$image",
        height: 24,
        width: 24,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildSectionTitle({
    required String image,
    required VoidCallback onTap,
    required String title,
    required bool isSelected,
    required double height,
    required double width,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.textSecondary600 : Colors.transparent,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              height: height,
              width: width,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                color: isSelected
                    ? AppColor.primary50
                    : AppColor.textSecondary200,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSellingCard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return Row(
            children: List.generate(provider.topSelling.length, (index) {
              final item = provider.topSelling[index];
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.textSecondary600,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        item["image"],
                        width: 122,
                        height: 144,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item["choice"],
                      style: TextStyle(
                        color: AppColor.textSecondary200,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item["title"],
                      style: TextStyle(
                        color: AppColor.primary500,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "\$ ${item["price"]}",
                      style: TextStyle(
                        color: AppColor.textSecondary50,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, size: 12, color: AppColor.warning),
                        SizedBox(width: 3),
                        Text(
                          item["rating"],
                          style: TextStyle(
                            color: AppColor.textSecondary200,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _outdoorCollection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return Row(
            children: List.generate(provider.outddorCollection.length, (index) {
              final item = provider.outddorCollection[index];
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.textSecondary600,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        item["image"],
                        width: 122,
                        height: 144,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item["choice"],
                      style: TextStyle(
                        color: AppColor.textSecondary200,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item["title"],
                      style: TextStyle(
                        color: AppColor.primary500,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "\$ ${item["price"]}",
                      style: TextStyle(
                        color: AppColor.textSecondary50,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, size: 12, color: AppColor.warning),
                        SizedBox(width: 3),
                        Text(
                          item["rating"],
                          style: TextStyle(
                            color: AppColor.textSecondary200,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
