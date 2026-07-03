import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pay_now_fixed_amount_model.dart';
export 'pay_now_fixed_amount_model.dart';

/// Registration
class PayNowFixedAmountWidget extends StatefulWidget {
  const PayNowFixedAmountWidget({
    super.key,
    this.parameter1,
    this.parameter2,
    this.parameter3,
    this.parameter4,
  });

  final double? parameter1;
  final int? parameter2;
  final String? parameter3;
  final String? parameter4;

  @override
  State<PayNowFixedAmountWidget> createState() =>
      _PayNowFixedAmountWidgetState();
}

class _PayNowFixedAmountWidgetState extends State<PayNowFixedAmountWidget> {
  late PayNowFixedAmountModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PayNowFixedAmountModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
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
          List<PendingPaymentsRow> buttonPendingPaymentsRowList =
              snapshot.data!;

          final buttonPendingPaymentsRow =
              buttonPendingPaymentsRowList.isNotEmpty
                  ? buttonPendingPaymentsRowList.first
                  : null;

          return FFButtonWidget(
            onPressed: () async {
              await PendingPaymentsTable().insert({
                'id': buttonPendingPaymentsRow?.id,
                'ride_reference': buttonPendingPaymentsRow?.rideReference,
                'user_reference': buttonPendingPaymentsRow?.userReference,
                'status': buttonPendingPaymentsRow?.status,
                'seats_requested': buttonPendingPaymentsRow?.seatsRequested,
                'BookedBy': buttonPendingPaymentsRow?.bookedBy,
              });
              await launchURL(
                  'https://paypal.me/WikusKriel85/${functions.getPayPalAmountInDollar(widget!.parameter1, widget!.parameter2?.toString())}');
            },
            text: 'Pay Now',
            options: FFButtonOptions(
              height: 40.0,
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              color: FlutterFlowTheme.of(context).primary,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    font: GoogleFonts.interTight(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                    color: Colors.white,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  ),
              elevation: 0.0,
              borderRadius: BorderRadius.circular(8.0),
            ),
          );
        },
      ),
    );
  }
}
