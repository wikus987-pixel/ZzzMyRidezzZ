import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'checkbox_model.dart';
export 'checkbox_model.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({
    super.key,
    String? label,
    String? subtitle,
    Color? color,
    bool? isChecked,
    bool? hasSubtitle,
    bool? disabled,
  })  : label = label ?? 'Enable Feature',
        subtitle = subtitle ?? 'Toggle this setting',
        color = color ?? const Color(0x00000000),
        isChecked = isChecked ?? true,
        hasSubtitle = hasSubtitle ?? true,
        disabled = disabled ?? false;

  final String label;
  final String subtitle;
  final Color color;
  final bool isChecked;
  final bool hasSubtitle;
  final bool disabled;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  late CheckboxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckboxModel());

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
                  color: widget.isChecked
                      ? const Color(0x00000000)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                ),
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Visibility(
                  visible: widget.isChecked,
                  child: const Icon(
                    Icons.check_rounded,
                    size: 16.0,
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
