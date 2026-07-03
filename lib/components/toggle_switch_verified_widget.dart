import '/components/switch_component2_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'toggle_switch_verified_model.dart';
export 'toggle_switch_verified_model.dart';

/// Toggle switch and When the Toggle Switch is flipped to true, configure an
/// action chain: First, update that user's document setting
/// 'payment_verified' to true.
///
/// Second, create a new document in the 'verified_payments' collection saving
/// their email address and the current timestamp.
class ToggleSwitchVerifiedWidget extends StatefulWidget {
  const ToggleSwitchVerifiedWidget({
    super.key,
    String? label,
    bool? active,
  })  : this.label = label ?? '',
        this.active = active ?? false;

  final String label;
  final bool active;

  @override
  State<ToggleSwitchVerifiedWidget> createState() =>
      _ToggleSwitchVerifiedWidgetState();
}

class _ToggleSwitchVerifiedWidgetState
    extends State<ToggleSwitchVerifiedWidget> {
  late ToggleSwitchVerifiedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ToggleSwitchVerifiedModel());

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
        borderRadius: BorderRadius.circular(16.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget!.active.toString(),
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.inter(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        lineHeight: 1.4,
                      ),
                ),
                wrapWithModel(
                  model: _model.switchModel,
                  updateCallback: () => safeSetState(() {}),
                  child: SwitchComponent2Widget(
                    label: '',
                    labelPresent: false,
                    variant: 'iOS',
                    active: valueOrDefault<bool>(
                      widget!.active,
                      false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
