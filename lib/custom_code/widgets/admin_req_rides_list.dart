// Automatic FlutterFlow imports
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AdminReqRidesList extends StatefulWidget {
  const AdminReqRidesList({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<AdminReqRidesList> createState() => _AdminReqRidesListState();
}

class _AdminReqRidesListState extends State<AdminReqRidesList> {
  Stream<List<ReqRidesRow>>? _requestsStream;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  void _initializeStream() {
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _requestsStream = SupaFlow.client
            .from('ReqRides')
            .stream(primaryKey: ['id'])
            .map((rows) => rows.map((r) => ReqRidesRow(r)).toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: StreamBuilder<List<ReqRidesRow>>(
        stream: _requestsStream ?? const Stream.empty(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading requests', style: TextStyle(color: Colors.red)));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final requests = snapshot.data ?? [];
          if (requests.isEmpty) {
            return const Center(child: Text('No ride requests found.'));
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF1F4F8)),
                ),
                child: ListTile(
                  title: Text('${request.departureLocation} → ${request.arrivalLocation}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Seats: ${request.seatsNeeded} | Date: ${dateTimeFormat("d MMM, HH:mm", request.departureTime)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Request'),
                          content: const Text('Are you sure you want to delete this ride request?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        try {
                          await ReqRidesTable().delete(matchingRows: (q) => q.eq('id', request.id));
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request deleted')));
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
