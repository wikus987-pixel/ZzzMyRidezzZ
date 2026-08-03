import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
import 'package:ride_share_supa/flutter_flow/custom_functions.dart' as functions;
import 'package:ride_share_supa/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'available_rides_screen_model.dart';
export 'available_rides_screen_model.dart';

class AvailableRidesScreenWidget extends StatefulWidget {
  const AvailableRidesScreenWidget({
    super.key,
    this.selectedRideId,
  });

  final int? selectedRideId;

  static String routeName = 'available_Rides_Screen';
  static String routePath = 'available_Rides_Screen';

  @override
  State<AvailableRidesScreenWidget> createState() =>
      _AvailableRidesScreenWidgetState();
}

class _AvailableRidesScreenWidgetState
    extends State<AvailableRidesScreenWidget> {
  late AvailableRidesScreenModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  String _searchTerm = '';
  final _searchController = TextEditingController();
  String? _userCurrentCity;
  
  Stream<List<RidesRow>>? _ridesStream;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AvailableRidesScreenModel());
    _initializeStream();
    _determinePosition();
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      
      if (permission == LocationPermission.deniedForever) return;

      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      
      if (placemarks.isNotEmpty) {
        if (mounted) {
          setState(() {
            _userCurrentCity = placemarks.first.locality?.toLowerCase();
          });
        }
      }
    } catch (e) {
      debugPrint('Location Error: $e');
    }
  }

  void _initializeStream() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        _ridesStream = SupaFlow.client
            .from('rides')
            .stream(primaryKey: ['id'])
            .order('id', ascending: false) // Latest created first by default
            .map((rows) => rows
                .map((r) => RidesRow(r))
                .where((r) => (r.rideStatus ?? '').toLowerCase() != 'completed')
                .toList());
      });
    });
  }

  @override
  void dispose() {
    _model.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Available Rides',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            title: Text(
              'Available Rides',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                onPressed: () => setState(() {}),
              ),
            ],
            centerTitle: true,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (val) => setState(() => _searchTerm = val.toLowerCase()),
                    decoration: InputDecoration(
                      hintText: 'Search by town...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchTerm.isNotEmpty ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchTerm = '');
                        },
                      ) : null,
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<RidesRow>>(
                    stream: _ridesStream ?? const Stream.empty(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Connection lost',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(),
                                  color: FlutterFlowTheme.of(context).error,
                                ),
                              ),
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
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      // Sort and filter rides
                      final rides = (snapshot.data ?? []).where((r) {
                        final matchSearch = _searchTerm.isEmpty || 
                          (r.departureLocation?.toLowerCase().contains(_searchTerm) ?? false) ||
                          (r.arrivalLocation?.toLowerCase().contains(_searchTerm) ?? false);
                        return matchSearch;
                      }).toList();

                      // Custom Sorting:
                      // 1. Departure Location matching user's LIVE current city first
                      // 2. Latest ID (Latest Created) first
                      rides.sort((a, b) {
                        // Rule 1: Current City match
                        if (_userCurrentCity != null) {
                          final aMatch = a.departureLocation?.toLowerCase() == _userCurrentCity;
                          final bMatch = b.departureLocation?.toLowerCase() == _userCurrentCity;
                          if (aMatch != bMatch) {
                            return aMatch ? -1 : 1;
                          }
                        }

                        // Rule 2: Latest ID (Newest created rides)
                        return b.id.compareTo(a.id);
                      });

                      if (rides.isEmpty) {
                        return Center(
                          child: Text(
                            'No rides available yet.',
                            style: FlutterFlowTheme.of(context).bodyLarge,
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: rides.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12.0),
                        itemBuilder: (context, index) {
                          final ride = rides[index];
                          return _RideListCard(
                            ride: ride,
                            onTap: () {
                              context.pushNamed(
                                RideDetailsScreenWidget.routeName,
                                extra: <String, dynamic>{
                                  'selectedRide': ride,
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.safePop();
                    },
                    text: 'Back',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color rideStatusColor(BuildContext context, RidesRow ride) {
  if ((ride.rideStatus ?? '').toLowerCase() == 'completed') {
    return Colors.purple;
  }
  final seats = ride.seatsAvailable ?? 0;
  if (seats >= 2) {
    return FlutterFlowTheme.of(context).success; // Green
  }
  if (seats == 1) {
    return const Color(0xFFFFCC80); // Lighter Orange
  }
  return FlutterFlowTheme.of(context).error; // 0 seats
}

String rideStatusText(RidesRow ride) {
  if ((ride.rideStatus ?? '').toLowerCase() == 'completed') {
    return 'Completed';
  }
  final seats = ride.seatsAvailable ?? 0;
  if (seats <= 0) {
    return 'Full';
  }
  return '$seats Seats';
}

class _RideListCard extends StatelessWidget {
  const _RideListCard({
    required this.ride,
    required this.onTap,
  });

  final RidesRow ride;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              ride.departureLocation,
                              'Departure Town',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.interTight(),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                          ),
                          Text(
                            'Pickup: ${valueOrDefault<String>(ride.pickup, 'TBA')}',
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                  font: GoogleFonts.inter(),
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            dateTimeFormat(
                              'd MMMM y - HH:mm',
                              ride.departureTime,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  font: GoogleFonts.inter(),
                                  color:
                                      FlutterFlowTheme.of(context).warning,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.east_rounded,
                      color: FlutterFlowTheme.of(context).secondary,
                      size: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              ride.arrivalLocation,
                              'Arrival Town',
                            ),
                            textAlign: TextAlign.end,
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.interTight(),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                          ),
                          Text(
                            'Drop-off: ${valueOrDefault<String>(ride.dropoff, 'TBA')}',
                            textAlign: TextAlign.end,
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                  font: GoogleFonts.inter(),
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  fontSize: 10,
                                ),
                          ),
                          Text(
                            dateTimeFormat(
                              'd MMMM y - HH:mm',
                              ride.arrivalTime,
                            ),
                            textAlign: TextAlign.end,
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  font: GoogleFonts.inter(),
                                  color:
                                      FlutterFlowTheme.of(context).warning,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'R${functions.addMarkup(ride.pricePerSeat ?? 0.0, 1)} / seat',
                            style: FlutterFlowTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          if (ride.pricePerParcel != null && (ride.numberOfParcels ?? 0) > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'R${functions.addParcelMarkup(ride.pricePerParcel ?? 0.0, 1)} / parcel',
                                style: FlutterFlowTheme.of(context).titleSmall.override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      color: FlutterFlowTheme.of(context).secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              height: 32.0,
                              decoration: BoxDecoration(
                                color: rideStatusColor(context, ride),
                                borderRadius: BorderRadius.circular(9999.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                rideStatusText(ride),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                              ),
                            ),
                            if (ride.numberOfParcels != null && (ride.numberOfParcels ?? 0) > 0) ...[
                               const SizedBox(width: 4),
                               Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                height: 32.0,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(9999.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${ride.numberOfParcels} Parcels',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: onTap,
                          child: Icon(
                            Icons.arrow_forward,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}