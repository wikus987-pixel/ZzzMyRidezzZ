// Automatic FlutterFlow imports
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AdminActiveRidesList extends StatefulWidget {
  const AdminActiveRidesList({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<AdminActiveRidesList> createState() => _AdminActiveRidesListState();
}

class _AdminActiveRidesListState extends State<AdminActiveRidesList> {
  Stream<List<RidesRow>>? _ridesStream;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  void _initializeStream() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _ridesStream = SupaFlow.client
            .from('rides')
            .stream(primaryKey: ['id'])
            .map((rows) => rows
                .map((r) => RidesRow(r))
                .where((r) => (r.rideStatus ?? '').toLowerCase() != 'completed' && (r.rideStatus ?? '').toLowerCase() != 'paid')
                .toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: StreamBuilder<List<RidesRow>>(
        stream: _ridesStream ?? const Stream.empty(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading rides', style: TextStyle(color: Colors.red)));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final rides = snapshot.data ?? [];
          if (rides.isEmpty) {
            return const Center(child: Text('No active rides found.'));
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final ride = rides[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF1F4F8)),
                ),
                child: ListTile(
                  title: Text('${ride.departureLocation} → ${ride.arrivalLocation}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Status: ${ride.rideStatus} | Date: ${dateTimeFormat("d MMM, HH:mm", ride.departureTime)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cancel Ride'),
                          content: const Text('Are you sure you want to delete this active ride? This will remove it for all users.'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Back')),
                            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        try {
                          await RidesTable().delete(matchingRows: (q) => q.eq('id', ride.id));
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ride deleted')));
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      }
                    },
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
