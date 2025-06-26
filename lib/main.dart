import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes/app_routes.dart';
import '../home_page.dart';
import '../leaderboard.dart';
import '../edukasi.dart';
import '../scan.dart';
import '../profile.dart';
import '../login.dart';
import '../register.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SisaBox',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.leaderboard: (context) => const LeaderboardPage(),
        AppRoutes.edukasi: (context) => const EdukasiPage(),
        AppRoutes.scan: (context) => const ScanPage(),
        AppRoutes.profile: (context) => const ProfilePage(),
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.register: (context) => const RegisterPage(),
      },
    );
  }
}
