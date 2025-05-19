import 'package:flutter/material.dart';
import 'login/login_page.dart';
import 'signup/signup_page.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
          bottom: TabBar(tabs: [Tab(text: 'Login'), Tab(text: 'Signup')]),
        ),
        body: TabBarView(children: [LoginPage(), SignupPage()]),
      ),
    );
  }
}
