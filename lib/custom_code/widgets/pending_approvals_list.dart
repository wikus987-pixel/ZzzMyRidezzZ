// Automatic FlutterFlow imports
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/index.dart';
import 'package:flutter/material.dart';

class PendingApprovalsList extends StatefulWidget {
  const PendingApprovalsList({
    super.key,
    this.width,
    this.height,
    this.verified = false,
  });

  final double? width;
  final double? height;
  final bool verified;

  @override
  State<PendingApprovalsList> createState() => _PendingApprovalsListState();
}

class _PendingApprovalsListState extends State<PendingApprovalsList> {
  final Map<int, bool> _processingItems = {};
  Stream<List<VerifiedPaymentsRow>>? _approvalsStream;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  void _initializeStream() {
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        _approvalsStream = SupaFlow.client
            .from('verified_payments')
            .stream(primaryKey: ['id'])
            .eq('verified', widget.verified)
            .map((rows) => rows.map((r) => VerifiedPaymentsRow(r)).toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: StreamBuilder<List<VerifiedPaymentsRow>>(
        stream: _approvalsStream ?? const Stream.empty(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Connection lost', style: TextStyle(color: Colors.red)),
                  TextButton(
                    onPressed: () => _initializeStream(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF4B39EF)),
            );
          }

          final pendingPayments = snapshot.data ?? [];

          if (pendingPayments.isEmpty) {
            return Center(
              child: Text(
                widget.verified 
                    ? 'No confirmed registrations found.' 
                    : 'No pending registrations awaiting verification.',
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: pendingPayments.length,
            itemBuilder: (context, index) {
              final payment = pendingPayments[index];
              final emailStr = payment.email ?? 'Unknown Email';
              final bool isProcessing = _processingItems[payment.id] ?? false;

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder<List<UsersRow>>(
                                  future: UsersTable().querySingleRow(
                                    queryFn: (q) => q.eq('email', emailStr),
                                  ),
                                    builder: (context, userSnapshot) {
                                    final user = (userSnapshot.data != null && userSnapshot.data!.isNotEmpty)
                                        ? userSnapshot.data!.first
                                        : null;
                                    final displayName = (user != null && user.firstName != null)
                                        ? '${user.firstName} ($emailStr)'
                                        : emailStr;
                                    return Text(
                                      displayName,
                                      style: const TextStyle(
                                        color: Color(0xFF14181B),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.verified ? 'Verified' : 'Awaiting verification',
                                  style: TextStyle(
                                    color: widget.verified ? const Color(0xFF249689) : const Color(0xFFE6A100),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (widget.verified)
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              tooltip: 'Remove Record',
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Remove Confirmation'),
                                    content: Text('Are you sure you want to remove the record for $emailStr? This does NOT undo the payment.'),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                      TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Remove', style: TextStyle(color: Colors.red))),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  try {
                                    await VerifiedPaymentsTable().delete(
                                      matchingRows: (q) => q.eq('id', payment.id),
                                    );
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Record removed')),
                                    );
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error removing record: $e')),
                                    );
                                  }
                                }
                              },
                            ),
                        ],
                      ),
                      if (!widget.verified) ...[
                        const SizedBox(height: 16),
                        const Divider(height: 1, thickness: 1, color: Color(0xFFF1F4F8)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (isProcessing)
                              const Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              )
                            else ...[
                              ElevatedButton(
                                onPressed: () async {
                                  setState(() => _processingItems[payment.id] = true);
                                  try {
                                    await VerifiedPaymentsTable().update(
                                      data: {'verified': true, 'status': 'verified'},
                                      matchingRows: (q) => q.eq('id', payment.id),
                                    );
                                    if (payment.email != null) {
                                      await UsersTable().update(
                                        data: {'IsSignupPaid': true},
                                        matchingRows: (q) => q.eq('email', payment.email!),
                                      );
                                    }
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Verified $emailStr successfully!')),
                                    );
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error: $e')),
                                    );
                                  } finally {
                                    if (mounted) {
                                      setState(() => _processingItems.remove(payment.id));
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF249689),
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Confirm', style: TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(width: 12),
                              IconButton(
                                icon: const Icon(Icons.credit_card, color: Color(0xFF4B39EF)),
                                tooltip: 'Pay with Card',
                                style: IconButton.styleFrom(
                                  backgroundColor: const Color(0x1A4B39EF),
                                ),
                                onPressed: () {
                                  context.pushNamed(
                                    PaymentPageWidget.routeName,
                                    queryParameters: {
                                      'initialAmount': '45.00',
                                      'initialEmail': emailStr,
                                      'paymentDescription': 'Admin Card Payment for $emailStr',
                                      'paymentType': 'registration',
                                    }.withoutNulls,
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.red),
                                tooltip: 'Delete',
                                style: IconButton.styleFrom(
                                  backgroundColor: const Color(0x1AF44336),
                                ),
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Registration'),
                                      content: Text('Are you sure you want to remove the verification request for $emailStr?'),
                                      actions: [
                                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                        TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                                      ],
                                    ),
                                  );

                                  if (confirm == true) {
                                    try {
                                      await VerifiedPaymentsTable().delete(
                                        matchingRows: (q) => q.eq('id', payment.id),
                                      );
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Registration entry deleted')),
                                      );
                                    } catch (e) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error deleting entry: $e')),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ],
                        ),
                      ],
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
