import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'location_input_arriva_model.dart';
export 'location_input_arriva_model.dart';

class LocationInputArrivaWidget extends StatefulWidget {
  const LocationInputArrivaWidget({
    super.key,
    this.icon,
    String? label,
    String? hint,
  })  : this.label = label ?? 'To',
        this.hint = hint ?? 'Enter destination';

  final Widget? icon;
  final String label;
  final String hint;

  @override
  State<LocationInputArrivaWidget> createState() =>
      _LocationInputArrivaWidgetState();
}

class _LocationInputArrivaWidgetState extends State<LocationInputArrivaWidget> {
  late LocationInputArrivaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LocationInputArrivaModel());
    _model.textFocusNode ??= FocusNode();
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
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (widget.icon != null) widget.icon!,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Arrival:',
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          font: GoogleFonts.inter(),
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                  TextFormField(
                    controller: _model.textTextController ??=
                        TextEditingController(),
                    focusNode: _model.textFocusNode,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      filled: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0x00000000)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0x00000000)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    validator:
                        _model.textTextControllerValidator.asValidator(context),
                  ),
                ].divide(const SizedBox(height: 4.0)),
              ),
            ),
          ].divide(const SizedBox(width: 16.0)),
        ),
      ),
    );
  }
}
