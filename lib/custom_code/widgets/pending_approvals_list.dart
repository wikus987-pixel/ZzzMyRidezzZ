// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class PendingApprovalsList extends StatefulWidget {
  const PendingApprovalsList({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<PendingApprovalsList> createState() => _PendingApprovalsListState();
}

class _PendingApprovalsListState extends State<PendingApprovalsList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: StreamBuilder<List<VerifiedPaymentsRow>>(
        stream: SupaFlow.client
            .from('verified_payments')
            .stream(primaryKey: ['id'])
            .eq('verified', false)
            .map((rows) => rows.map((r) => VerifiedPaymentsRow(r)).toList()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF4B39EF)),
            );
          }

          final pendingPayments = snapshot.data ?? [];

          if (pendingPayments.isEmpty) {
            return const Center(
              child: Text(
                'No pending approvals left!',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: pendingPayments.length,
            itemBuilder: (context, index) {
              final payment = pendingPayments[index];
              final emailStr = payment.email ?? 'Unknown Email';

              return Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF1F4F8), width: 1),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x11000000),
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              emailStr,
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                color: Color(0xFF14181B),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Awaiting verification',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Color(0xFFE6A100),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: payment.verified,
                        activeColor: const Color(0xFF4B39EF),
                        onChanged: (bool value) async {
                          if (value) {
                            // Optimistically update local state if needed,
                            // but StreamBuilder will handle it when DB changes.
                            await VerifiedPaymentsTable().update(
                              data: {'verified': true},
                              matchingRows: (q) => q.eq('id', payment.id),
                            );
                            await UsersTable().update(
                              data: {'IsSignupPaid': true},
                              matchingRows: (q) =>
                                  q.eq('email', emailStr),
                            );
                          }
                        },
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
