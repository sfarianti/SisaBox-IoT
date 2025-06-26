import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../home_page.dart';
import '../leaderboard.dart';
import '../edukasi.dart';
import '../scan.dart';
import '../profile.dart';

class AppPages {
  static final routes = <String, WidgetBuilder>{
    AppRoutes.home: (context) => HomePage(),
    AppRoutes.leaderboard: (context) => LeaderboardPage(),
    AppRoutes.edukasi: (context) => const EdukasiPage(),
    AppRoutes.scan: (context) => const ScanPage(),
    AppRoutes.profile: (context) => const ProfilePage(),
  };
}
