import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/backend/supabase/supabase_queries.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'booked_rides_card_model.dart';
export 'booked_rides_card_model.dart';

class BookedRidesCardWidget extends StatefulWidget {
  const BookedRidesCardWidget({
    super.key,
    String? destination,
    String? vehicle,
    String? status,
    this.seatsbooked,
    this.rideReference,
  })  : this.destination =
            destination ?? 'Downtown Office → Airport Terminal 2',
        this.vehicle = vehicle ?? 'Toyota Camry (Silver)',
        this.status = status ?? 'Confirmed';

  final String destination;
  final String vehicle;
  final String status;
  final int? seatsbooked;
  final int? rideReference;

  @override
  State<BookedRidesCardWidget> createState() => _BookedRidesCardWidgetState();
}

class _BookedRidesCardWidgetState extends State<BookedRidesCardWidget> {
  late BookedRidesCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(24.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Container(
              child: FutureBuilder<List<PendingPaymentsRow>>(
                future: PendingPaymentsTable().querySingleRow(
                  queryFn: (q) => q.eqOrNull(
                    'BookedBy',
                    currentUserUid,
                  ),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<PendingPaymentsRow> columnPendingPaymentsRowList =
                      snapshot.data!;

                  final columnPendingPaymentsRow =
                      columnPendingPaymentsRowList.isNotEmpty
                          ? columnPendingPaymentsRowList.first
                          : null;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: FutureBuilder<RidesRow?>(
                              future: widget.rideReference != null
                                  ? getRideById(widget.rideReference!)
                                  : Future.value(null),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final columnRidesRow = snapshot.data;

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Arrival Location:${widget!.destination}',
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                            lineHeight: 1.4,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Departure Time:${dateTimeFormat("d MMMM y - HH:mm", columnRidesRow?.departureTime)}',
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
                                    Text(
                                      'Seats Booked:${columnRidesRow?.seatsBooked}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(height: 4.0)),
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9999.0),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 4.0, 16.0, 4.0),
                              child: Container(
                              child: FutureBuilder<RidesRow?>(
                                future: widget.rideReference != null
                                    ? getRideById(widget.rideReference!)
                                    : Future.value(null),
                                builder: (context, snapshot) {
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
                                  final textRidesRow = snapshot.data;

                                  return Text(
                                    'R${functions.getPayPalAmount(textRidesRow?.pricePerSeat, textRidesRow?.seatsBooked)}',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                            lineHeight: 1.4,
                                          ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 16.0,
                        thickness: 1.0,
                        indent: 0.0,
                        endIndent: 0.0,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder<List<UsersRow>>(
                            future: UsersTable().querySingleRow(
                              queryFn: (q) => q,
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              List<UsersRow> rowUsersRowList = snapshot.data!;

                              final rowUsersRow = rowUsersRowList.isNotEmpty
                                  ? rowUsersRowList.first
                                  : null;

                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.directions_car_filled_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 18.0,
                                  ),
                                  Text(
                                    valueOrDefault<String>(
                                      widget!.vehicle,
                                      'Vehicle Registration',
                                    ),
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
                                ].divide(SizedBox(width: 8.0)),
                              );
                            },
                          ),
                          FutureBuilder<List<PendingPaymentsRow>>(
                            future: PendingPaymentsTable().querySingleRow(
                              queryFn: (q) => q.eqOrNull(
                                'BookedBy',
                                currentUserUid,
                              ),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              List<PendingPaymentsRow>
                                  containerPendingPaymentsRowList =
                                  snapshot.data!;

                              final containerPendingPaymentsRow =
                                  containerPendingPaymentsRowList.isNotEmpty
                                      ? containerPendingPaymentsRowList.first
                                      : null;

                              return Container(
                                decoration: BoxDecoration(
                                  color: valueOrDefault<Color>(
                                    valueOrDefault<String>(
                                              widget!.status,
                                              'Confirmed',
                                            ) ==
                                            'Pending'
                                        ? Color(0x00000000)
                                        : Color(0x1A249689),
                                    Color(0x1A249689),
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 8.0, 16.0, 8.0),
                                  child: Container(
                                    child:
                                        FutureBuilder<List<PendingPaymentsRow>>(
                                      future: PendingPaymentsTable().queryRows(
                                        queryFn: (q) => q,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<PendingPaymentsRow>
                                            rowPendingPaymentsRowList =
                                            snapshot.data!;

                                        return Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: List.generate(
                                              rowPendingPaymentsRowList.length,
                                              (rowIndex) {
                                            final rowPendingPaymentsRow =
                                                rowPendingPaymentsRowList[
                                                    rowIndex];
                                            return Container(
                                              width: 14.0,
                                              height: 14.0,
                                              child: Stack(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                children: [
                                                  if (valueOrDefault<bool>(
                                                    valueOrDefault<String>(
                                                              widget!.status,
                                                              'Confirmed',
                                                            ) ==
                                                            'Pending'
                                                        ? true
                                                        : false,
                                                    false,
                                                  ))
                                                    Icon(
                                                      Icons.schedule_rounded,
                                                      color:
                                                          valueOrDefault<Color>(
                                                        valueOrDefault<String>(
                                                                  widget!
                                                                      .status,
                                                                  'Confirmed',
                                                                ) ==
                                                                'Pending'
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .warning
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .success,
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .success,
                                                      ),
                                                      size: 14.0,
                                                    ),
                                                  if (valueOrDefault<bool>(
                                                    valueOrDefault<String>(
                                                              widget!.status,
                                                              'Confirmed',
                                                            ) ==
                                                            'Pending'
                                                        ? false
                                                        : true,
                                                    true,
                                                  ))
                                                    Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      color:
                                                          valueOrDefault<Color>(
                                                        valueOrDefault<String>(
                                                                  widget!
                                                                      .status,
                                                                  'Confirmed',
                                                                ) ==
                                                                'Pending'
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .warning
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .success,
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .success,
                                                      ),
                                                      size: 14.0,
                                                    ),
                                                ],
                                              ),
                                            );
                                          }).divide(SizedBox(width: 4.0)),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ].divide(SizedBox(height: 16.0)),
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
