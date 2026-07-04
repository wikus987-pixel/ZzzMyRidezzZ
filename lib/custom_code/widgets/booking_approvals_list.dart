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

class BookingApprovalsList extends StatefulWidget {
  const BookingApprovalsList({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<BookingApprovalsList> createState() => _BookingApprovalsListState();
}

class _BookingApprovalsListState extends State<BookingApprovalsList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: StreamBuilder<List<PendingPaymentsRow>>(
        stream: SupaFlow.client
            .from('PendingPayments')
            .stream(primaryKey: ['id'])
            .map((rows) => rows
                .map((r) => PendingPaymentsRow(r))
                .where((p) => p.status == 'Pending' || p.status == 'pending')
                .toList()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF4B39EF)),
            );
          }

          final bookings = snapshot.data ?? [];

          if (bookings.isEmpty) {
            return const Center(
              child: Text(
                'No bookings awaiting confirmation!',
                style: TextStyle(color: Colors.grey, fontSize: 16),
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
                          fontFamily: 'Outfit',
                          color: Color(0xFF14181B),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Total: R${totalRand.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF14181B),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking.userReference ?? 'Unknown booker',
                        style: const TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF57636C),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                _processing
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Switch(
                        value: booking.status == 'Booked',
                        activeColor: const Color(0xFF4B39EF),
                        onChanged: (bool value) async {
                          if (ride == null) return;
                          setState(() => _processing = true);

                          if (value) {
                            final remaining = (ride.seatsAvailable ?? 0) - seats;
                            if (remaining < 0) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Not enough seats available')),
                                );
                                setState(() => _processing = false);
                              }
                              return;
                            }
                            await RidesTable().update(
                              data: {
                                'seats_available': remaining,
                                if (remaining == 0) 'RideStatus': 'Booked',
                              },
                              matchingRows: (q) => q.eq('id', ride.id),
                            );
                            await PendingPaymentsTable().update(
                              data: {'status': 'Booked'},
                              matchingRows: (q) => q.eq('id', booking.id),
                            );
                          } else {
                            // Un-book logic
                            final restored = (ride.seatsAvailable ?? 0) + seats;
                            await RidesTable().update(
                              data: {
                                'seats_available': restored,
                                'RideStatus': 'Open',
                              },
                              matchingRows: (q) => q.eq('id', ride.id),
                            );
                            await PendingPaymentsTable().update(
                              data: {'status': 'Pending'},
                              matchingRows: (q) => q.eq('id', booking.id),
                            );
                          }

                          if (mounted) setState(() => _processing = false);
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
