import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'action_card_model.dart';
export 'action_card_model.dart';

class ActionCardWidget extends StatefulWidget {
  const ActionCardWidget({
    super.key,
    Color? tone,
    this.icon,
    String? label,
  })  : tone = tone ?? const Color(0x00000000),
        label = label ?? 'View All Payments';

  final Color tone;
  final Widget? icon;
  final String label;

  @override
  State<ActionCardWidget> createState() => _ActionCardWidgetState();
}

class _ActionCardWidgetState extends State<ActionCardWidget> {
  late ActionCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ActionCardModel());

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
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  widget.tone,
                  FlutterFlowTheme.of(context).secondary,
                ),
                borderRadius: BorderRadius.circular(9999.0),
                shape: BoxShape.rectangle,
              ),
              child: widget.icon!,
            ),
            Text(
              valueOrDefault<String>(
                widget.label,
                'View All Payments',
              ),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).labelLarge.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelLarge.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelLarge.fontStyle,
                    lineHeight: 1.4,
                  ),
            ),
          ].divide(SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}
