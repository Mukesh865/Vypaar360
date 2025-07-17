import 'package:vypaar360/screens/create_signing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vypaar360/blocs/signings/signing_bloc.dart';
import 'package:vypaar360/blocs/signings/signing_event.dart';
import 'package:vypaar360/blocs/signings/signing_state.dart';
import 'package:vypaar360/widgets/frosted_glass_text_field.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vypaar360/widgets/froested_search_bar_widget.dart';

import 'dashboard_screen.dart';

class SigningsScreen extends StatefulWidget {
  const SigningsScreen({super.key});

  @override
  State<SigningsScreen> createState() => _SigningsScreenState();
}

class _SigningsScreenState extends State<SigningsScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double sidePadding = isLandscape ? 16.0 : 20.0;
    final double verticalSpacing = isLandscape ? 12.0 : 20.0;
    final double titleFontSize = isLandscape ? 20.0 : 24.0;
    final double buttonHeight = isLandscape ? 42.0 : 50.0;
    final double filterFontSize = isLandscape ? 12.0 : 14.0;

    return BlocProvider(
      create:
          (_) => SigningsBloc()..add(LoadSignings()), // Load initial signings
      child: WillPopScope(
        onWillPop: () async {
          // ✅ Always navigate to DashboardScreen
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  (route) => false,
          );
          return false; // prevent default pop
        },
        child: GlassyBackgroundScaffold(
          showBottomNav: true,
          currentIndex: 1,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: sidePadding,
                  vertical: verticalSpacing,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    // ✅ Prevent overflow on larger screens
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title + Create New Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Signings",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CreateSigningsScreen(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.035,
                                  vertical: screenHeight * 0.01,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: const BorderSide(color: Colors.white24),
                              ),
                              child: Text(
                                '+ Create new',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: verticalSpacing),

                        /// Status Filters (Open, Closed, Paydue)
                        BlocBuilder<SigningsBloc, SigningsState>(
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:
                                  ["open", "closed", "paydue"].map((status) {
                                    final isSelected =
                                        state.selectedStatus == status;
                                    return GestureDetector(
                                      onTap: () {
                                        // ✅ Filter signings by status
                                        context.read<SigningsBloc>().add(
                                          FilterSigningsByStatus(status),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              isSelected
                                                  ? Colors.black87
                                                  : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color:
                                                isSelected
                                                    ? Colors.white.withOpacity(
                                                      0.3,
                                                    )
                                                    : Colors.transparent,
                                          ),
                                        ),
                                        child: Text(
                                          status[0].toUpperCase() +
                                              status.substring(1),
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: filterFontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            );
                          },
                        ),

                        SizedBox(height: verticalSpacing),

                        /// Search TextField (Real-time filter by search term)
                        FrostedSearchBar(
                          controller: _searchController,
                          hintText: "Search Signings...",
                          onChanged: (value) {
                            context.read<SigningsBloc>().add(
                              SearchSignings(value),
                            );
                          },
                        ),

                        SizedBox(height: verticalSpacing),

                        /// Signings List or No Results
                        Center(
                          child: BlocBuilder<SigningsBloc, SigningsState>(
                            builder: (context, state) {
                              if (state.filteredSignings.isEmpty) {
                                return Center(
                                  child: Text(
                                    "No Signings Found",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white70,
                                    ),
                                  ),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.filteredSignings.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      state.filteredSignings[index],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
