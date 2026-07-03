import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
  })  : this.label = label ?? 'Primary Mode',
        this.subtitle = subtitle ?? 'Selected option',
        this.color = color ?? const Color(0x00000000),
        this.isSelected = isSelected ?? true,
        this.hasSubtitle = hasSubtitle ?? true,
        this.disabled = disabled ?? false;

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
      opacity: valueOrDefault<double>(
        valueOrDefault<bool>(
          widget!.disabled,
          false,
        )
            ? 0.55
            : 1.0,
        1.0,
      ),
      child: Container(
        child: Container(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        valueOrDefault<double>(
                          valueOrDefault<bool>(
                            widget!.hasSubtitle,
                            true,
                          )
                              ? 0.0
                              : 0.0,
                          0.0,
                        ),
                        valueOrDefault<double>(
                          valueOrDefault<bool>(
                            widget!.hasSubtitle,
                            true,
                          )
                              ? 3.0
                              : 0.0,
                          3.0,
                        ),
                        valueOrDefault<double>(
                          valueOrDefault<bool>(
                            widget!.hasSubtitle,
                            true,
                          )
                              ? 0.0
                              : 0.0,
                          0.0,
                        ),
                        valueOrDefault<double>(
                          valueOrDefault<bool>(
                            widget!.hasSubtitle,
                            true,
                          )
                              ? 0.0
                              : 0.0,
                          0.0,
                        )),
                    child: Container(
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            valueOrDefault<bool>(
                              widget!.isSelected,
                              true,
                            )
                                ? Color(0x00000000)
                                : Colors.transparent,
                            FlutterFlowTheme.of(context).primary,
                          ),
                          borderRadius: BorderRadius.circular(999.0),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Visibility(
                          visible: valueOrDefault<bool>(
                            valueOrDefault<bool>(
                              widget!.isSelected,
                              true,
                            )
                                ? true
                                : false,
                            true,
                          ),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999.0),
                              shape: BoxShape.rectangle,
                            ),
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
                          valueOrDefault<String>(
                            widget!.label,
                            'Primary Mode',
                          ),
                          maxLines: 1,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                                lineHeight: 1.4,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (valueOrDefault<bool>(
                          valueOrDefault<bool>(
                            widget!.hasSubtitle,
                            true,
                          )
                              ? true
                              : false,
                          true,
                        ))
                          Container(
                            child: Container(
                              child: Text(
                                valueOrDefault<String>(
                                  widget!.subtitle,
                                  'Selected option',
                                ),
                                maxLines: 3,
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ].divide(SizedBox(width: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
