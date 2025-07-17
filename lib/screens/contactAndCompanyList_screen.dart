import 'package:vypaar360/blocs/contact_company_list/contactAndCompany_bloc.dart';
import 'package:vypaar360/blocs/contact_company_list/contactAndCompany_event.dart';
import 'package:vypaar360/blocs/contact_company_list/contactAndCompany_state.dart';
import 'package:vypaar360/screens/profile_screen.dart';
import 'package:vypaar360/widgets/contact&company_field_widget.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/froested_search_bar_widget.dart';

class ContactAndCompanyList extends StatefulWidget {
  const ContactAndCompanyList({super.key});

  @override
  State<ContactAndCompanyList> createState() => _ContactAndCompanyListState();
}

class _ContactAndCompanyListState extends State<ContactAndCompanyList> {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => ContactCompanyBloc(),
      child: GlassyBackgroundScaffold(
        showBottomNav: true,
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
              (route) => false,
            );
            return false;
          },
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                  top: screenHeight * 0.03,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CRM Records",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.065,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),

                    /// Tabs & Search
                    BlocBuilder<ContactCompanyBloc, ContactCompanyState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Tabs Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _TabButton(
                                  title: 'Contact',
                                  selected: state.isContactSelected,
                                  onTap:
                                      () => context
                                          .read<ContactCompanyBloc>()
                                          .add(ToggleToContact()),
                                  screenWidth: screenWidth,
                                ),
                                SizedBox(width: screenWidth * 0.05),
                                _TabButton(
                                  title: 'Company',
                                  selected: !state.isContactSelected,
                                  onTap:
                                      () => context
                                          .read<ContactCompanyBloc>()
                                          .add(ToggleToCompany()),
                                  screenWidth: screenWidth,
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.04),

                            /// Search Bar
                            FrostedSearchBar(
                              controller: _searchController,
                              hintText: "Search ..",
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    /// Contact Cards
                    const ContactCard(
                      name: 'Diaz',
                      role: 'Signer',
                      paidAmount: '400',
                      dueAmount: '0',
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    const ContactCard(
                      name: 'Bruce',
                      role: 'Customer',
                      paidAmount: '800',
                      dueAmount: '0',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  final double screenWidth;

  const _TabButton({
    required this.title,
    required this.selected,
    required this.onTap,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenWidth * 0.025,
        ),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: selected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.w500,
            fontSize: screenWidth * 0.04,
          ),
        ),
      ),
    );
  }
}
