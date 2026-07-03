// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class AdminVerificationList extends StatefulWidget {
  const AdminVerificationList({
    super.key,
    this.width,
    this.height,
    required this.userUids,
  });

  final double? width;
  final double? height;
  final List<String> userUids;

  @override
  State<AdminVerificationList> createState() => _AdminVerificationListState();
}

class _AdminVerificationListState extends State<AdminVerificationList> {
  @override
  Widget build(BuildContext context) {
    if (widget.userUids.isEmpty) {
      return const Center(child: Text('No pending verifications found.'));
    }

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: ListView.builder(
        itemCount: widget.userUids.length,
        itemBuilder: (context, index) {
          final userUid = widget.userUids[index];

          return FutureBuilder<List<UsersRow>>(
            future: UsersTable().queryRows(
              queryFn: (q) => q.eq('uid', userUid),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator()));
              }

              final userData = snapshot.data!.first;
              if (userData.isSignupPaid == true) {
                return const SizedBox.shrink();
              }

              final String email = userData.email ?? 'No Email';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          email,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () async {
                          // 1. Add to verified_payments
                          await VerifiedPaymentsTable().insert({
                            'email': email.toLowerCase().trim(),
                            'status': 'verified',
                          });

                          // 2. Mark user as paid
                          await UsersTable().update(
                            data: {'IsSignupPaid': true},
                            matchingRows: (q) => q.eq('uid', userUid),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('$email verified successfully!')),
                          );

                          setState(() {});
                        },
                        child: const Text('Verify',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
