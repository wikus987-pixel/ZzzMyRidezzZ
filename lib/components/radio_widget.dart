import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'radio_model.dart';
export 'radio_model.dart';

class RadioWidget extends StatefulWidget {
  const RadioWidget({
    super.key,
    String? label,
    String? subtitle,
    Color? color,
    bool? isSelected,
    bool? hasSubtitle,
    bool? disabled,
  })  : label = label ?? 'Primary Mode',
        subtitle = subtitle ?? 'Selected option',
        color = color ?? const Color(0x00000000),
        isSelected = isSelected ?? true,
        hasSubtitle = hasSubtitle ?? true,
        disabled = disabled ?? false;

  final String label;
  final String subtitle;
  final Color color;
  final bool isSelected;
  final bool hasSubtitle;
  final bool disabled;

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  late RadioModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RadioModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.disabled ? 0.55 : 1.0,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                0.0,
                widget.hasSubtitle ? 3.0 : 0.0,
                0.0,
                0.0,
              ),
              child: Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? const Color(0x00000000)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                ),
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Visibility(
                  visible: widget.isSelected,
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary,
                      borderRadius: BorderRadius.circular(999.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          lineHeight: 1.4,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.hasSubtitle)
                    Text(
                      widget.subtitle,
                      maxLines: 3,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            lineHeight: 1.4,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ].divide(const SizedBox(width: 16.0)),
        ),
      ),
    );
  }
}
