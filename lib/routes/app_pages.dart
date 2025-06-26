import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../home_page.dart';
import '../leaderboard.dart';
import '../edukasi.dart';

class AppPages {
  static final routes = <String, WidgetBuilder>{
    AppRoutes.home: (context) => HomePage(),
    AppRoutes.leaderboard: (context) => LeaderboardPage(),
    AppRoutes.edukasi: (context) => const EdukasiPage(),
  };
}
