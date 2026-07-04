import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/personal_info_section_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'my_created_rides_model.dart';
export 'my_created_rides_model.dart';

class MyCreatedRidesWidget extends StatefulWidget {
  const MyCreatedRidesWidget({super.key});

  static String routeName = 'MyCreatedRides';
  static String routePath = 'myCreatedRides';

  @override
  State<MyCreatedRidesWidget> createState() => _MyCreatedRidesWidgetState();
}

class _MyCreatedRidesWidgetState extends State<MyCreatedRidesWidget> {
  late MyCreatedRidesModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Tab control: 0 for Info, 1 for Rides
  int _activeTab = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyCreatedRidesModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
    if (currentUserUid == null || currentUserUid!.isEmpty) {
      return const Scaffold(body: Center(child: Text('Please log in again')));
    }
    return Title(
      title: 'My Profile',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
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
          centerTitle: true,
          elevation: 2.0,
          actions: [
            FlutterFlowIconButton(
              borderRadius: 8.0,
              buttonSize: 48.0,
              fillColor: Colors.transparent,
              icon: const Icon(Icons.edit_note_rounded, color: Colors.white, size: 28.0),
              onPressed: () => context.pushNamed(EditProfilePageWidget.routeName),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromSTEB(16, 24, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () => setState(() => _activeTab = 0),
                        text: 'My Info',
                        options: FFButtonOptions(
                          height: 44.0,
                          color: _activeTab == 0 ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            font: GoogleFonts.inter(),
                            color: _activeTab == 0 ? Colors.white : FlutterFlowTheme.of(context).primaryText,
                            fontSize: 14,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () => setState(() => _activeTab = 1),
                        text: 'Manage Rides',
                        options: FFButtonOptions(
                          height: 44.0,
                          color: _activeTab == 1 ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            font: GoogleFonts.inter(),
                            color: _activeTab == 1 ? Colors.white : FlutterFlowTheme.of(context).primaryText,
                            fontSize: 14,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _activeTab == 0 ? _buildInfoTab() : _buildRidesTab(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: const PersonalInfoSectionWidget(),
    );
  }

  Widget _buildRidesTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FFButtonWidget(
                onPressed: () => context.pushNamed(MybookedRidesWidget.routeName),
                text: 'My Booked',
                options: FFButtonOptions(
                  height: 32.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).bodySmall,
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                ),
              ),
              const SizedBox(width: 8),
              FFButtonWidget(
                onPressed: () {},
                text: 'My Created',
                options: FFButtonOptions(
                  height: 32.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: FlutterFlowTheme.of(context).accent1,
                  textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.inter(),
                        color: FlutterFlowTheme.of(context).primary,
                        fontWeight: FontWeight.bold,
                      ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<List<RidesRow>>(
            stream: SupaFlow.client
                .from('rides')
                .stream(primaryKey: ['id'])
                .eq('CreatedBy', currentUserUid)
                .order('departure_time', ascending: false)
                .map((rows) => rows.map((r) => RidesRow(r)).toList()),
            builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading rides'));
            }
            if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final rides = snapshot.data ?? [];
              if (rides.isEmpty) {
                return const Center(child: Text('You haven\'t created any rides yet.'));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: rides.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final ride = rides[index];
                  final isCompleted = ride.rideStatus?.toLowerCase() == 'completed';
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primary,
                            FlutterFlowTheme.of(context).secondary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(ride.departureLocation ?? 'Unknown',
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    Text(dateTimeFormat('d MMM, HH:mm', ride.departureTime),
                                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward, color: Colors.white70),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(ride.arrivalLocation ?? 'Unknown',
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    Text(dateTimeFormat('d MMM, HH:mm', ride.arrivalTime),
                                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.white24, height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Seats: ${ride.seatsAvailable}', style: const TextStyle(color: Colors.white)),
                              if (!isCompleted)
                                FFButtonWidget(
                                  onPressed: () => _completeRide(ride),
                                  text: 'Complete Ride',
                                  options: FFButtonOptions(
                                    height: 32,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    color: Colors.purple,
                                    textStyle: const TextStyle(color: Colors.white, fontSize: 12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                )
                              else
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('COMPLETED', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
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
        ),
      ],
    );
  }
}
