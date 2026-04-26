import 'package:decoze/utils/app_color.dart';
import 'package:decoze/views/cart_payments/cart_view.dart';
import 'package:decoze/views/category_and%20_its_details/category_view.dart';
import 'package:decoze/views/home_actions/home_view.dart';
import 'package:decoze/views/profile_others/profile_view.dart';
import 'package:flutter/material.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const CategoryView(),
    const CartView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _pages),
      bottomNavigationBar: BottomAppBar(
        color: AppColor.textSecondary600,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(
              "Home",
              "home_logo.png",
              "home_selected_logo.png",
              0,
            ),
            _buildBottomNavItem(
              "Category",
              "category_logo.png",
              "category_selected.png",
              1,
            ),
            _buildBottomNavItem(
              "Cart",
              "bag_logo.png",
              "bag_selected_logo.png",
              2,
            ),
            _buildBottomNavItem(
              "Profile",
              "profile_logo.png",
              "user_selected_logo.png",
              3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
    String title,
    String inactiveImage,
    String activeImage,
    int index,
  ) {
    bool isSelected = currentIndex == index;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            scale: isSelected ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.bounceOut,
            child: Image.asset(
              "assets/images/${isSelected ? activeImage : inactiveImage}",
              height: 24,
              width: 24,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 4),

          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              color: isSelected
                  ? AppColor.primary500
                  : AppColor.textSecondary300,
            ),
            child: Text(title),
          ),

          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(top: 2),
            height: 2,
            width: isSelected ? 15 : 0,
            decoration: BoxDecoration(
              color: AppColor.primary500,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
