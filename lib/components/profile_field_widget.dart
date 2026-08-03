import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_field_model.dart';
export 'profile_field_model.dart';

class ProfileFieldWidget extends StatefulWidget {
  const ProfileFieldWidget({
    super.key,
    String? label,
    this.icon,
    String? value,
  })  : label = label ?? 'Full Name',
        value = value ?? 'Jordan Devereaux';

  final String label;
  final Widget? icon;
  final String value;

  @override
  State<ProfileFieldWidget> createState() => _ProfileFieldWidgetState();
}

class _ProfileFieldWidgetState extends State<ProfileFieldWidget> {
  late ProfileFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileFieldModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          valueOrDefault<String>(
            widget.label,
            'Full Name',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
        Container(
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
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.icon!,
                Expanded(
                  flex: 1,
                  child: Text(
                    valueOrDefault<String>(
                      widget.value,
                      'Jordan Devereaux',
                    ),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                ),
                Icon(
                  Icons.edit_rounded,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 18.0,
                ),
              ].divide(const SizedBox(width: 16.0)),
            ),
          ),
        ),
      ].divide(const SizedBox(height: 4.0)),
    );
  }
}
