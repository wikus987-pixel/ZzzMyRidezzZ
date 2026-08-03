import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'metric_card_model.dart';
export 'metric_card_model.dart';

class MetricCardWidget extends StatefulWidget {
  const MetricCardWidget({
    super.key,
    String? label,
    this.icon,
    Color? tone,
    String? value,
  })  : label = label ?? 'Pending',
        tone = tone ?? const Color(0x00000000),
        value = value ?? '14';

  final String label;
  final Widget? icon;
  final Color tone;
  final String value;

  @override
  State<MetricCardWidget> createState() => _MetricCardWidgetState();
}

class _MetricCardWidgetState extends State<MetricCardWidget> {
  late MetricCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MetricCardModel());

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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    valueOrDefault<String>(
                      widget.label,
                      'Pending',
                    ),
                    maxLines: 1,
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
                          fontWeight:
                              FlutterFlowTheme.of(context).labelSmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelSmall.fontStyle,
                          lineHeight: 1.4,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                widget.icon!,
              ],
            ),
            Text(
              valueOrDefault<String>(
                widget.value,
                '14',
              ),
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    font: GoogleFonts.interTight(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                    lineHeight: 1.4,
                  ),
            ),
          ].divide(const SizedBox(height: 4.0)),
        ),
      ),
    );
  }
}
