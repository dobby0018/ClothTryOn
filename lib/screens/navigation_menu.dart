import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import your custom screens and helpers
import './utils/helpers/helper_functions.dart';
import './utils/constants/colors.dart';
import './home/home_page.dart';
import 'tryon/screens/tryon_page.dart';
import 'profile/screens/profile_page.dart';
import 'screens/cart_page.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomePage(),
    const TryOnPage(),
    const CartPage(),
    const ProfilePage(),
  ];
}

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected:
              (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor:
              darkMode
                  ? TColors.white.withOpacity(0.1)
                  : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.camera), label: 'Try-On'),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: 'My Cart',
            ),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}
