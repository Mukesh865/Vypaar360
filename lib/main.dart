import 'package:vypaar360/blocs/add_business_details/business_details_bloc.dart';
import 'package:vypaar360/blocs/contact_company_list/contactAndCompany_bloc.dart';
import 'package:vypaar360/blocs/expense/expense_screen_bloc.dart';
import 'package:vypaar360/blocs/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vypaar360/screens/splash_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BusinessDetailsBloc()),
        BlocProvider(create: (_) => ContactCompanyBloc()), // ADD THIS
        BlocProvider(create: (_) => ExpenseBloc()), // IF USED
        BlocProvider(create: (_) => LoginBloc()),
        // Add other blocs if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vyapaar360',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
