import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'approval_item_model.dart';
export 'approval_item_model.dart';

class ApprovalItemWidget extends StatefulWidget {
  const ApprovalItemWidget({
    super.key,
    String? email,
    String? date,
    bool? isVerified,
  })  : email = email ?? 'marcus.v@example.com',
        date = date ?? '2 mins ago',
        isVerified = isVerified ?? false;

  final String email;
  final String date;
  final bool isVerified;

  @override
  State<ApprovalItemWidget> createState() => _ApprovalItemWidgetState();
}

class _ApprovalItemWidgetState extends State<ApprovalItemWidget> {
  late ApprovalItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApprovalItemModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UsersRow>>(
      future: UsersTable().queryRows(
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
        // ignore: unused_local_variable
        List<UsersRow> containerUsersRowList = snapshot.data!;

        return Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(16.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder<List<PendingPaymentsRow>>(
              future: PendingPaymentsTable().querySingleRow(
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
                List<PendingPaymentsRow>
                    containerPaddingPendingPaymentsRowList = snapshot.data!;

                // ignore: unused_local_variable
                final containerPaddingPendingPaymentsRow =
                    containerPaddingPendingPaymentsRowList.isNotEmpty
                        ? containerPaddingPendingPaymentsRowList.first
                        : null;

                return FutureBuilder<List<UsersRow>>(
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

                    // ignore: unused_local_variable
                    final rowUsersRow = rowUsersRowList.isNotEmpty
                        ? rowUsersRowList.first
                        : null;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(9999.0),
                            shape: BoxShape.rectangle,
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Icon(
                            Icons.person_outline_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FutureBuilder<List<UsersRow>>(
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
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              List<UsersRow> columnUsersRowList =
                                  snapshot.data!;

                              // ignore: unused_local_variable
                              final columnUsersRow =
                                  columnUsersRowList.isNotEmpty
                                      ? columnUsersRowList.first
                                      : null;

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    valueOrDefault<String>(
                                      widget.email,
                                      'marcus.v@example.com',
                                    ),
                                    maxLines: 1,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    valueOrDefault<String>(
                                      'Requested ${widget.date}',
                                      'Requested 2 mins ago',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 4.0)),
                              );
                            },
                          ),
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
