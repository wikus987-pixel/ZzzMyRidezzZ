// Automatic FlutterFlow imports
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/index.dart';
import 'package:flutter/material.dart';

class BookingApprovalsList extends StatefulWidget {
  const BookingApprovalsList({
    super.key,
    this.width,
    this.height,
    this.status = 'Pending',
  });

  final double? width;
  final double? height;
  final String status;

  @override
  State<BookingApprovalsList> createState() => _BookingApprovalsListState();
}

class _BookingApprovalsListState extends State<BookingApprovalsList> {
  Stream<List<PendingPaymentsRow>>? _bookingsStream;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  void _initializeStream() {
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _bookingsStream = SupaFlow.client
            .from('PendingPayments')
            .stream(primaryKey: ['id'])
            .map((rows) => rows
                .map((r) => PendingPaymentsRow(r))
                .where((p) => p.status?.toLowerCase() == widget.status.toLowerCase())
                .toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: StreamBuilder<List<PendingPaymentsRow>>(
        stream: _bookingsStream ?? const Stream.empty(),
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

          final bookings = snapshot.data ?? [];

          if (bookings.isEmpty) {
            return Center(
              child: Text(
                widget.status.toLowerCase() == 'pending' 
                    ? 'No bookings awaiting confirmation!' 
                    : 'No confirmed bookings found.',
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              return BookingApprovalCard(booking: bookings[index]);
            },
          );
        },
      ),
    );
  }
}

class BookingApprovalCard extends StatefulWidget {
  const BookingApprovalCard({super.key, required this.booking});

  final PendingPaymentsRow booking;

  @override
  State<BookingApprovalCard> createState() => _BookingApprovalCardState();
}

class _BookingApprovalCardState extends State<BookingApprovalCard> {
  bool _processing = false;

  @override
  Widget build(BuildContext context) {
    final booking = widget.booking;
    final seats = booking.seatsRequested ?? 0;

    return FutureBuilder<List<RidesRow>>(
      future: RidesTable().querySingleRow(
        queryFn: (q) => q.eqOrNull('id', booking.rideReference),
      ),
      builder: (context, snapshot) {
        final ride = (snapshot.data != null && snapshot.data!.isNotEmpty)
            ? snapshot.data!.first
            : null;
        final totalRand =
            ride != null ? (ride.pricePerSeat ?? 0.0) * 1.10 * seats : 0.0;

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ride #${booking.rideReference ?? '-'}  •  $seats seat(s)',
                        style: const TextStyle(
                          color: Color(0xFF14181B),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Total: R${totalRand.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFF14181B),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      FutureBuilder<List<UsersRow>>(
                        future: UsersTable().querySingleRow(
                          queryFn: (q) => q.eq('uid', booking.userReference ?? ''),
                        ),
                        builder: (context, userSnapshot) {
                          final user = (userSnapshot.data != null && userSnapshot.data!.isNotEmpty) 
                              ? userSnapshot.data!.first 
                              : null;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.firstName ?? booking.userReference ?? 'Unknown booker',
                                style: const TextStyle(
                                  color: Color(0xFF57636C),
                                  fontSize: 11,
                                ),
                              ),
                              if (user != null) ...[
                                Text(
                                  'Email: ${user.email ?? '-'}',
                                  style: const TextStyle(color: Color(0xFF57636C), fontSize: 10),
                                ),
                                Text(
                                  'Cell: ${user.cellNumber ?? '-'}',
                                  style: const TextStyle(color: Color(0xFF57636C), fontSize: 10),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                _processing
                    ? const SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      )
                    : (booking.status?.toLowerCase() == 'pending' 
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (ride == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Error: Ride not found.')),
                                      );
                                      return;
                                    }
                                    setState(() => _processing = true);
                                    try {
                                      await PendingPaymentsTable().update(
                                        data: {'status': 'Booked'},
                                        matchingRows: (q) => q.eq('id', booking.id),
                                      );
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Booking confirmed successfully!')),
                                      );
                                    } catch (e) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error: $e')),
                                      );
                                    } finally {
                                      if (mounted) setState(() => _processing = false);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    minimumSize: const Size(60, 36),
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.credit_card, color: Color(0xFF4B39EF), size: 24),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                tooltip: 'Pay with Card',
                                onPressed: () {
                                  context.pushNamed(
                                    PaymentPageWidget.routeName,
                                    queryParameters: {
                                      'initialAmount': totalRand.toStringAsFixed(2),
                                      'initialEmail': booking.userReference ?? '',
                                      'paymentDescription': 'Booking Payment: Ride #${booking.rideReference}',
                                      'paymentType': 'booking',
                                      'rideId': booking.rideReference.toString(),
                                      'seats': booking.seatsRequested.toString(),
                                    }.withoutNulls,
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 24),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Booking'),
                                      content: const Text('Are you sure you want to remove this booking request? This will refund the seats to the ride.'),
                                      actions: [
                                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                        TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                                      ],
                                    ),
                                  );

                                  if (confirm == true) {
                                    setState(() => _processing = true);
                                    try {
                                      // 1. Refund seats to ride
                                      if (ride != null) {
                                        final newAvailable = (ride.seatsAvailable ?? 0) + seats;
                                        final currentBooked = int.tryParse(ride.seatsBooked ?? '0') ?? 0;
                                        final newBooked = (currentBooked - seats).clamp(0, 999);
                                        
                                        await RidesTable().update(
                                          data: {
                                            'seats_available': newAvailable,
                                            'SeatsBooked': newBooked.toString(),
                                            'RideStatus': 'Open', // Reset status as seats are now free
                                          },
                                          matchingRows: (q) => q.eq('id', ride.id),
                                        );
                                      }

                                      // 2. Delete booking record
                                      await PendingPaymentsTable().delete(
                                        matchingRows: (q) => q.eq('id', booking.id),
                                      );
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Booking deleted and seats refunded.')),
                                      );
                                    } catch (e) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error: $e')),
                                      );
                                    } finally {
                                      if (mounted) setState(() => _processing = false);
                                    }
                                  }
                                },
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check_circle, color: Colors.green, size: 28),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 24),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                tooltip: 'Delete Booking Record',
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Booking'),
                                      content: const Text('Are you sure you want to permanently delete this confirmed booking record? This will refund the seats to the ride.'),
                                      actions: [
                                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                        TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                                      ],
                                    ),
                                  );

                                  if (confirm == true) {
                                    setState(() => _processing = true);
                                    try {
                                      // 1. Refund seats to ride
                                      if (ride != null) {
                                        final newAvailable = (ride.seatsAvailable ?? 0) + seats;
                                        final currentBooked = int.tryParse(ride.seatsBooked ?? '0') ?? 0;
                                        final newBooked = (currentBooked - seats).clamp(0, 999);
                                        
                                        await RidesTable().update(
                                          data: {
                                            'seats_available': newAvailable,
                                            'SeatsBooked': newBooked.toString(),
                                            'RideStatus': 'Open',
                                          },
                                          matchingRows: (q) => q.eq('id', ride.id),
                                        );
                                      }

                                      // 2. Delete booking record
                                      await PendingPaymentsTable().delete(
                                        matchingRows: (q) => q.eq('id', booking.id),
                                      );
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Confirmed booking deleted and seats refunded.')),
                                      );
                                    } catch (e) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error deleting booking: $e')),
                                      );
                                    } finally {
                                      if (mounted) setState(() => _processing = false);
                                    }
                                  }
                                },
                              ),
                            ],
                          )),
              ],
            ),
          ),
        );
      },
    );
  }
}
