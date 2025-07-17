import 'package:vypaar360/blocs/expense/expense_screen_bloc.dart';
import 'package:vypaar360/blocs/expense/expense_screen_event.dart';
import 'package:vypaar360/blocs/expense/expense_screen_state.dart';
import 'package:vypaar360/screens/add_expense_screen.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vypaar360/widgets/froested_search_bar_widget.dart';

import 'dashboard_screen.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
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
      create: (_) => ExpenseBloc(),
      child: GlassyBackgroundScaffold(
        showBottomNav: true,
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (route) => false,
            );
            return false;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.04,
                    top: screenHeight * 0.03,
                    bottom:
                        MediaQuery.of(context).viewInsets.bottom +
                        screenHeight * 0.02,
                  ),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Header Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Expenses",
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.065,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SigningScreen(),
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

                        SizedBox(height: screenHeight * 0.035),

                        /// Total Expenses Card
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.006,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.03,
                            horizontal: screenWidth * 0.05,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Expenses',
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                '\$${state.totalExpense.toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.035),
                              Row(
                                children: const [
                                  FilterButton(title: "All Time"),
                                  FilterButton(title: "Last Month"),
                                  FilterButton(title: "Year"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.035),
                        FrostedSearchBar(
                          controller: _searchController,
                          hintText: "Search Expense",
                        ),

                        SizedBox(height: screenHeight * 0.1),

                        /// Empty Message
                        Center(
                          child: Text(
                            'No Expense Found',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String title;

  const FilterButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSelected = context.select<ExpenseBloc, bool>(
      (bloc) => bloc.state.selectedFilter == title,
    );

    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<ExpenseBloc>().add(ChangeFilter(title));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
          decoration: BoxDecoration(
            color:
                isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: screenWidth * 0.03,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
