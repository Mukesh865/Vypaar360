import 'package:vypaar360/blocs/dashboard/dashboard_event.dart';
import 'package:vypaar360/blocs/dashboard/dashboard_state.dart';
import 'package:vypaar360/blocs/signings/signing_bloc.dart';
import 'package:vypaar360/blocs/signings/signing_event.dart';
import 'package:vypaar360/screens/add_expense_screen.dart';
import 'package:vypaar360/screens/contactAndCompanyList_screen.dart';
import 'package:vypaar360/screens/profile_screen.dart';
import 'package:vypaar360/screens/signing_screen.dart';
import 'package:vypaar360/widgets/frosted_glass_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../blocs/dashboard/dashboard_bloc.dart';
import '../../widgets/glassy_background_scaffold.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    return BlocProvider(
      create:
          (_) =>
              DashboardBloc()
                ..add(LoadDashboardData()), // Load initial dashboard data
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final isMobile = screenWidth < 600;

          return GlassyBackgroundScaffold(
            showBottomNav: true,
            currentIndex: 0,
            onNavTap: (value) {
              // TODO: Handle bottom navigation tap if needed
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 20 : 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: isMobile ? 20 : 25),

                    // Header section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: isMobile ? 50 : 60,
                        ),
                        SizedBox(
                          width: 78,
                          height: 78,
                          child: ImageIcon(
                            AssetImage('assets/images/profile_image.png'),
                            size: isMobile ? 55 : 60,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    if (!isMobile)
                       Text(
                        "Good Morning!",
                        style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                      ),

                    Text(
                      "Walter White",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: isMobile ? 18 : 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Search Field - triggers search event on text change
                    FrostedGlassTextField(
                      hintText: "Search",
                      controller: _searchController,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 0, right: 8),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      onChanged: (value) {
                        context.read<DashboardBloc>().add(
                          DashboardSearchChanged(value),
                        );
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 0,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Signings Section - navigate and load SigningsBloc on tap
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BlocProvider(
                                  create:
                                      (_) =>
                                          SigningsBloc()..add(LoadSignings()),
                                  child: const SigningsScreen(),
                                ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(isMobile ? 12 : 16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Signings >",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: isMobile ? 14 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                _SigningsCount(title: "Open", count: 0),
                                _SigningsCount(title: "Closed", count: 0),
                                _SigningsCount(title: "Paydue", count: 0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Quick Service Category Grid
                    Text(
                      "Quick Service Category",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        int columnCount = 2;
                        if (constraints.maxWidth >= 900)
                          columnCount = 4;
                        else if (constraints.maxWidth >= 600)
                          columnCount = 3;

                        return GridView.count(
                          crossAxisCount: columnCount,
                          shrinkWrap: true,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 1,
                          children: const [
                            _QuickActionButton(
                              icon: Icons.edit,
                              label: "Create Signing",
                              destinationScreen: SigningsScreen(),
                            ),
                            _QuickActionButton(
                              icon: Icons.attach_money,
                              label: "Add Expense",
                              destinationScreen: SigningScreen(),
                            ),
                            _QuickActionButton(
                              icon: Icons.receipt_long,
                              label: "New Invoice",
                              destinationScreen: SigningScreen(),
                            ),
                            _QuickActionButton(
                              icon: Icons.contacts,
                              label: "Create Contact",
                              destinationScreen: ContactAndCompanyList(),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Business Listings Section
                    Text(
                      "Business Listings",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                        final selected = state.selectedPlatform;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Platform Filter Buttons - triggers BusinessPlatformSelected event
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F1A20),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildPlatformIcon(
                                    context,
                                    "google",
                                    "assets/icons/google.png",
                                    selected,
                                  ),
                                  _buildPlatformIcon(
                                    context,
                                    "indiamart",
                                    "assets/icons/indiamart.png",
                                    selected,
                                  ),
                                  _buildPlatformIcon(
                                    context,
                                    "justdial",
                                    "assets/icons/justdial.png",
                                    selected,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            LayoutBuilder(
                              builder: (context, constraints) {
                                int crossAxisCount = 1;
                                if (constraints.maxWidth >= 600)
                                  crossAxisCount = 2;
                                if (constraints.maxWidth >= 900)
                                  crossAxisCount = 3;

                                return GridView.count(
                                  crossAxisCount: crossAxisCount,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 2.3,
                                  children:
                                      state.businessCards
                                          .map(
                                            (card) => _BusinessCard(
                                              title: card.title,
                                              logoPath: card.logoAssetPath,
                                            ),
                                          )
                                          .toList(),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                    _YourWebsiteCard(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Platform Button Widget - dispatch platform change on tap
Widget _buildPlatformIcon(
  BuildContext context,
  String key,
  String assetPath,
  String selectedKey,
) {
  return GestureDetector(
    onTap:
        () => context.read<DashboardBloc>().add(BusinessPlatformSelected(key)),
    child: Column(
      children: [
        Image.asset(assetPath, height: 25),
        const SizedBox(height: 4),
        Text(
          key[0].toUpperCase() + key.substring(1),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight:
                selectedKey == key ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (selectedKey == key)
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: 4,
            width: 24,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
      ],
    ),
  );
}

class _BusinessCard extends StatelessWidget {
  final String title;
  final String logoPath;

  const _BusinessCard({required this.title, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Text(
                  "Verified",
                  style: GoogleFonts.poppins(color: Colors.green, fontSize: 12),
                ),
              ),
              const Spacer(),
              Image.asset(logoPath, height: 20),
            ],
          ),
          const SizedBox(height: 8),
           Text(
            "Last Sync 3 hours ago",
            style: GoogleFonts.poppins(color: Colors.white54, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _SigningsCount extends StatelessWidget {
  final String title;
  final int count;

  const _SigningsCount({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
        ),
        Text(
          "$count",
          style:GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget destinationScreen;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.destinationScreen,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width / 2 - 32;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => destinationScreen),
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 10),
            Text(label, style: GoogleFonts.poppins(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class _YourWebsiteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Left Section: Texts and Share Button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "Your Website",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                 Text(
                  "Your personalized multi-page website",
                  style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 8),
                 Text(
                  "https://www.YourBusinesspage...",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(color: Colors.blue, fontSize: 12),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 28,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Add share functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(123, 0, 55, 255),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child:  Text(
                      "Share",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Right Section: QR Code
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(Icons.qr_code_2, color: Colors.white, size: 50),
            ),
          ),
        ],
      ),
    );
  }
}
