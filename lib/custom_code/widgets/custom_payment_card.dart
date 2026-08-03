// Automatic FlutterFlow imports
import 'package:ride_share_supa/backend/backend.dart';
// Imports other custom widgets
// Imports custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class CustomPaymentCard extends StatefulWidget {
  const CustomPaymentCard({
    super.key,
    this.width,
    this.height,
    required this.userUid,
  });

  final double? width;
  final double? height;
  final String userUid;

  @override
  State<CustomPaymentCard> createState() => _CustomPaymentCardState();
}

class _CustomPaymentCardState extends State<CustomPaymentCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UsersRow>>(
      future: UsersTable().queryRows(
        queryFn: (q) => q.eq('uid', widget.userUid),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox(
            height: 80,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final userData = snapshot.data!.first;
        if (userData.isSignupPaid == true) {
          return const SizedBox.shrink(); // Hides the card once verified
        }

        final String email = userData.email ?? 'No Email Provided';
        // Fallback placeholder values for display
        final String timeAgo = 'Just now';
        final String amount = 'R150.00';

        return GestureDetector(
          onTap: () async {
            // 1. Write to verified_payments
            await VerifiedPaymentsTable().insert({
              'Email': email.toLowerCase().trim(),
              'status': 'verified',
            });

            // 2. Update user record
            await UsersTable().update(
              data: {'IsSignupPaid': true},
              matchingRows: (q) => q.eq('uid', widget.userUid),
            );

            if (!context.mounted) return;
            // 3. Show native success alert
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$email verified successfully!'),
                backgroundColor: Colors.green,
              ),
            );

            // Refresh the widget
            setState(() {});
          },
          child: Container(
            width: widget.width ?? double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF14181B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        timeAgo,
                        style: const TextStyle(
                            fontSize: 13, color: Color(0xFF57636C)),
                      ),
                      Text(
                        amount,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B39EF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
