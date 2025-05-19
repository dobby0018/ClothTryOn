// main.dart
import 'package:flutter/material.dart';
import './screens/utils/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/api_service.dart';
import 'screens/login_screen.dart';
import 'screens/user_home.dart';
import 'screens/admin_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/navigation_menu.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final userType = prefs.getString('user_type');
  runApp(MyApp(token: token, userType: userType));
}

class MyApp extends StatelessWidget {
  final String? token;
  final String? userType;

  const MyApp({super.key, this.token, this.userType});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: token == null
          ? const LoginScreen()
          : userType == 'admin'
              ? const AdminScreen()
              : const NavigationMenu(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/user': (context) => const UserHomeScreen(),
        '/admin': (context) => const AdminScreen(),
        '/signup': (context) => const SignupScreen(),
        '/nav': (context) => const NavigationMenu(),
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import './screens/utils/themes/theme.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'services/api_service.dart';
// import 'screens/login_screen.dart';
// import 'screens/signup_screen.dart';
// import 'screens/admin_screen.dart';
// import 'screens/user_home.dart';          // you can keep this if you need a direct user route
// import 'screens/navigation_menu.dart';    // <-- import your new menu

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('token');
//   final userType = prefs.getString('user_type');
//   runApp(MyApp(token: token, userType: userType));
// }

// class MyApp extends StatelessWidget {
//   final String? token;
//   final String? userType;

//   const MyApp({super.key, this.token, this.userType});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fashion App',
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       theme: TAppTheme.lightTheme,
//       darkTheme: TAppTheme.darkTheme,
//       // decide initialRoute instead of home:
//       initialRoute: token == null
//           ? '/login'
//           : (userType == 'admin' ? '/admin' : '/nav'),
//       routes: {
//         '/login': (ctx) => const LoginScreen(),
//         '/signup': (ctx) => const SignupScreen(),
//         '/admin': (ctx) => const AdminScreen(),
//         '/user': (ctx) => const UserHomeScreen(),     // optional fallback
//         '/nav': (ctx) => const NavigationMenu(),      // your bottom‐nav entry point
//       },
//     );
//   }
// }
