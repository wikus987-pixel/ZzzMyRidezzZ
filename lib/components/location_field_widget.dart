import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'location_field_model.dart';
export 'location_field_model.dart';

class LocationFieldWidget extends StatefulWidget {
  const LocationFieldWidget({
    super.key,
    this.icon,
    String? label,
    String? hint,
  })  : label = label ?? 'Departure Location',
        hint = hint ?? 'Enter pickup point';

  final Widget? icon;
  final String label;
  final String hint;

  @override
  State<LocationFieldWidget> createState() => _LocationFieldWidgetState();
}

class _LocationFieldWidgetState extends State<LocationFieldWidget> {
  late LocationFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LocationFieldModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<ReqRidesRow>>(
          future: ReqRidesTable().querySingleRow(
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
            List<ReqRidesRow> rowReqRidesRowList = snapshot.data!;

            final rowReqRidesRow = rowReqRidesRowList.isNotEmpty
                ? rowReqRidesRowList.first
                : null;

            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.icon!,
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          rowReqRidesRow?.departureLocation,
                          'Departure Location',
                        ),
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                              lineHeight: 1.4,
                            ),
                      ),
                    ].divide(const SizedBox(height: 4.0)),
                  ),
                ),
              ].divide(const SizedBox(width: 16.0)),
            );
          },
        ),
      ),
    );
  }
}
