import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/booked_rides_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/my_created_rides/my_created_rides_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mybooked_rides_model.dart';
export 'mybooked_rides_model.dart';

/// Create a new FlutterFlow page named 'MyBookedRides'.
///
/// The page should have a header titled 'My Booked Rides'. Below the header,
/// add a ListView that queries the 'PendingPayments' Supabase table.
/// Set a filter on this query where 'user_reference' is equal to the
/// 'Authenticated User Reference'. Inside each ListView row, add a column
/// that displays:
///
/// The ride details (using the Reference 'ride_reference' from the
/// query).
///
/// A Text widget displaying the 'status' field.
///
/// Conditional styling for the status text: set the color to orange if the
/// status is 'Pending' and green if the status is 'Confirmed'.
/// Ensure the design is clean, mobile-friendly, and uses a standard card
/// layout for each list item.
class MybookedRidesWidget extends StatefulWidget {
  const MybookedRidesWidget({super.key});

  static String routeName = 'MybookedRides';
  static String routePath = 'mybookedRides';

  @override
  State<MybookedRidesWidget> createState() => _MybookedRidesWidgetState();
}

class _MybookedRidesWidgetState extends State<MybookedRidesWidget> {
  late MybookedRidesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Stream for booked rides - created once in initState
  late final Stream<List<PendingPaymentsRow>> _bookedRidesStream;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MybookedRidesModel());
    
    // Create the stream once to ensure consistent data loading
    _bookedRidesStream = SupaFlow.client
        .from('PendingPayments')
        .stream(primaryKey: ['id'])
        .map((rows) => rows
            .map((r) => PendingPaymentsRow(r))
            .where((r) => r.bookedBy == currentUserUid)
            .toList());
    
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'MybookedRides',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          // Stay here or refresh
                                        },
                                        text: 'My Booked',
                                        options: FFButtonOptions(
                                          height: 36.0,
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          color: FlutterFlowTheme.of(context).primary,
                                          textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                            font: GoogleFonts.inter(),
                                            color: Colors.white,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          context.pushNamed(MyCreatedRidesWidget.routeName);
                                        },
                                        text: 'My Created',
                                        options: FFButtonOptions(
                                          height: 36.0,
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          color: FlutterFlowTheme.of(context).alternate,
                                          textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                                            font: GoogleFonts.inter(),
                                            color: FlutterFlowTheme.of(context).primaryText,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'My Booked Rides',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          font: GoogleFonts.interTight(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                  Text(
                                    'Manage your upcoming trips',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 4.0)),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: Colors.transparent,
                                icon: Icon(
                                  Icons.search_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        scrollbars: false,
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch,
                          PointerDeviceKind.stylus,
                          PointerDeviceKind.unknown,
                        },
                      ),
                      child: Scrollbar(
child: SingleChildScrollView(
                           primary: false,
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.stretch,
                             children: [
                               Padding(
                                 padding: EdgeInsets.all(24.0),
                                 child: Container(
                                   child:
                                       StreamBuilder<List<PendingPaymentsRow>>(
                                     stream: _bookedRidesStream,
                                     builder: (context, snapshot) {
                                       // Customize what your widget looks like when it's loading.
                                       if (!snapshot.hasData) {
                                         return Center(
                                           child: SizedBox(
                                             width: 50.0,
                                             height: 50.0,
                                             child: CircularProgressIndicator(
                                               valueColor:
                                                   AlwaysStoppedAnimation<Color>(
                                                 FlutterFlowTheme.of(context)
                                                     .primary,
                                               ),
                                             ),
                                           ),
                                         );
                                       }
                                      List<PendingPaymentsRow>
                                          listViewPendingPaymentsRowList =
                                          snapshot.data!;

                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            listViewPendingPaymentsRowList
                                                .length,
                                        itemBuilder: (context, listViewIndex) {
                                          final listViewPendingPaymentsRow =
                                              listViewPendingPaymentsRowList[
                                                  listViewIndex];
                                          return BookedRidesCardWidget(
                                            key: Key(
                                                'Keywz9_${listViewIndex}_of_${listViewPendingPaymentsRowList.length}'),
                                            status: listViewPendingPaymentsRow
                                                    .status ??
                                                'Pending',
                                            rideReference:
                                                listViewPendingPaymentsRow
                                                    .rideReference,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    shape: BoxShape.rectangle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Container(
                      child: SizedBox(
                        width: 0.0,
                        height: 0.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
