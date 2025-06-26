import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import '../home_page.dart';
import '../leaderboard.dart'; 
import '../edukasi.dart';
import '../scan.dart';
import '../profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SisaBox',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.leaderboard: (context) => const LeaderboardPage(),
        AppRoutes.edukasi: (context) => const EdukasiPage(),
        AppRoutes.scan: (context) => const ScanPage(),
        AppRoutes.profile: (context) => const ProfilePage(),
      },
    );
  }
}
