import 'package:ride_share_supa/components/button6_widget.dart';
import 'package:ride_share_supa/components/text_field3_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page2_model.dart';
export 'login_page2_model.dart';

class LoginPage2Widget extends StatefulWidget {
  const LoginPage2Widget({super.key});

  static String routeName = 'LoginPage2';
  static String routePath = 'loginPage2';

  @override
  State<LoginPage2Widget> createState() => _LoginPage2WidgetState();
}

class _LoginPage2WidgetState extends State<LoginPage2Widget> {
  late LoginPage2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPage2Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'LoginPage2',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown,
                },
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 40.0, 24.0, 40.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                              Text(
                                'RideShare',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24.0),
                                child: Container(
                                  height: 220.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: 0),
                                    fadeOutDuration: Duration(milliseconds: 0),
                                    imageUrl:
                                        'https://dimg.dreamflow.cloud/v1/image/A%20vibrant%20blue%20sports%20car%20parked%20on%20a%20modern%20cable-stayed%20bridge%20under%20a%20bright%20sky',
                                    fit: BoxFit.cover,
                                    alignment: Alignment(0.0, 0.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Sign In',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineSmall
                                              .override(
                                                font: GoogleFonts.interTight(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineSmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .fontStyle,
                                              ),
                                        ),
                                        Container(
                                          width: 120.0,
                                          height: 3.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(9999.0),
                                            shape: BoxShape.rectangle,
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                    Text(
                                      'Sign Up',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineSmall
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 24.0)),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Let\'s get started by filling out the form below.',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                  wrapWithModel(
                                    model: _model.textFieldModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: TextField3Widget(
                                      label: 'E-mail',
                                      labelPresent: true,
                                      helper: '',
                                      helperPresent: false,
                                      leadingIconPresent: false,
                                      trailingIconPresent: false,
                                      hint: 'Type here...',
                                      value: '',
                                      onChange: '',
                                      onSubmit: '',
                                      variant: 'outlined',
                                      error: false,
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.textFieldModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: TextField3Widget(
                                      label: 'Password',
                                      labelPresent: true,
                                      helper: '',
                                      helperPresent: false,
                                      leadingIconPresent: false,
                                      trailingIcon: Icon(
                                        Icons.visibility_off_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                      trailingIconPresent: true,
                                      hint: 'Type here...',
                                      value: '',
                                      onChange: '',
                                      onSubmit: '',
                                      variant: 'outlined',
                                      error: false,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 16.0, 0.0, 16.0),
                                    child: Text(
                                      'Forgot Password',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                            lineHeight: 1.4,
                                          ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  wrapWithModel(
                                    model: _model.buttonModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: Button6Widget(
                                      icon: false,
                                      iconPresent: true,
                                      iconEnd: false,
                                      iconEndPresent: false,
                                      content: 'Sign In',
                                      variant: 'primary',
                                      size: 'large',
                                      fullWidth: false,
                                      loading: false,
                                      disabled: false,
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.buttonModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: Button6Widget(
                                      icon: false,
                                      iconPresent: true,
                                      iconEnd: false,
                                      iconEndPresent: false,
                                      content: 'Continue with Google',
                                      variant: 'primary',
                                      size: 'large',
                                      fullWidth: false,
                                      loading: false,
                                      disabled: false,
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ].divide(SizedBox(height: 24.0)),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
