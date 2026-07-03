import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/button5_widget.dart';
import '/components/text_field2_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'clean_compact_modern_model.dart';
export 'clean_compact_modern_model.dart';

/// Create a clean, compact modern dialog popup component for an admin
/// dashboard panel.
///
/// It should feature a Container card with rounded corners (radius 16) and a
/// subtle shadow. Inside the container, use a Column with clean padding. At
/// the top, a Title text widget saying "Manual Verification" in a bold header
/// font. Underneath the title, add a beautifully spaced TextField designed
/// for email entry with an email icon and a placeholder text saying "Enter
/// user email...". At the bottom, place a prominent full-width action Button
/// that says "Verify Account".
class CleanCompactModernWidget extends StatefulWidget {
  const CleanCompactModernWidget({
    super.key,
    String? title,
    String? hint,
    String? buttonLabel,
  })  : this.title = title ?? '',
        this.hint = hint ?? '',
        this.buttonLabel = buttonLabel ?? '';

  final String title;
  final String hint;
  final String buttonLabel;

  @override
  State<CleanCompactModernWidget> createState() =>
      _CleanCompactModernWidgetState();
}

class _CleanCompactModernWidgetState extends State<CleanCompactModernWidget> {
  late CleanCompactModernModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CleanCompactModernModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        width: 340.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget!.title,
                      'Manual Verification',
                    ),
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                  Text(
                    'Please provide the account email address to proceed with manual validation.',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
              wrapWithModel(
                model: _model.textFieldModel,
                updateCallback: () => safeSetState(() {}),
                child: TextField2Widget(
                  label: 'Email Address',
                  labelPresent: true,
                  helper: '',
                  helperPresent: false,
                  leadingIcon: Icon(
                    Icons.mail_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  leadingIconPresent: true,
                  trailingIconPresent: false,
                  hint: widget!.hint,
                  value: '',
                  onChange: '',
                  onSubmit: '',
                  variant: 'outlined',
                  error: false,
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  final email = (_model.textFieldModel.inputTextController?.text ??
                          '')
                      .trim()
                      .toLowerCase();
                  if (email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter an email address.'),
                      ),
                    );
                    return;
                  }
                  final emailRegex =
                      RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
                  if (!emailRegex.hasMatch(email)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a valid email address.'),
                      ),
                    );
                    return;
                  }

                  final existing = await VerifiedPaymentsTable().queryRows(
                    queryFn: (q) => q.eq('email', email),
                  );
                  if (existing.isEmpty) {
                    await VerifiedPaymentsTable().insert({
                      'email': email,
                      'status': 'verified',
                      'verified': true,
                    });
                  } else {
                    await VerifiedPaymentsTable().update(
                      data: {'status': 'verified', 'verified': true},
                      matchingRows: (rows) => rows.eq('email', email),
                    );
                  }
                  await UsersTable().update(
                    data: {'IsSignupPaid': true},
                    matchingRows: (rows) => rows.eq('email', email),
                  );

                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '$email verified successfully!',
                          style: TextStyle(
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        duration: Duration(milliseconds: 4000),
                        backgroundColor: FlutterFlowTheme.of(context).secondary,
                      ),
                    );
                  }
                },
                child: wrapWithModel(
                  model: _model.buttonModel,
                  updateCallback: () => safeSetState(() {}),
                  child: Button5Widget(
                    iconPresent: false,
                    iconEndPresent: false,
                    content: 'Verify Email',
                    variant: 'primary',
                    size: 'large',
                    fullWidth: true,
                    loading: false,
                    disabled: false,
                  ),
                ),
              ),
            ].divide(SizedBox(height: 24.0)),
          ),
        ),
      ),
    );
  }
}
