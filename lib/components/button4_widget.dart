import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'button4_model.dart';
export 'button4_model.dart';

class Button4Widget extends StatefulWidget {
  const Button4Widget({
    super.key,
    this.icon,
    bool? iconPresent,
    this.iconEnd,
    bool? iconEndPresent,
    String? content,
    String? variant,
    String? size,
    bool? fullWidth,
    bool? loading,
    bool? disabled,
  })  : iconPresent = iconPresent ?? false,
        iconEndPresent = iconEndPresent ?? false,
        content = content ?? 'Pay Now',
        variant = variant ?? 'primary',
        size = size ?? 'medium',
        fullWidth = fullWidth ?? true,
        loading = loading ?? false,
        disabled = disabled ?? false;

  final Widget? icon;
  final bool iconPresent;
  final Widget? iconEnd;
  final bool iconEndPresent;
  final String content;
  final String variant;
  final String size;
  final bool fullWidth;
  final bool loading;
  final bool disabled;

  @override
  State<Button4Widget> createState() => _Button4WidgetState();
}

class _Button4WidgetState extends State<Button4Widget> {
  late Button4Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Button4Model());

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
        color: FlutterFlowTheme.of(context).primary,
        borderRadius: BorderRadius.only(),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.transparent,
          width: 0.0,
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional(0.0, 0.0),
        children: [
          Opacity(
            opacity: valueOrDefault<double>(
              valueOrDefault<bool>(
                widget.loading,
                false,
              )
                  ? 0.0
                  : 1.0,
              1.0,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  valueOrDefault<double>(
                    () {
                      if (valueOrDefault<String>(
                            widget.size,
                            'medium',
                          ) ==
                          'small') {
                        return 16.0;
                      } else if (valueOrDefault<String>(
                            widget.size,
                            'medium',
                          ) ==
                          'large') {
                        return 32.0;
                      } else {
                        return 24.0;
                      }
                    }(),
                    24.0,
                  ),
                  valueOrDefault<double>(
                    () {
                      if (valueOrDefault<String>(
                            widget.size,
                            'medium',
                          ) ==
                          'small') {
                        return 4.0;
                      } else if (valueOrDefault<String>(
                            widget.size,
                            'medium',
                          ) ==
                          'large') {
                        return 16.0;
                      } else {
                        return 8.0;
                      }
                    }(),
                    8.0,
                  ),
                  valueOrDefault<double>(
                    () {
                      if (valueOrDefault<String>(
                            widget.size,
                            'medium',
                          ) ==
                          'small') {
                        return 16.0;
                      } else if (valueOrDefault<String>(
                            widget.size,
                            'medium',
                          ) ==
                          'large') {
                        return 32.0;
                      } else {
                        return 24.0;
                      }
                    }(),
                    24.0,
                  ),
                  valueOrDefault<double>(
                    () {
                      if (valueOrDefault<String>(
                            widget.size,
                            'medium',
                          ) ==
                          'small') {
                        return 4.0;
                      } else if (valueOrDefault<String>(
                            widget.size,
                            'medium',
                          ) ==
                          'large') {
                        return 16.0;
                      } else {
                        return 8.0;
                      }
                    }(),
                    8.0,
                  )),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (valueOrDefault<bool>(
                    widget.iconPresent,
                    false,
                  ))
                    Icon(
                      Icons.add_rounded,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      size: 16.0,
                    ),
                  Text(
                    valueOrDefault<String>(
                      widget.content,
                      'Pay Now',
                    ),
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).alternate,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                          lineHeight: 1.4,
                        ),
                    overflow: TextOverflow.clip,
                  ),
                  if (valueOrDefault<bool>(
                    widget.iconEndPresent,
                    false,
                  ))
                    Icon(
                      Icons.add_rounded,
                      size: 16.0,
                    ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ),
          ),
          if (valueOrDefault<bool>(
            valueOrDefault<bool>(
              widget.loading,
              false,
            )
                ? true
                : false,
            false,
          ))
            CircularPercentIndicator(
              percent: 0.0,
              radius: 7.0,
              lineWidth: 2.0,
              animation: true,
              animateFromLastPercent: true,
            ),
        ],
      ),
    );
  }
}
