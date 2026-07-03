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

class CompletedRidesList extends StatefulWidget {
  const CompletedRidesList({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<CompletedRidesList> createState() => _CompletedRidesListState();
}

class _CompletedRidesListState extends State<CompletedRidesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: StreamBuilder<List<RidesRow>>(
        stream: SupaFlow.client
            .from('rides')
            .stream(primaryKey: ['id'])
            .eq('RideStatus', 'Completed')
            .map((rows) => rows.map((r) => RidesRow(r)).toList()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF4B39EF)),
            );
          }

          final rides = snapshot.data ?? [];

          if (rides.isEmpty) {
            return const Center(
              child: Text(
                'No completed rides to pay out!',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final ride = rides[index];
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF1F4F8), width: 1),
                  boxShadow: const [
                    BoxShadow(blurRadius: 4, color: Color(0x11000000), offset: Offset(0, 2))
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
                              '${ride.departureLocation} → ${ride.arrivalLocation}',
                              style: const TextStyle(
                                color: Color(0xFF14181B),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Driver: ${ride.createdBy}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          await RidesTable().update(
                            data: {'RideStatus': 'Paid'},
                            matchingRows: (q) => q.eq('id', ride.id),
                          );
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Payout confirmed!')),
                            );
                          }
                        },
                        text: 'Pay Driver',
                        options: FFButtonOptions(
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          color: const Color(0xFF4B39EF),
                          textStyle: const TextStyle(color: Colors.white, fontSize: 12),
                          borderRadius: BorderRadius.circular(8),
                        ),
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
