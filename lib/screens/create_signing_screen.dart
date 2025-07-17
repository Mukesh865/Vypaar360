import 'dart:ui';
import 'package:vypaar360/blocs/create_signing/create_signing_bloc.dart';
import 'package:vypaar360/blocs/create_signing/create_signing_event.dart';
import 'package:vypaar360/blocs/create_signing/create_signing_state.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dashboard_screen.dart';

class CreateSigningsScreen extends StatelessWidget {
  const CreateSigningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateSigningBloc(), // Provide the BLoC for Create Signing
      child: BlocBuilder<CreateSigningBloc, CreateSigningState>(
        builder: (context, state)
    {
      return WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
                (route) => false,
          );
          return false;
        },
        child: GlassyBackgroundScaffold(
          showBottomNav: true,
          currentIndex: 2,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final horizontalPadding = screenWidth > 600 ? 40.0 : 20.0;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      'Create Signings',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.065,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 35),

                    /// Service Details Section - Bloc events triggered on input change
                    _buildSection(
                      title: 'Service Details',
                      children: [
                        _buildGlassField(
                          labelText: 'Service Name',
                          onChanged: (value) =>
                              context.read<CreateSigningBloc>().add(
                                ServiceNameChanged(
                                    value), // Trigger service name change
                              ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildGlassField(
                                labelText: 'Signing Date',
                                onChanged: (value) =>
                                    context
                                        .read<CreateSigningBloc>()
                                        .add(SigningDateChanged(DateTime
                                        .now())), // Example: Passing current date
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildGlassField(
                                labelText: 'Select Time',
                                onChanged: (value) =>
                                    context
                                        .read<CreateSigningBloc>()
                                        .add(SelectTimeChanged(TimeOfDay
                                        .now())), // Example: Passing current time
                              ),
                            ),
                          ],
                        ),
                        _buildGlassField(
                          labelText: 'Amount',
                          onChanged: (value) =>
                              context.read<CreateSigningBloc>().add(
                                AmountChanged(value), // Trigger amount change
                              ),
                        ),
                      ],
                    ),

                    /// Company Details Section - Bloc event for signer
                    const SizedBox(height: 10),
                    _buildSection(
                      title: 'Company Details',
                      children: [
                        _buildGlassField(
                          labelText: 'Signer',
                          onChanged: (value) =>
                              context.read<CreateSigningBloc>().add(
                                SignerChanged(value), // Trigger signer change
                              ),
                        ),
                      ],
                    ),

                    /// Other Info Section - Bloc events for GST No and Property Address
                    const SizedBox(height: 10),
                    _buildSection(
                      title: 'Other Info',
                      children: [
                        _buildGlassField(
                          labelText: 'GST No.',
                          onChanged: (value) =>
                              context.read<CreateSigningBloc>().add(
                                GstNoChanged(value), // Trigger GST No change
                              ),
                        ),
                        _buildGlassField(
                          labelText: 'Property Address',
                          onChanged: (value) =>
                              context.read<CreateSigningBloc>().add(
                                PropertyAddressChanged(
                                    value), // Trigger property address change
                              ),
                        ),
                      ],
                    ),

                    /// Submit Button - Triggers form submission Bloc event
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.1),
                        ),
                        onPressed: () {
                          context.read<CreateSigningBloc>().add(
                            SubmitCreateSigning(), // Trigger form submit event
                          );
                        },
                        child: state.isSubmitting
                            ? const CircularProgressIndicator(
                          color: Colors.white, // Show loader while submitting
                        )
                            : Text(
                          'Submit',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
    ),
    );
  }

  /// Builds each form section with frosted glass effect styling
  Widget _buildSection({required String title, required List<Widget> children}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(159, 108, 133, 144).withOpacity(0.4),
                Colors.white.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              ...children.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: e,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds reusable frosted glass styled text field
  Widget _buildGlassField({
    required String labelText,
    required Function(String) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.30),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.fromLTRB(10, 7, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            cursorColor: Colors.white,
            style: GoogleFonts.poppins(color: Colors.white),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 2.5),
            ),
            onChanged: onChanged, // Notify Bloc on text change
          ),
        ],
      ),
    );
  }
}
