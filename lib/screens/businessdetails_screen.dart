import 'package:vypaar360/blocs/add_business_details/business_details_bloc.dart';
import 'package:vypaar360/blocs/add_business_details/business_details_event.dart';
import 'package:vypaar360/blocs/add_business_details/business_details_state.dart';
import 'package:vypaar360/screens/OTP_Screen.dart';
import 'package:vypaar360/screens/dashboard_screen.dart';
import 'package:vypaar360/widgets/frosted_glass_text_field.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessDetailsScreen extends StatefulWidget {
  const BusinessDetailsScreen({super.key});

  @override
  State<BusinessDetailsScreen> createState() => _BusinessDetailsFormState();
}

class _BusinessDetailsFormState extends State<BusinessDetailsScreen> {
  late TextEditingController businessNameController;
  late TextEditingController contactNumberController;
  late TextEditingController emailAddressController;
  late TextEditingController gstNumberController;
  late TextEditingController panNumberController;
  late TextEditingController udhyamNumberController;

  @override
void initState() {
  super.initState();
  // Initialize with empty text
  businessNameController = TextEditingController();
  contactNumberController = TextEditingController();
  emailAddressController = TextEditingController();
  gstNumberController = TextEditingController();
  panNumberController = TextEditingController();
  udhyamNumberController = TextEditingController();

  // Update with bloc state after build
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final bloc = context.read<BusinessDetailsBloc>();
    businessNameController.text = bloc.state.businessName;
    contactNumberController.text = bloc.state.contactNumber;
    emailAddressController.text = bloc.state.emailAddress;
    gstNumberController.text = bloc.state.gstNumber;
    panNumberController.text = bloc.state.panNumber;
    udhyamNumberController.text = bloc.state.udhyamNumber;
  });
}


  @override
  void dispose() {
    businessNameController.dispose();
    contactNumberController.dispose();
    emailAddressController.dispose();
    gstNumberController.dispose();
    panNumberController.dispose();
    udhyamNumberController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(email);
  }

  bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r"^[6-9]\d{9}$");
    return phoneRegex.hasMatch(phone);
  }

  void _handleSubmit(BuildContext context) {
    final bloc = context.read<BusinessDetailsBloc>();
    final name = businessNameController.text.trim();
    final contact = contactNumberController.text.trim();
    final email = emailAddressController.text.trim();

    if (name.isEmpty || contact.isEmpty || email.isEmpty) {
      _showError("Please fill all required fields.");
    } else if (!isValidPhone(contact)) {
      _showError("Please enter a valid 10-digit contact number.");
    } else if (!isValidEmail(email)) {
      _showError("Please enter a valid email address.");
    } else {
      bloc.add(SubmitForm());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen()),
        );
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BusinessDetailsBloc>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GlassyBackgroundScaffold(
      child: BlocBuilder<BusinessDetailsBloc, BusinessDetailsState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.18,
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      'Business Details',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.015,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FrostedGlassTextField(
                        hintText: 'Business Name',
                        controller: businessNameController,
                        onChanged: (val) => bloc.add(UpdateBusinessName(val)),
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      FrostedGlassTextField(
                        hintText: 'Contact Number',
                        controller: contactNumberController,
                        keyboardType: TextInputType.phone,
                        onChanged: (val) => bloc.add(UpdateContactNumber(val)),
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      FrostedGlassTextField(
                        hintText: 'Email Address',
                        controller: emailAddressController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) => bloc.add(UpdateEmailAddress(val)),
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      SizedBox(
                        width: screenWidth * 0.75,
                        child: FrostedGlassTextField(
                          hintText: 'GST Number',
                          controller: gstNumberController,
                          onChanged: (val) => bloc.add(UpdateGstNumber(val)),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      SizedBox(
                        width: screenWidth * 0.75,
                        child: FrostedGlassTextField(
                          hintText: 'PAN Number - xxxxxxxxxxx',
                          controller: panNumberController,
                          onChanged: (val) => bloc.add(UpdatePanNumber(val)),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        'Optional',
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      FrostedGlassTextField(
                        hintText: 'Udhyam Number',
                        controller: udhyamNumberController,
                        onChanged: (val) => bloc.add(UpdateUdhyamNumber(val)),
                      ),
                      SizedBox(height: screenHeight * 0.04),

                      SizedBox(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            elevation: 3,
                          ),
                          onPressed:
                              state.isSubmitting
                                  ? null
                                  : () => _handleSubmit(context),
                          child:
                              state.isSubmitting
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    'Save Details',
                                    style: GoogleFonts.poppins(
                                      fontSize: screenWidth * 0.042,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.05),
                          child: TextButton(
                            onPressed: () {
                              // final bloc = context.read<BusinessDetailsBloc>();
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DashboardScreen(),
                                  ),
                                );
                              });
                            },
                            child: Text(
                              'Skip',
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: screenWidth * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
