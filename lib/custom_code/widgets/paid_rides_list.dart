// Automatic FlutterFlow imports
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:flutter/material.dart';

class PaidRidesList extends StatefulWidget {
  const PaidRidesList({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<PaidRidesList> createState() => _PaidRidesListState();
}

class _PaidRidesListState extends State<PaidRidesList> {
  Stream<List<RidesRow>>? _paidRidesStream;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  void _initializeStream() {
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _paidRidesStream = SupaFlow.client
            .from('rides')
            .stream(primaryKey: ['id'])
            .eq('RideStatus', 'Paid')
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
        stream: _paidRidesStream ?? const Stream.empty(),
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
                'No paid rides in history.',
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
                      const Chip(
                        label: Text('Paid', style: TextStyle(color: Colors.white, fontSize: 10)),
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.zero,
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
