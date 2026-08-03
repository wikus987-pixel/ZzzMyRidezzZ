import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_icon_button.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ride_requests_model.dart';
export 'ride_requests_model.dart';

class RideRequestsWidget extends StatefulWidget {
  const RideRequestsWidget({super.key});

  static String routeName = 'RideRequests';
  static String routePath = 'rideRequests';

  @override
  State<RideRequestsWidget> createState() => _RideRequestsWidgetState();
}

class _RideRequestsWidgetState extends State<RideRequestsWidget> {
  late RideRequestsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<List<ReqRidesRow>>? _requestsStream;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RideRequestsModel());

    _initializeStream();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _initializeStream() {
    Future.delayed(const Duration(milliseconds: 500), () {
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
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'RideRequests',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              ScrollConfiguration(
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
                                padding: const EdgeInsets.all(24.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ride Requests',
                                      style: FlutterFlowTheme.of(context).titleLarge.override(
                                            font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 8.0,
                                      buttonSize: 40.0,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.sort_rounded,
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        size: 24.0,
                                      ),
                                      onPressed: () {
                                        debugPrint('IconButton pressed ...');
                                      },
                                    ),
                                  ],
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
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: StreamBuilder<List<ReqRidesRow>>(
                            stream: _requestsStream ?? const Stream.empty(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
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
                                );
                              }
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
                              List<ReqRidesRow> listViewReqRidesRowList = snapshot.data!;

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: listViewReqRidesRowList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewReqRidesRow = listViewReqRidesRowList[listViewIndex];
                                  return FutureBuilder<List<UsersRow>>(
                                    future: UsersTable().querySingleRow(
                                      queryFn: (q) => q.eq('uid', listViewReqRidesRow.requestedBy ?? ''),
                                    ),
                                    builder: (context, snapshot) {
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
                                      List<UsersRow> columnUsersRowList = snapshot.data!;
                                      final columnUsersRow = columnUsersRowList.isNotEmpty ? columnUsersRowList.first : null;

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          if (columnUsersRow != null)
                                            Text('${columnUsersRow.firstName} ${columnUsersRow.surname}'),
                                        ].divide(const SizedBox(height: 16.0)),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
