import 'package:flutter/material.dart';
import 'auth_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AuthPage()));
    });

    return Scaffold(
      body: Center(
        child: Text('Virtual Try-On', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
