import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../tryon/screens/tryon_page.dart';
import '../profile/screens/profile_page.dart';
import '../cart/cart_page.dart';
import 'hometab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomeTab(),
    const TryOnPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            selectedIndex < pages.length
                ? pages[selectedIndex]
                : Container(), // Safety check
      ),
    );
  }
}
