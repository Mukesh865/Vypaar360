import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart'; // Adjust the import path based on your project

class GlassyBackgroundScaffold extends StatelessWidget {
  final Widget child;
  final bool showBottomNav;
  final int currentIndex;
  final ValueChanged<int>? onNavTap;

  const GlassyBackgroundScaffold({
    super.key,
    required this.child,
    this.showBottomNav = false,
    this.currentIndex = 0,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 1. Dark Gradient Background
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.70, 1.0],
                  colors: [
                    Color(0xFF1A1A1A),
                    Color(0xFF1A1A1A),
                    Color(0xFF11262C),
                  ],
                ),
              ),
            ),
          ),

          // 2. Shine effect behind content (doesn't move on scroll)
          Positioned(
            top: -screenHeight * 0.2,
            right: -screenWidth * 0.3,
            child: IgnorePointer(
              child: Container(
                width: screenWidth * 1.2,
                height: screenHeight * 1.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.7),
                      Colors.transparent,
                    ],
                    radius: 0.8,
                    center: Alignment.center,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),

          // 3. Scrollable page content
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: (showBottomNav ? 70.0 : 0.0) + viewInsets, // Space for nav bar
              ),
              child: SafeArea(
                child: child,
              ),
            ),
          ),

          // 4. Fixed Bottom Navigation Bar
          if (showBottomNav)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomNavBar(
                currentIndex: currentIndex,
              ),
            ),
        ],
      ),
    );
  }
}
