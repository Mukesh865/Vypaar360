import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String role;
  final String paidAmount;
  final String dueAmount;
  final VoidCallback? onCallTap;

  const ContactCard({
    super.key,
    required this.name,
    required this.role,
    required this.paidAmount,
    required this.dueAmount,
    this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFF656565),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: 70,
                width: 70,
                child: ImageIcon(AssetImage('assets/images/profile_image.png'),color: Colors.black,size:50 ,)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFC9CCC9),
                  ),
                ),
                Text(
                  role,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '\$$paidAmount ',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Paid   ',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Color(0xFFC9CCC9),
                      ),
                    ),
                    Text(
                      '\$$dueAmount ',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Due',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Color(0xFFC9CCC9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onCallTap,
            child: SizedBox(
              width: 44,
              height: 33,
              child: Icon(
                Icons.call_rounded,
                size: 30,
                color: Colors.black,

              ),
            ),
          ),
        ],
      ),
    );
  }
}
