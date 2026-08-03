// Automatic FlutterFlow imports
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

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
  Stream<List<RidesRow>>? _completedRidesStream;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  void _initializeStream() {
    Future.delayed(const Duration(milliseconds: 1100), () {
      if (!mounted) return;
      setState(() {
        _completedRidesStream = SupaFlow.client
            .from('rides')
            .stream(primaryKey: ['id'])
            .eq('RideStatus', 'Completed')
            .map((rows) => rows.map((r) => RidesRow(r)).toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: StreamBuilder<List<RidesRow>>(
        stream: _completedRidesStream ?? const Stream.empty(),
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
          if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
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
                            FutureBuilder<List<UsersRow>>(
                              future: UsersTable().querySingleRow(
                                queryFn: (q) => q.eq('uid', ride.createdBy ?? ''),
                              ),
                              builder: (context, userSnapshot) {
                                final user = (userSnapshot.data != null && userSnapshot.data!.isNotEmpty)
                                    ? userSnapshot.data!.first
                                    : null;
                                return Text(
                                  'Driver: ${user?.firstName ?? ride.createdBy ?? 'Unknown'}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              await RidesTable().update(
                                data: {'RideStatus': 'Paid'},
                                matchingRows: (q) => q.eq('id', ride.id),
                              );
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Payout confirmed!')),
                              );
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
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            tooltip: 'Delete Ride Record',
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Ride'),
                                  content: const Text('Are you sure you want to permanently delete this completed ride record?'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                try {
                                  await RidesTable().delete(
                                    matchingRows: (q) => q.eq('id', ride.id),
                                  );
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Ride record deleted')),
                                  );
                                } catch (e) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error deleting ride: $e')),
                                  );
                                }
                              }
                            },
                          ),
                        ],
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
