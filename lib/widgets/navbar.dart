import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class NavbarBottom extends StatelessWidget {
  final int currentIndex;

  const NavbarBottom({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return; 
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.edukasi, (route) => false);
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.scan, (route) => false);
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.leaderboard, (route) => false);
        break;
      case 4:
         Navigator.pushNamedAndRemoveUntil(context, AppRoutes.profile, (route) => false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Edukasi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.document_scanner), 
          label: 'Scan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_esports),
          label: 'Games',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
