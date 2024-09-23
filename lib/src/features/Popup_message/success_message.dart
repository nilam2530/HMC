import 'package:flutter/material.dart';

class SuccessMessage extends StatelessWidget {
  const SuccessMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: const Color(0xFF1CA076),
      content: SizedBox(
        width: 338,
        height: 44, // Set a more appropriate height for the content
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Align content and icon button with space between
          children: [
            Row(
              children: [
                Image.asset('assets/images/tick.png'),
                const SizedBox(width: 16),
                const Text(
                  'Request Submitted Successfully',
                  style: TextStyle(
                    color: Color(0xFFFBFCFD),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            // Move IconButton outside the inner Row to align it properly
            IconButton(
              onPressed: () {
                //onPressed Logic
              },
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
