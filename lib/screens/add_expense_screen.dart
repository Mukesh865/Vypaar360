import 'package:vypaar360/blocs/add_expense/add_expense_bloc.dart';
import 'package:vypaar360/blocs/add_expense/add_expense_event.dart';
import 'package:vypaar360/blocs/add_expense/add_expense_state.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SigningScreen extends StatelessWidget {
  const SigningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => SigningBloc(),
      child: GlassyBackgroundScaffold(
        showBottomNav: true,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.025,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Expenses",
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
                    child: Text(
                      'Auto Scan and Add using Receipts',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.040,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                BlocBuilder<SigningBloc, SigningState>(
                  builder: (context, state) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          context.read<SigningBloc>().add(UploadTapped());
                        },
                        child: Container(
                          height: screenHeight * 0.28,
                          width: screenWidth * 0.88,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF2F2F2F),
                                Color(0xFF5C6B75),
                                Color(0xFFCBD4DB),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: state.isUploading
                              ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.20,
                                height: screenWidth * 0.20,
                                child: const ImageIcon(
                                  AssetImage('assets/images/upload_image.png',),color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              Text(
                                'Click to upload',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                'SVG, PNG, JPG or GIF (max.800x400px)',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.032,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
