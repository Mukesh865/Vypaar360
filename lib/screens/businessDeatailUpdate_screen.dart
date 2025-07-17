import 'package:vypaar360/blocs/update_business_details/businessDetailsUpdate_screen_bloc.dart';
import 'package:vypaar360/blocs/update_business_details/businessDetailsUpdate_screen_event.dart';
import 'package:vypaar360/blocs/update_business_details/businessDetailsUpdate_screen_state.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessDetailUpdateScreen extends StatelessWidget {
  final String? businessName;
  final String? contactNumber;
  final String? emailAddress;
  final String? gstNumber;
  final String? panNumber;
  final String? udhyamNumber;

  const BusinessDetailUpdateScreen({
    super.key,
    this.businessName,
    this.contactNumber,
    this.emailAddress,
    this.gstNumber,
    this.panNumber,
    this.udhyamNumber,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = (businessName == null || businessName!.isEmpty)
        ? "Hillborn Technologies"
        : businessName!;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => BusinessDetailsUpdateBloc()
        ..add(
          InitializeBusinessDetails(
            businessName: businessName ?? '',
            contactNumber: contactNumber ?? '',
            email: emailAddress ?? '',
            gstNo: gstNumber ?? '',
            panNo: panNumber ?? '',
            udhyamNo: udhyamNumber ?? '',
          ),
        ),
      child: BlocListener<BusinessDetailsUpdateBloc, BusinessDetailsUpdateState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pop(context); // Or navigate to success screen
          } else if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Update failed. Please try again.")),
            );
          }
        },
        child: GlassyBackgroundScaffold(
          showBottomNav: true,
          currentIndex: 0,
          child: BlocBuilder<BusinessDetailsUpdateBloc, BusinessDetailsUpdateState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.03,
                    ),
                    child: Text(
                      "Business Details",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.065,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.015),
                          _buildHeader(displayName, screenWidth, screenHeight),
                          SizedBox(height: screenHeight * 0.03),
                          _buildBusinessField(context, "Tax Code", state.taxCode, 'taxCode', screenWidth,screenHeight),
                          _buildBusinessField(context, "Business Address", state.address, 'address', screenWidth,screenHeight),
                          _buildBusinessField(context, "Business Email", state.email, 'email', screenWidth,screenHeight),
                          _buildBusinessField(context, "GST No.", state.gstNo, 'gstNo', screenWidth,screenHeight),
                          _buildBusinessField(context, "PAN No.", state.panNo, 'panNo', screenWidth,screenHeight),
                          SizedBox(height: screenHeight * 0.05),
                          Center(
                            child: SizedBox(
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
                                onPressed: state.isSubmitting
                                    ? null
                                    : () => context
                                    .read<BusinessDetailsUpdateBloc>()
                                    .add(SubmitBusinessDetails()),
                                child: state.isSubmitting
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text(
                                  'Update Details',
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String displayName, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth * 0.13,
            height: screenWidth * 0.13,
            child: const ImageIcon(
              AssetImage('assets/images/building_image.png'),
              size: 40,
              color: Colors.white,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Business Name",
                  style: GoogleFonts.poppins(
                    color: Colors.white54,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  displayName,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.037,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.edit_rounded,
              color: Colors.white,
              size: screenWidth * 0.07,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessField(
      BuildContext context,
      String label,
      String value,
      String fieldName,
      double screenWidth,
      double screenHeight,
      ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.01),
      padding: EdgeInsets.symmetric(vertical:screenHeight * 0.01, horizontal: screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.02),
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.white54,
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: value,
                  onChanged: (value) => context.read<BusinessDetailsUpdateBloc>().add(
                    BusinessFieldChanged(field: fieldName, value: value),
                  ),
                  style: GoogleFonts.poppins(color: Colors.white),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.01),
                child: Icon(Icons.edit_rounded, color: Colors.white, size: screenWidth * 0.06),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
