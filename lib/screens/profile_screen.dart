import 'dart:io';
import 'package:vypaar360/blocs/add_business_details/business_details_bloc.dart';
import 'package:vypaar360/blocs/add_business_details/business_details_event.dart';
import 'package:vypaar360/blocs/add_business_details/business_details_state.dart';
import 'package:vypaar360/screens/contactAndCompanyList_screen.dart';
import 'package:vypaar360/screens/expense_screen.dart';
import 'package:vypaar360/screens/loginScreen.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';
import 'package:vypaar360/widgets/under_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'businessDeatailUpdate_screen.dart';
import 'dashboard_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final imageFile = File(picked.path);
      context.read<BusinessDetailsBloc>().add(UpdateProfileImage(imageFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<BusinessDetailsBloc, BusinessDetailsState>(
      builder: (context, state) {
        const String fallbackName = "Walter White";
        const String fallbackBusiness = "Hillborn Technologies Pvt Ltd";

        final String businessName =
            state.businessName.isNotEmpty
                ? state.businessName
                : fallbackBusiness;

        return GlassyBackgroundScaffold(
          showBottomNav: true,
          currentIndex: 3,
          child: WillPopScope(
            onWillPop: () async {
              // Navigate back to Dashboard screen
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
                (route) => false,
              );
              return false;
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.015,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.010),
                    Center(
                      child: GestureDetector(
                        onTap: () => _pickImage(context),
                        child: CircleAvatar(
                          radius: screenWidth * 0.12,
                          backgroundColor: Colors.grey[800],
                          backgroundImage:
                              state.profileImage != null
                                  ? ResizeImage(
                                    FileImage(state.profileImage!),
                                    width: 300,
                                    height: 300,
                                  )
                                  : null,
                          child:
                              state.profileImage == null
                                  ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white70,
                                  )
                                  : null,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Center(
                      child: Text(
                        fallbackName,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Center(
                      child: Text(
                        businessName,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.035),
                    Expanded(
                      child: ListView(
                        children: [
                          _profileButton(context, "Contact & Company List", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        const ContactAndCompanyList(), //ContactAndCompanyList(),
                              ),
                            );
                          }),
                          _profileButton(context, "Business Details", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        const BusinessDetailUpdateScreen(), //BusinessDetailUpdateScreen(),
                              ),
                            );
                          }),
                          _profileButton(context, "Expenses", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        const ExpenseScreen(), //ExpenseScreen(),
                              ),
                            );
                          }),
                          _profileButton(context, "Personal Details", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const UnderProgressScreen(),
                              ),
                            );
                          }),
                          _profileButton(context, "Sign Out", () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const GlassyLoginScreen(),
                              ),
                              (route) => false,
                            );
                          }),
                          _profileButton(context, "Delete Account", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const UnderProgressScreen(),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _profileButton(
    BuildContext context,
    String label,
    VoidCallback onTap,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.006),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
          horizontal: screenWidth * 0.06,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
