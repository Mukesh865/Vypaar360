import 'dart:async';
import 'package:vypaar360/blocs/login/login_bloc.dart';
import 'package:vypaar360/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:vypaar360/screens/signup_screen.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    ///Delayed Navigation after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (_) => const SignupScreen()),
        // );

        Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create: (_) => LoginBloc(),
                        child: GlassyLoginScreen(),
                      ),
                ),
              );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    ///Logo width responsive to screen size
    double logoWidth = screenWidth * 0.4;
    logoWidth = logoWidth.clamp(120, 300); // Limit between 120 - 300 px

    return GlassyBackgroundScaffold(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: isLandscape ? 20 : 0),
          child: Opacity(
            opacity: 0.99,
            child: Image.asset(
              'assets/images/logo.png',
              width: logoWidth,
            ),
          ),
        ),
      ),
    );
  }
}
