import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'booked_rides_card_model.dart';
export 'booked_rides_card_model.dart';

class BookedRidesCardWidget extends StatefulWidget {
  const BookedRidesCardWidget({
    super.key,
    this.status = 'Confirmed',
    this.seatsbooked,
    this.rideReference,
  });

  final String status;
  final int? seatsbooked;
  final int? rideReference;

  @override
  State<BookedRidesCardWidget> createState() => _BookedRidesCardWidgetState();
}

class _BookedRidesCardWidgetState extends State<BookedRidesCardWidget> {
  late BookedRidesCardModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookedRidesCardModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Future<void> _launchWhatsApp(String? phone) async {
    if (phone == null || phone.isEmpty) return;
    // Format phone to remove non-digits
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final url = 'https://wa.me/$cleanPhone';
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        // Fallback for some systems where canLaunchUrl might fail
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Could not launch WhatsApp: $e');
    }
  }

  Future<void> _launchEmail(String? email, int? rideId) async {
    if (email == null || email.isEmpty) return;
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Booking Inquiry regarding Ride #$rideId',
      },
    );
    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        // Fallback for some systems where canLaunchUrl might fail but launchUrl works
        await launchUrl(emailLaunchUri);
      }
    } catch (e) {
      debugPrint('Could not launch email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).alternate,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  FlutterFlowTheme.of(context).primary,
                  FlutterFlowTheme.of(context).secondary,
                ],
                stops: const [0.0, 1.0],
                begin: const AlignmentDirectional(0.0, -1.0),
                end: const AlignmentDirectional(0, 1.0),
              ),
              borderRadius: BorderRadius.circular(22.0),
              border: Border.all(
                color: const Color(0xFF010094),
                width: 5.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<RidesRow?>(
                future: widget.rideReference != null
                    ? getRideById(widget.rideReference!)
                    : Future.value(null),
                builder: (context, rideSnapshot) {
                  if (rideSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final ride = rideSnapshot.data;
                  if (ride == null) {
                    return const Center(child: Text('Ride details not found.', style: TextStyle(color: Colors.white)));
                  }

                  return FutureBuilder<UsersRow?>(
                    future: getUserByUid(ride.createdBy ?? ''),
                    builder: (context, userSnapshot) {
                      final driver = userSnapshot.data;
                      final totalRand = (ride.pricePerSeat ?? 0.0) * 1.10 * (widget.seatsbooked ?? 1);

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ride.departureLocation ?? 'Departure',
                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                            font: GoogleFonts.interTight(),
                                            color: Colors.white,
                                          ),
                                    ),
                                    Text(
                                      dateTimeFormat('d MMM y - HH:mm', ride.departureTime),
                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                            font: GoogleFonts.inter(),
                                            color: FlutterFlowTheme.of(context).warning,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.east_rounded, color: Colors.white70, size: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      ride.arrivalLocation ?? 'Arrival',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                            font: GoogleFonts.interTight(),
                                            color: Colors.white,
                                          ),
                                    ),
                                    Text(
                                      dateTimeFormat('d MMM y - HH:mm', ride.arrivalTime),
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                            font: GoogleFonts.inter(),
                                            color: FlutterFlowTheme.of(context).warning,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${widget.seatsbooked ?? 0} seats booked',
                                style: FlutterFlowTheme.of(context).labelSmall.override(
                                      font: GoogleFonts.inter(),
                                      color: Colors.white,
                                    ),
                              ),
                              Text(
                                'R${totalRand.toStringAsFixed(2)}',
                                style: FlutterFlowTheme.of(context).titleSmall.override(
                                      font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                          const Divider(height: 24, color: Colors.white24),
                          // Driver Info
                          Text(
                            'Driver: ${driver?.firstName ?? 'N/A'}',
                            style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Vehicle: ${driver?.vehicleRegistration ?? 'N/A'}',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          Text(
                            'Email: ${driver?.email ?? 'N/A'}',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          Text(
                            'Phone: ${driver?.cellNumber ?? 'N/A'}',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: FFButtonWidget(
                                  onPressed: () => _launchEmail(driver?.email, ride.id),
                                  text: 'Email Driver',
                                  icon: const Icon(Icons.mail_outline, size: 18),
                                  options: FFButtonOptions(
                                    height: 36,
                                    color: Colors.white24,
                                    textStyle: const TextStyle(color: Colors.white, fontSize: 12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: FFButtonWidget(
                                  onPressed: () => _launchWhatsApp(driver?.cellNumber),
                                  text: 'WhatsApp Driver',
                                  icon: const Icon(Icons.chat_bubble_outline, size: 18),
                                  options: FFButtonOptions(
                                    height: 36,
                                    color: const Color(0xFF249689),
                                    textStyle: const TextStyle(color: Colors.white, fontSize: 12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
