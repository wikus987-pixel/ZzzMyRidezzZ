import 'package:ride_share_supa/auth/supabase_auth/auth_util.dart';
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/components/booked_rides_card_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_icon_button.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'my_created_rides_model.dart';
export 'my_created_rides_model.dart';

class MyCreatedRidesWidget extends StatefulWidget {
  const MyCreatedRidesWidget({
    super.key,
    this.initialTab,
  });

  final int? initialTab;

  static String routeName = 'MyCreatedRides';
  static String routePath = 'myCreatedRides';

  @override
  State<MyCreatedRidesWidget> createState() => _MyCreatedRidesWidgetState();
}

class _MyCreatedRidesWidgetState extends State<MyCreatedRidesWidget> {
  late MyCreatedRidesModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late int _activeTab;

  // Optimized streams to ensure initial data loading
  Stream<List<RidesRow>>? _myActiveRidesStream;
  Stream<List<PendingPaymentsRow>>? _myBookingsStream;
  Stream<List<RidesRow>>? _myHistoryStream;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyCreatedRidesModel());
    _activeTab = widget.initialTab ?? 0;

    _initializeStreams();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _initializeStreams() {
    if (currentUserUid.isNotEmpty) {
      // 1. My Created Rides (Active)
      Future.delayed(const Duration(milliseconds: 200), () {
        if (!mounted) return;
        setState(() {
          _myActiveRidesStream = SupaFlow.client
              .from('rides')
              .stream(primaryKey: ['id'])
              .eq('CreatedBy', currentUserUid)
              .order('departure_time', ascending: false)
              .map((data) => data
                  .map((row) => RidesRow(row))
                  .where((r) => r.rideStatus != 'Paid')
                  .toList());
        });
      });

      // 2. My Bookings (Rides I paid for) - Only show confirmed/booked ones
      Future.delayed(const Duration(milliseconds: 400), () {
        if (!mounted) return;
        setState(() {
          _myBookingsStream = SupaFlow.client
              .from('PendingPayments')
              .stream(primaryKey: ['id'])
              .eq('BookedBy', currentUserUid)
              .order('id', ascending: false)
              .map((data) => data
                  .map((row) => PendingPaymentsRow(row))
                  .where((p) => p.status == 'Booked' || p.status == 'Confirmed')
                  .toList());
        });
      });

      // 3. My History (Completed Created Rides)
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        setState(() {
          _myHistoryStream = SupaFlow.client
              .from('rides')
              .stream(primaryKey: ['id'])
              .eq('CreatedBy', currentUserUid)
              .order('departure_time', ascending: false)
              .map((data) => data
                  .map((row) => RidesRow(row))
                  .where((r) => r.rideStatus == 'Paid')
                  .toList());
        });
      });
    } else {
      _myActiveRidesStream = Stream.value([]);
      _myBookingsStream = Stream.value([]);
      _myHistoryStream = Stream.value([]);
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Color _getSeatsColor(int? seats) {
    if (seats == null || seats <= 0) return Colors.red;
    if (seats == 1) return const Color(0xFFFFCC80); // Lighter Orange
    return Colors.green;
  }

  String _getSeatsText(int? seats) {
    if (seats == null || seats <= 0) return 'Full';
    return '$seats Seats';
  }

  Future<void> _completeRide(RidesRow ride) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Complete Ride'),
        content: const Text('Are you sure you want to mark this ride as completed?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Complete')),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await RidesTable().update(
        data: {'RideStatus': 'Completed'},
        matchingRows: (q) => q.eq('id', ride.id),
      );

      final userRows = await UsersTable().queryRows(queryFn: (q) => q.eq('uid', currentUserUid));
      if (userRows.isNotEmpty) {
        final user = userRows.first;
        final currentCount = int.tryParse(user.ridesCompleted ?? '0') ?? 0;
        await UsersTable().update(
          data: {'RidesCompleted': (currentCount + 1).toString()},
          matchingRows: (q) => q.eq('uid', currentUserUid),
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ride completed successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error completing ride: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserUid.isEmpty) {
      return const Scaffold(body: Center(child: Text('Please log in again')));
    }

    return Title(
      title: 'My Profile',
      color: FlutterFlowTheme.of(context).primary,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 8.0,
            buttonSize: 40.0,
            fillColor: Colors.transparent,
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 24.0),
            onPressed: () => context.safePop(),
          ),
          title: Text(
            'My Profile',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
              child: FFButtonWidget(
                onPressed: () => context.pushNamed('EditProfilePage'),
                text: 'Edit',
                icon: const Icon(Icons.edit_rounded, size: 15),
                options: FFButtonOptions(
                  width: 80,
                  height: 36,
                  color: Colors.white24,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildProfileHeader(),
              _buildTabs(),
              Expanded(
                child: _buildListContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListContent() {
    if (_activeTab == 0) {
      return StreamBuilder<List<RidesRow>>(
        stream: _myActiveRidesStream ?? const Stream.empty(),
        builder: (context, snapshot) => _handleStreamResult(snapshot, (rides) => _buildRideList(rides, true)),
      );
    } else if (_activeTab == 1) {
      return StreamBuilder<List<PendingPaymentsRow>>(
        stream: _myBookingsStream ?? const Stream.empty(),
        builder: (context, snapshot) => _handleStreamResult(snapshot, (bookings) => _buildBookingsList(bookings)),
      );
    } else {
      return StreamBuilder<List<RidesRow>>(
        stream: _myHistoryStream ?? const Stream.empty(),
        builder: (context, snapshot) => _handleStreamResult(snapshot, (rides) => _buildRideList(rides, false)),
      );
    }
  }

  Widget _handleStreamResult<T>(AsyncSnapshot<List<T>> snapshot, Widget Function(List<T>) builder) {
    if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Connection lost', style: TextStyle(color: FlutterFlowTheme.of(context).error)),
            const SizedBox(height: 12),
            FFButtonWidget(
              onPressed: () => _initializeStreams(),
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
    final data = snapshot.data ?? [];
    if (data.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'No items found here.',
            style: FlutterFlowTheme.of(context).labelMedium,
          ),
        ),
      );
    }
    return builder(data);
  }

  Widget _buildRideList(List<RidesRow> rides, bool canComplete) {
    return ListView.builder(
      itemCount: rides.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final ride = rides[index];
        return _buildRideCard(ride, canComplete: canComplete);
      },
    );
  }

  Widget _buildBookingsList(List<PendingPaymentsRow> bookings) {
    return ListView.builder(
      itemCount: bookings.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return BookedRidesCardWidget(
          rideReference: booking.rideReference,
          seatsbooked: booking.seatsRequested,
          status: booking.status ?? 'Pending',
        );
      },
    );
  }

  Widget _buildProfileHeader() {
    return FutureBuilder<List<UsersRow>>(
      future: UsersTable().queryRows(queryFn: (q) => q.eq('uid', currentUserUid).limit(1)),
      builder: (context, snapshot) {
        final user = (snapshot.data ?? []).isNotEmpty ? snapshot.data!.first : null;
        final name = user != null ? '${user.firstName ?? ""} ${user.surname ?? ""}'.trim() : "";

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 24),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.person_rounded, color: Colors.white, size: 40),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.isNotEmpty ? name : currentUserEmail,
                        style: FlutterFlowTheme.of(context).titleMedium.override(
                              font: GoogleFonts.inter(),
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Welcome back!',
                        style: FlutterFlowTheme.of(context).labelMedium.override(
                              font: GoogleFonts.inter(),
                              color: Colors.white70,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).alternate,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _tabButton('My Created', 0),
            _tabButton('My Bookings', 1),
            _tabButton('History', 2),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String label, int index) {
    final isSelected = _activeTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _activeTab = index),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: Colors.black.withAlpha(13),
                        blurRadius: 4,
                        offset: const Offset(0, 2))
                  ]
                : null,
          ),
          margin: const EdgeInsets.all(4),
          alignment: Alignment.center,
          child: Text(
            label,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(),
                  color: isSelected
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).secondaryText,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildRideCard(RidesRow ride, {bool canComplete = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _locationRow(Icons.radio_button_checked_rounded,
                          ride.departureLocation ?? "Unknown", Colors.blue),
                      const Padding(
                        padding: EdgeInsets.only(left: 11),
                        child: SizedBox(height: 20, child: VerticalDivider(width: 1, thickness: 1)),
                      ),
                      _locationRow(Icons.location_on_rounded,
                          ride.arrivalLocation ?? "Unknown", Colors.red),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'R${ride.pricePerSeat ?? "0"}',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.inter(),
                            color: FlutterFlowTheme.of(context).primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text('per seat', style: FlutterFlowTheme.of(context).labelSmall),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: FlutterFlowTheme.of(context).alternate),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateTimeFormat("d MMM, HH:mm", ride.departureTime),
                      style: FlutterFlowTheme.of(context).bodySmall,
                    ),
                    Row(
                      children: [
                        Text(
                          _getSeatsText(ride.seatsAvailable),
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(),
                            color: _getSeatsColor(ride.seatsAvailable),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          ride.seatsAvailable != null && ride.seatsAvailable! > 0 ? 'Available' : 'Full',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(),
                            color: _getSeatsColor(ride.seatsAvailable),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (canComplete && ride.rideStatus != 'Completed')
                  FFButtonWidget(
                    onPressed: () => _completeRide(ride),
                    text: 'Complete',
                    options: FFButtonOptions(
                      width: 90,
                      height: 32,
                      color: FlutterFlowTheme.of(context).success,
                      textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )
                else if (ride.rideStatus == 'Completed')
                  _statusBadge('Completed', Colors.purple)
                else
                  _statusBadge(ride.rideStatus ?? 'Active', Colors.blue),
              ],
            ),
          ),
          if (canComplete) _buildPassengerList(ride.id),
        ],
      ),
    );
  }

  Widget _buildPassengerList(int rideId) {
    return StreamBuilder<List<PendingPaymentsRow>>(
      stream: SupaFlow.client
          .from('PendingPayments')
          .stream(primaryKey: ['id'])
          .eq('ride_reference', rideId)
          .map((data) => data
              .map((row) => PendingPaymentsRow(row))
              .where((p) => p.status == 'Booked' || p.status == 'Confirmed' || p.status == 'Pending')
              .toList()),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }
        final bookings = snapshot.data!;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booked Passengers',
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      font: GoogleFonts.inter(),
                      fontWeight: FontWeight.bold,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
              ),
              const SizedBox(height: 8),
              ...bookings.map((booking) => _passengerListItem(booking)),
            ],
          ),
        );
      },
    );
  }

  Widget _passengerListItem(PendingPaymentsRow booking) {
    return FutureBuilder<UsersRow?>(
      future: getUserByUid(booking.bookedBy ?? ''),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${user.firstName ?? ""} ${user.surname ?? ""}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${booking.seatsRequested ?? 0} Seats',
                      style: FlutterFlowTheme.of(context).bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Phone: ${user.cellNumber ?? "N/A"}', style: const TextStyle(fontSize: 12)),
                Text('Email: ${user.email ?? "N/A"}', style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () => _launchEmail(user.email, booking.rideReference),
                        text: 'Email',
                        icon: const Icon(Icons.email_outlined, size: 14),
                        options: FFButtonOptions(
                          height: 28,
                          color: FlutterFlowTheme.of(context).alternate,
                          textStyle: TextStyle(color: FlutterFlowTheme.of(context).primaryText, fontSize: 11),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () => _launchWhatsApp(user.cellNumber),
                        text: 'WhatsApp',
                        icon: const Icon(Icons.chat_bubble_outline, size: 14),
                        options: FFButtonOptions(
                          height: 28,
                          color: const Color(0xFF249689),
                          textStyle: const TextStyle(color: Colors.white, fontSize: 11),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchWhatsApp(String? phone) async {
    if (phone == null || phone.isEmpty) return;
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final url = 'https://wa.me/$cleanPhone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchEmail(String? email, int? rideId) async {
    if (email == null || email.isEmpty) return;
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'RideShare Booking - Ride #$rideId'},
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  Widget _statusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: FlutterFlowTheme.of(context).bodySmall.override(
              font: GoogleFonts.inter(),
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _locationRow(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(icon, size: 22, color: iconColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  font: GoogleFonts.inter(),
                  fontWeight: FontWeight.w500,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
