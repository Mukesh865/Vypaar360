import 'package:vypaar360/screens/create_signing_screen.dart';
import 'package:vypaar360/screens/profile_screen.dart';
import 'package:vypaar360/screens/signing_screen.dart';
import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({super.key, required this.currentIndex});

  void _handleNavigation(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget targetScreen;
    switch (index) {
      case 0:
        targetScreen = const DashboardScreen();
        break;
      case 1:
        targetScreen = const SigningsScreen();
        break;
      case 2:
        targetScreen = const CreateSigningsScreen();
        break;
      case 3:
        targetScreen = const ProfileScreen();

        break;
      default:
        return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => targetScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 400;

    final double iconSize = isSmallScreen ? 20 : 28;
    final double selectedIconSize = isSmallScreen ? 22 : 30;
    final double fontSize = isSmallScreen ? 10 : 12;
    final bool showLabels = screenWidth > 350;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _handleNavigation(context, index),
      backgroundColor: Colors.black.withOpacity(0.1),
      elevation: 0,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      iconSize: iconSize,
      selectedIconTheme: IconThemeData(size: selectedIconSize),
      unselectedIconTheme: IconThemeData(size: iconSize),
      selectedLabelStyle: TextStyle(fontSize: fontSize),
      unselectedLabelStyle: TextStyle(fontSize: fontSize - 2),
      showSelectedLabels: showLabels,
      showUnselectedLabels: false,
      useLegacyColorScheme: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Signing'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Create'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
