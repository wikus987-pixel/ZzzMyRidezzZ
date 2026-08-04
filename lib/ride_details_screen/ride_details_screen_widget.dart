import 'package:ride_share_supa/auth/supabase_auth/auth_util.dart';
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_drop_down.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
import 'package:ride_share_supa/flutter_flow/form_field_controller.dart';
import 'package:ride_share_supa/flutter_flow/custom_functions.dart' as functions;
import 'package:ride_share_supa/services/paypal_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ride_details_screen_model.dart';
export 'ride_details_screen_model.dart';

class RideDetailsScreenWidget extends StatefulWidget {
  const RideDetailsScreenWidget({
    super.key,
    required this.selectedRide,
  });

  final RidesRow? selectedRide;

  static String routeName = 'rideDetails_Screen';
  static String routePath = 'rideDetailsScreen';

  @override
  State<RideDetailsScreenWidget> createState() =>
      _RideDetailsScreenWidgetState();
}

class _RideDetailsScreenWidgetState extends State<RideDetailsScreenWidget>
    with TickerProviderStateMixin {
  late RideDetailsScreenModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  Stream<List<RidesRow>>? _rideDetailsStream;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RideDetailsScreenModel());
    
    _initializeStream();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _initializeStream() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        _rideDetailsStream = SupaFlow.client
            .from('rides')
            .stream(primaryKey: ['id'])
            .eq('id', widget.selectedRide?.id ?? 0)
            .map((rows) => rows.map((r) => RidesRow(r)).toList());
      });
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RidesRow>>(
      stream: _rideDetailsStream ?? const Stream.empty(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Connection lost', style: TextStyle(color: Colors.red)),
                  const SizedBox(height: 12),
                  FFButtonWidget(
                    onPressed: () => _initializeStream(),
                    text: 'Retry',
                    options: FFButtonOptions(
                      width: 100,
                      height: 40,
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: const TextStyle(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final ride = snapshot.data!.first;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            title: Text(
              'Ride Details',
              style: GoogleFonts.interTight(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _detailRow('Departure Town', ride.departureLocation),
                  _detailRow('Pickup Point', ride.pickup ?? 'TBA'),
                  _detailRow('Departure Time', dateTimeFormat("d MMMM y - HH:mm", ride.departureTime)),
                  const Divider(),
                  _detailRow('Arrival Town', ride.arrivalLocation),
                  _detailRow('Drop-off Point', ride.dropoff ?? 'TBA'),
                  _detailRow('Arrival Time', dateTimeFormat("d MMMM y - HH:mm", ride.arrivalTime)),
                  const Divider(),
                   
                  // Available Seats and Parcels with color coding
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Available Seats', style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getSeatColor(ride.seatsAvailable ?? 0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${ride.seatsAvailable ?? 0}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Available Parcels', style: TextStyle(fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getParcelColor(ride.numberOfParcels ?? 0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${ride.numberOfParcels ?? 0}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                   
                  const SizedBox(height: 20),
                  
                  FlutterFlowDropDown<int>(
                    controller: _model.dropDownValueController ??= FormFieldController<int>(null),
                    options: List.generate(ride.seatsAvailable ?? 0, (i) => i + 1),
                    optionLabels: List.generate(ride.seatsAvailable ?? 0, (i) => (i + 1).toString()),
                    onChanged: (val) => setState(() => _model.dropDownValue = val),
                    width: double.infinity,
                    height: 50,
                    hintText: 'Select Seats',
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: 8,
                    borderWidth: 1,
                    borderColor: FlutterFlowTheme.of(context).alternate,
                    margin: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    elevation: 2,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium,
                  ),

                  const SizedBox(height: 20),

                  if (ride.numberOfParcels != null && (ride.numberOfParcels ?? 0) > 0) ...[
                    FlutterFlowDropDown<int>(
                      controller: _model.parcelDropDownValueController ??= FormFieldController<int>(null),
                      options: List.generate(ride.numberOfParcels ?? 0, (i) => i + 1),
                      optionLabels: List.generate(ride.numberOfParcels ?? 0, (i) => (i + 1).toString()),
                      onChanged: (val) => setState(() => _model.parcelDropDownValue = val),
                      width: double.infinity,
                      height: 50,
                      hintText: 'Select Parcels',
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: 8,
                      borderWidth: 1,
                      borderColor: FlutterFlowTheme.of(context).alternate,
                      margin: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                      elevation: 2,
                      textStyle: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    const SizedBox(height: 20),
                  ],
                  
                  if (_model.dropDownValue != null || _model.parcelDropDownValue != null) ...[
                    if (_model.dropDownValue != null)
                      Column(
                        children: [
                          Text(
                            'Seats Total: R${functions.getRandTotal(ride.pricePerSeat, _model.dropDownValue?.toString())}',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                              font: GoogleFonts.inter(),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    if (_model.parcelDropDownValue != null)
                      Column(
                        children: [
                          Text(
                            'Parcels Total: R${functions.getParcelRandTotal(ride.pricePerParcel, _model.parcelDropDownValue?.toString())}',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                              font: GoogleFonts.inter(),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    Builder(builder: (context) {
                      double seatRand = double.tryParse(functions.getRandTotal(ride.pricePerSeat, _model.dropDownValue?.toString())) ?? 0.0;
                      double parcelRand = double.tryParse(functions.getParcelRandTotal(ride.pricePerParcel, _model.parcelDropDownValue?.toString())) ?? 0.0;
                      double totalRand = seatRand + parcelRand;
                      // Fallback conversion rate for display
                      double totalUSD = totalRand * 0.056;
                      
                      return Column(
                        children: [
                          Text(
                            'Final Total: R${totalRand.toStringAsFixed(2)}',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                              font: GoogleFonts.inter(),
                              fontWeight: FontWeight.w900,
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                          Text(
                            '(\$${totalUSD.toStringAsFixed(2)} USD)',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodySmall,
                          ),
                        ],
                      );
                    }),
                  ],

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (_model.dropDownValue == null && _model.parcelDropDownValue == null) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select seats or parcels')));
                              return;
                            }

                            final messenger = ScaffoldMessenger.of(context);
                            
                            double seatRand = double.tryParse(functions.getRandTotal(ride.pricePerSeat, _model.dropDownValue?.toString())) ?? 0.0;
                            double parcelRand = double.tryParse(functions.getParcelRandTotal(ride.pricePerParcel, _model.parcelDropDownValue?.toString())) ?? 0.0;
                            double totalRand = seatRand + parcelRand;
                            // Re-calculate precisely or use live rate if possible
                            String usdAmountStr = (totalRand * 0.056).toStringAsFixed(2);
                            
                            messenger.showSnackBar(const SnackBar(content: Text('Opening PayPal...')));
                            
                            final success = await PayPalService.processPayment(
                              amount: usdAmountStr,
                              currency: "USD",
                              description: 'Booking: Ride #${ride.id} - ${_model.dropDownValue ?? 0} seats, ${_model.parcelDropDownValue ?? 0} parcels',
                              context: context,
                            );

                            if (success) {
                              await _confirmBooking(ride, _model.dropDownValue ?? 0, _model.parcelDropDownValue ?? 0);
                              if (messenger.mounted) {
                                messenger.showSnackBar(const SnackBar(
                                  content: Text('Payment Successful! Once paid, your booking will be verified by the admin.'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 8),
                                ));
                              }
                            }
                          },
                          text: 'PayPal',
                          options: FFButtonOptions(
                            height: 50,
                            color: const Color(0xFF003087),
                            textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Card Payments Temporarily Under Maintenance. Please use PayPal or EFT.'),
                              backgroundColor: Colors.orange,
                            ));
                          },
                          text: 'Card',
                          options: FFButtonOptions(
                            height: 50,
                            color: FlutterFlowTheme.of(context).alternate,
                            textStyle: TextStyle(color: FlutterFlowTheme.of(context).primaryText, fontWeight: FontWeight.bold),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Card Payments Temporarily Under Maintenance',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(),
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: InkWell(
                      onTap: () => context.pushNamed('EftDetails'),
                      child: Text.rich(
                        TextSpan(
                          text: 'If any issues with PayPal account payments, press ',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.inter(),
                                color: FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                          children: [
                            TextSpan(
                              text: 'here',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: ' for temporary EFT payments.'),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const SizedBox(height: 12),
                  FFButtonWidget(
                    onPressed: () async {
                      if (_model.dropDownValue == null && _model.parcelDropDownValue == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select seats or parcels')));
                        return;
                      }
                      await _confirmBooking(ride, _model.dropDownValue ?? 0, _model.parcelDropDownValue ?? 0);
                    },
                    text: 'Submit Booking (No Payment) - Booking will be cancelled if proof of payment is not received in 30min',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 65,
                      color: FlutterFlowTheme.of(context).secondary,
                      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  const SizedBox(height: 20),

                  FFButtonWidget(
                    onPressed: () => launchUrl(Uri.parse('mailto:rideshare8855@gmail.com?subject=Proof of Payment Ride #${ride.id}')),
                    text: 'Send Proof of Payment',
                    icon: const Icon(Icons.email_outlined, size: 18),
                    options: FFButtonOptions(
                      height: 50,
                      color: FlutterFlowTheme.of(context).secondary,
                      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  const SizedBox(height: 30),
                  const Divider(),
                  
                  // Driver Info Section
                  FutureBuilder<UsersRow?>(
                    future: getUserByUid(ride.createdBy ?? ''),
                    builder: (context, snapshot) {
                      final driver = snapshot.data;
                      if (!snapshot.hasData) return const SizedBox.shrink();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Driver Details',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.inter(), fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('Name: ${driver?.firstName ?? 'N/A'}'),
                          Text('Rides Completed: ${driver?.ridesCompleted ?? '0'}'),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Full contact details will be visible in "My Bookings" once your booking is confirmed by the admin.',
                              style: TextStyle(
                                color: Color(0xFFFFCC80),
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  
                  const SizedBox(height: 30),
                  FFButtonWidget(
                    onPressed: () => context.safePop(),
                    text: 'Back',
                    options: FFButtonOptions(
                      height: 45,
                      color: FlutterFlowTheme.of(context).alternate,
                      textStyle: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value ?? 'N/A'),
        ],
      ),
    );
  }

  Future<void> _confirmBooking(RidesRow ride, int seats, int parcels) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      // 1. Subtract seats and parcels from DB and update booking info
      final newSeats = (ride.seatsAvailable ?? 0) - seats;
      final newParcels = (ride.numberOfParcels ?? 0) - parcels;
      
      final currentBooked = int.tryParse(ride.seatsBooked ?? '0') ?? 0;
      await RidesTable().update(
        data: {
          'seats_available': newSeats,
          'number_of_parcels': newParcels,
          'SeatsBooked': (currentBooked + seats).toString(),
          'BookedBy': currentUserUid,
          if (newSeats <= 0 && newParcels <= 0) 'RideStatus': 'Fully Booked',
        },
        matchingRows: (q) => q.eq('id', ride.id),
      );

      // 2. Create Pending Payment record
      await PendingPaymentsTable().insert({
        'ride_reference': ride.id,
        'user_reference': currentUserUid,
        'BookedBy': currentUserUid,
        'seats_requested': seats,
        // TODO: Ensure PendingPaymentsTable supports 'parcels_requested' if needed, 
        // for now we'll just track user intent.
        'status': 'Pending',
      });

      if (messenger.mounted) {
        messenger.showSnackBar(const SnackBar(
          content: Text('Booking submitted successfully! Admin will verify your payment soon.'),
          duration: Duration(seconds: 5),
        ));
      }
    } catch (e, stackTrace) {
      debugPrint('RIDE BOOKING ERROR: $e');
      debugPrint('STACKTRACE: $stackTrace');
      if (messenger.mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text('Error updating ride records: $e')),
        );
      }
    }
  }

  Color _getSeatColor(int seatsAvailable) {
    if (seatsAvailable >= 2) {
      return Colors.green;
    } else if (seatsAvailable == 1) {
      return const Color(0xFFFFCC80); // Lighter Orange
    } else {
      return Colors.grey;
    }
  }

  Color _getParcelColor(int parcelsAvailable) {
    if (parcelsAvailable >= 2) {
      return Colors.green;
    } else if (parcelsAvailable == 1) {
      return const Color(0xFFFFCC80); // Lighter Orange
    } else {
      return Colors.grey;
    }
  }
}
