import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'dart:ui';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  static String routeName = 'LoginPage';
  static String routePath = 'loginPage';

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget>
    with TickerProviderStateMixin {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.emailAddressTextController ??= TextEditingController();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.emailAddressCreateTextController ??= TextEditingController();
    _model.emailAddressCreateFocusNode ??= FocusNode();

    _model.passwordCreateTextController ??= TextEditingController();
    _model.passwordCreateFocusNode ??= FocusNode();

    _model.passwordConfirmTextController ??= TextEditingController();
    _model.passwordConfirmFocusNode ??= FocusNode();

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
        title: 'LoginPage',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            body: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    width: 100.0,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: ScrollConfiguration(
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
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ScrollConfiguration(
                                behavior:
                                    ScrollConfiguration.of(context).copyWith(
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
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 20.0, 0.0, 0.0),
                                          child: Text(
                                            'RideShare',
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineMedium
                                                            .fontStyle,
                                                  ),
                                                  fontSize: 40.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 30.0, 0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child:
                                                      FlutterFlowExpandedImageView(
                                                    image: Image.network(
                                                      'https://images.unsplash.com/photo-1670285030808-a5d86b1525d6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxjYXJzJTIwYW5pbWF0ZWR8ZW58MHx8fHwxNzgxMDc2MDM0fDA&ixlib=rb-4.1.0&q=80&w=1080',
                                                      fit: BoxFit.contain,
                                                    ),
                                                    allowRotation: false,
                                                    tag: 'imageTag1',
                                                    useHeroAnimation: true,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Hero(
                                              tag: 'imageTag1',
                                              transitionOnUserGestures: true,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  'https://images.unsplash.com/photo-1670285030808-a5d86b1525d6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw2fHxjYXJzJTIwYW5pbWF0ZWR8ZW58MHx8fHwxNzgxMDc2MDM0fDA&ixlib=rb-4.1.0&q=80&w=1080',
                                                  width: 200.0,
                                                  height: 188.9,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 44.0, 0.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            constraints: BoxConstraints(
                                              maxWidth: 602.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(16.0),
                                                bottomRight:
                                                    Radius.circular(16.0),
                                              ),
                                            ),
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 700.0,
                                          constraints: BoxConstraints(
                                            maxWidth: 602.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment(-1.0, 0),
                                                    child: TabBar(
                                                      isScrollable: true,
                                                      tabAlignment:
                                                          TabAlignment.start,
                                                      labelColor:
                                                          Color(0xFF4B39EF),
                                                      unselectedLabelColor:
                                                          Color(0xFF57636C),
                                                      labelPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  16.0,
                                                                  16.0,
                                                                  16.0),
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .displaySmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .interTight(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmall
                                                                    .fontStyle,
                                                              ),
                                                      unselectedLabelStyle:
                                                          TextStyle(),
                                                      indicatorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      indicatorWeight: 4.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  12.0,
                                                                  16.0,
                                                                  12.0),
                                                      tabs: [
                                                        Tab(
                                                          text: 'Sign In',
                                                        ),
                                                        Tab(
                                                          text: 'Sign Up',
                                                        ),
                                                      ],
                                                      controller: _model
                                                          .tabBarController,
                                                      onTap: (i) async {
                                                        [
                                                          () async {},
                                                          () async {}
                                                        ][i]();
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TabBarView(
                                                      controller: _model
                                                          .tabBarController,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        12.0,
                                                                        12.0),
                                                            child:
                                                                ScrollConfiguration(
                                                              behavior:
                                                                  ScrollConfiguration.of(
                                                                          context)
                                                                      .copyWith(
                                                                scrollbars:
                                                                    false,
                                                                dragDevices: {
                                                                  PointerDeviceKind
                                                                      .mouse,
                                                                  PointerDeviceKind
                                                                      .touch,
                                                                  PointerDeviceKind
                                                                      .stylus,
                                                                  PointerDeviceKind
                                                                      .unknown,
                                                                },
                                                              ),
                                                              child: Scrollbar(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            16.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Autocomplete<String>(
                                                                            initialValue:
                                                                                TextEditingValue(),
                                                                            optionsBuilder:
                                                                                (textEditingValue) {
                                                                              if (textEditingValue.text == '') {
                                                                                return const Iterable<String>.empty();
                                                                              }
                                                                              return [
                                                                                'Option 1'
                                                                              ].where((option) {
                                                                                final lowercaseOption = option.toLowerCase();
                                                                                return lowercaseOption.contains(textEditingValue.text.toLowerCase());
                                                                              });
                                                                            },
                                                                            optionsViewBuilder: (context,
                                                                                onSelected,
                                                                                options) {
                                                                              return AutocompleteOptionsList(
                                                                                textFieldKey: _model.emailAddressKey,
                                                                                textController: _model.emailAddressTextController!,
                                                                                options: options.toList(),
                                                                                onSelected: onSelected,
                                                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: Color(0xFF0B0B0B),
                                                                                      fontSize: 20.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                textHighlightStyle: TextStyle(),
                                                                                elevation: 4.0,
                                                                                optionBackgroundColor: Color(0x00000000),
                                                                                optionHighlightColor: Color(0x00000000),
                                                                                maxHeight: 200.0,
                                                                              );
                                                                            },
                                                                            onSelected:
                                                                                (String selection) {
                                                                              safeSetState(() => _model.emailAddressSelectedOption = selection);
                                                                              FocusScope.of(context).unfocus();
                                                                            },
                                                                            fieldViewBuilder:
                                                                                (
                                                                              context,
                                                                              textEditingController,
                                                                              focusNode,
                                                                              onEditingComplete,
                                                                            ) {
                                                                              _model.emailAddressFocusNode = focusNode;

                                                                              _model.emailAddressTextController = textEditingController;
                                                                              return TextFormField(
                                                                                key: _model.emailAddressKey,
                                                                                controller: textEditingController,
                                                                                focusNode: focusNode,
                                                                                onEditingComplete: onEditingComplete,
                                                                                onChanged: (_) => EasyDebounce.debounce(
                                                                                  '_model.emailAddressTextController',
                                                                                  Duration(milliseconds: 2000),
                                                                                  () => safeSetState(() {}),
                                                                                ),
                                                                                autofocus: true,
                                                                                enabled: true,
                                                                                autofillHints: [
                                                                                  AutofillHints.email
                                                                                ],
                                                                                textInputAction: TextInputAction.next,
                                                                                obscureText: false,
                                                                                decoration: InputDecoration(
                                                                                  labelText: 'E-mail Address',
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  errorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  filled: true,
                                                                                  contentPadding: EdgeInsets.all(24.0),
                                                                                  suffixIcon: _model.emailAddressTextController!.text.isNotEmpty
                                                                                      ? InkWell(
                                                                                          onTap: () async {
                                                                                            _model.emailAddressTextController?.clear();
                                                                                            safeSetState(() {});
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.clear,
                                                                                            color: Color(0xFF060606),
                                                                                            size: 22.0,
                                                                                          ),
                                                                                        )
                                                                                      : null,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FontStyle.italic,
                                                                                      ),
                                                                                      color: Color(0xFF090909),
                                                                                      fontSize: 22.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FontStyle.italic,
                                                                                      lineHeight: 1.0,
                                                                                    ),
                                                                                textAlign: TextAlign.start,
                                                                                keyboardType: TextInputType.emailAddress,
                                                                                cursorColor: FlutterFlowTheme.of(context).primary,
                                                                                validator: _model.emailAddressTextControllerValidator.asValidator(context),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            16.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                _model.passwordTextController,
                                                                            focusNode:
                                                                                _model.passwordFocusNode,
                                                                            onChanged: (_) =>
                                                                                EasyDebounce.debounce(
                                                                              '_model.passwordTextController',
                                                                              Duration(milliseconds: 2000),
                                                                              () => safeSetState(() {}),
                                                                            ),
                                                                            autofocus:
                                                                                true,
                                                                            enabled:
                                                                                true,
                                                                            textInputAction:
                                                                                TextInputAction.next,
                                                                            obscureText:
                                                                                !_model.passwordVisibility,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              labelText: 'Password',
                                                                              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FontStyle.italic,
                                                                                    ),
                                                                                    color: Colors.black,
                                                                                    fontSize: 22.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FontStyle.italic,
                                                                                    lineHeight: 1.0,
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                  width: 3.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(40.0),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  width: 3.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(40.0),
                                                                              ),
                                                                              errorBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  width: 3.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(40.0),
                                                                              ),
                                                                              focusedErrorBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: FlutterFlowTheme.of(context).error,
                                                                                  width: 3.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(40.0),
                                                                              ),
                                                                              filled: true,
                                                                              contentPadding: EdgeInsets.all(24.0),
                                                                              suffixIcon: InkWell(
                                                                                onTap: () async {
                                                                                  safeSetState(() => _model.passwordVisibility = !_model.passwordVisibility);
                                                                                },
                                                                                focusNode: FocusNode(skipTraversal: false),
                                                                                child: Icon(
                                                                                  _model.passwordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                                                                  color: Color(0xFF757575),
                                                                                  size: 22.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.w900,
                                                                                    fontStyle: FontStyle.italic,
                                                                                  ),
                                                                                  color: Color(0xFF0D0D0D),
                                                                                  fontSize: 20.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w900,
                                                                                  fontStyle: FontStyle.italic,
                                                                                  lineHeight: 1.0,
                                                                                ),
                                                                            keyboardType:
                                                                                TextInputType.emailAddress,
                                                                            cursorColor:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            validator:
                                                                                _model.passwordTextControllerValidator.asValidator(context),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              16.0),
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed:
                                                                                () {
                                                                              print('Button pressed ...');
                                                                            },
                                                                            text:
                                                                                'Forgot Password',
                                                                            options:
                                                                                FFButtonOptions(
                                                                              width: 230.0,
                                                                              height: 44.0,
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              iconAlignment: IconAlignment.start,
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FontStyle.italic,
                                                                                    ),
                                                                                    color: Colors.black,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FontStyle.italic,
                                                                                  ),
                                                                              elevation: 0.0,
                                                                              borderSide: BorderSide(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                width: 2.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              16.0),
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed:
                                                                                () async {
                                                                              GoRouter.of(context).prepareAuthEvent();

                                                                              final user = await authManager.signInWithEmail(
                                                                                context,
                                                                                _model.emailAddressTextController.text,
                                                                                _model.passwordTextController.text,
                                                                              );
                                                                              if (user == null) {
                                                                                return;
                                                                              }

                                                                              context.pushNamedAuth(HomePageWidget.routeName, context.mounted);
                                                                            },
                                                                            text:
                                                                                'Sign In',
                                                                            options:
                                                                                FFButtonOptions(
                                                                              width: 230.0,
                                                                              height: 52.0,
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                    font: GoogleFonts.interTight(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                    color: Colors.white,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                              elevation: 3.0,
                                                                              borderSide: BorderSide(
                                                                                color: Colors.transparent,
                                                                                width: 1.0,
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(40.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          'Or',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FontStyle.italic,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FontStyle.italic,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            GoRouter.of(context).prepareAuthEvent();

                                                                            final user =
                                                                                await authManager.signInWithEmail(
                                                                              context,
                                                                              _model.emailAddressSelectedOption!,
                                                                              _model.passwordTextController.text,
                                                                            );
                                                                            if (user ==
                                                                                null) {
                                                                              return;
                                                                            }

                                                                            context.pushNamedAuth(Screen3Widget.routeName,
                                                                                context.mounted);
                                                                          },
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/images/android_neutral_rd_ctn@1x.png',
                                                                              width: 200.0,
                                                                              height: 70.0,
                                                                              fit: BoxFit.contain,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: FutureBuilder<
                                                              List<
                                                                  VerifiedPaymentsRow>>(
                                                            future: VerifiedPaymentsTable()
                                                                .querySingleRow(
                                                              queryFn: (q) => q
                                                                  .eq(
                                                                      'Email',
                                                                      _model
                                                                          .emailAddressCreateTextController
                                                                          .text
                                                                          .trim()
                                                                          .toLowerCase())
                                                                  .eq('verified',
                                                                      true),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<VerifiedPaymentsRow>
                                                                  signUppVerifiedPaymentsRowList =
                                                                  snapshot
                                                                      .data!;

                                                              final signUppVerifiedPaymentsRow =
                                                                  signUppVerifiedPaymentsRowList
                                                                          .isNotEmpty
                                                                      ? signUppVerifiedPaymentsRowList
                                                                          .first
                                                                      : null;

                                                              return ScrollConfiguration(
                                                                behavior: ScrollConfiguration.of(
                                                                        context)
                                                                    .copyWith(
                                                                  scrollbars:
                                                                      false,
                                                                  dragDevices: {
                                                                    PointerDeviceKind
                                                                        .mouse,
                                                                    PointerDeviceKind
                                                                        .touch,
                                                                    PointerDeviceKind
                                                                        .stylus,
                                                                    PointerDeviceKind
                                                                        .unknown,
                                                                  },
                                                                ),
                                                                child:
                                                                    Scrollbar(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    primary:
                                                                        false,
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Opacity(
                                                                          opacity:
                                                                              0.5,
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                20.0,
                                                                                0.0,
                                                                                16.0),
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              child: TextFormField(
                                                                                controller: _model.emailAddressCreateTextController,
                                                                                focusNode: _model.emailAddressCreateFocusNode,
                                                                                onChanged: (_) => EasyDebounce.debounce(
                                                                                  '_model.emailAddressCreateTextController',
                                                                                  Duration(milliseconds: 2000),
                                                                                  () => safeSetState(() {}),
                                                                                ),
                                                                                autofocus: true,
                                                                                enabled: true,
                                                                                autofillHints: [
                                                                                  AutofillHints.email
                                                                                ],
                                                                                obscureText: false,
                                                                                decoration: InputDecoration(
                                                                                  labelText: 'E-mail Address',
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: Color(0xFF238378),
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  errorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  contentPadding: EdgeInsets.all(24.0),
                                                                                  hoverColor: Colors.black,
                                                                                  suffixIcon: _model.emailAddressCreateTextController!.text.isNotEmpty
                                                                                      ? InkWell(
                                                                                          onTap: () async {
                                                                                            _model.emailAddressCreateTextController?.clear();
                                                                                            safeSetState(() {});
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.clear,
                                                                                            color: Color(0xFF060606),
                                                                                            size: 22.0,
                                                                                          ),
                                                                                        )
                                                                                      : null,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FontStyle.italic,
                                                                                      ),
                                                                                      color: Colors.black,
                                                                                      fontSize: 20.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                      fontStyle: FontStyle.italic,
                                                                                      lineHeight: 1.0,
                                                                                    ),
                                                                                keyboardType: TextInputType.emailAddress,
                                                                                cursorColor: FlutterFlowTheme.of(context).primary,
                                                                                validator: _model.emailAddressCreateTextControllerValidator.asValidator(context),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Opacity(
                                                                          opacity:
                                                                              0.5,
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                16.0),
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              child: TextFormField(
                                                                                controller: _model.passwordCreateTextController,
                                                                                focusNode: _model.passwordCreateFocusNode,
                                                                                onChanged: (_) => EasyDebounce.debounce(
                                                                                  '_model.passwordCreateTextController',
                                                                                  Duration(milliseconds: 2000),
                                                                                  () => safeSetState(() {}),
                                                                                ),
                                                                                autofocus: true,
                                                                                enabled: true,
                                                                                obscureText: !_model.passwordCreateVisibility,
                                                                                decoration: InputDecoration(
                                                                                  labelText: 'Password',
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  errorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(40.0),
                                                                                  ),
                                                                                  contentPadding: EdgeInsets.all(24.0),
                                                                                  suffixIcon: InkWell(
                                                                                    onTap: () async {
                                                                                      safeSetState(() => _model.passwordCreateVisibility = !_model.passwordCreateVisibility);
                                                                                    },
                                                                                    focusNode: FocusNode(skipTraversal: true),
                                                                                    child: Icon(
                                                                                      _model.passwordCreateVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                                                                      color: Color(0xFF0F0F0F),
                                                                                      size: 22.0,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FontStyle.italic,
                                                                                      ),
                                                                                      color: Color(0xFF090909),
                                                                                      fontSize: 20.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                      fontStyle: FontStyle.italic,
                                                                                      lineHeight: 1.0,
                                                                                    ),
                                                                                keyboardType: TextInputType.emailAddress,
                                                                                cursorColor: FlutterFlowTheme.of(context).primary,
                                                                                validator: _model.passwordCreateTextControllerValidator.asValidator(context),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Opacity(
                                                                          opacity:
                                                                              0.5,
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                16.0),
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              child: TextFormField(
                                                                                controller: _model.passwordConfirmTextController,
                                                                                focusNode: _model.passwordConfirmFocusNode,
                                                                                onChanged: (_) => EasyDebounce.debounce(
                                                                                  '_model.passwordConfirmTextController',
                                                                                  Duration(milliseconds: 2000),
                                                                                  () => safeSetState(() {}),
                                                                                ),
                                                                                autofocus: true,
                                                                                enabled: true,
                                                                                obscureText: !_model.passwordConfirmVisibility,
                                                                                decoration: InputDecoration(
                                                                                  labelText: 'Confirm Password',
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(24.0),
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(24.0),
                                                                                  ),
                                                                                  errorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(24.0),
                                                                                  ),
                                                                                  focusedErrorBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(
                                                                                      color: FlutterFlowTheme.of(context).error,
                                                                                      width: 3.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(24.0),
                                                                                  ),
                                                                                  filled: true,
                                                                                  contentPadding: EdgeInsets.all(24.0),
                                                                                  hoverColor: Color(0xFF090909),
                                                                                  suffixIcon: InkWell(
                                                                                    onTap: () async {
                                                                                      safeSetState(() => _model.passwordConfirmVisibility = !_model.passwordConfirmVisibility);
                                                                                    },
                                                                                    focusNode: FocusNode(skipTraversal: true),
                                                                                    child: Icon(
                                                                                      _model.passwordConfirmVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                                                                      color: Color(0xFF080707),
                                                                                      size: 22.0,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                      font: GoogleFonts.inter(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                        fontStyle: FontStyle.italic,
                                                                                      ),
                                                                                      color: Color(0xFF070708),
                                                                                      fontSize: 20.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                      fontStyle: FontStyle.italic,
                                                                                      lineHeight: 1.0,
                                                                                    ),
                                                                                keyboardType: TextInputType.emailAddress,
                                                                                cursorColor: FlutterFlowTheme.of(context).primary,
                                                                                validator: _model.passwordConfirmTextControllerValidator.asValidator(context),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              30.0,
                                                                              0.0,
                                                                              30.0),
                                                                          child:
                                                                              FutureBuilder<List<VerifiedPaymentsRow>>(
                                                                            future:
                                                                                VerifiedPaymentsTable().querySingleRow(
                                                                              queryFn: (q) => q,
                                                                            ),
                                                                            builder:
                                                                                (context, snapshot) {
                                                                              // Customize what your widget looks like when it's loading.
                                                                              if (!snapshot.hasData) {
                                                                                return Center(
                                                                                  child: SizedBox(
                                                                                    width: 50.0,
                                                                                    height: 50.0,
                                                                                    child: CircularProgressIndicator(
                                                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                                                        FlutterFlowTheme.of(context).primary,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }
                                                                              List<VerifiedPaymentsRow> buttonVerifiedPaymentsRowList = snapshot.data!;

                                                                              final buttonVerifiedPaymentsRow = buttonVerifiedPaymentsRowList.isNotEmpty ? buttonVerifiedPaymentsRowList.first : null;

                                                                              return FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  final signupEmail = _model.emailAddressCreateTextController.text.trim().toLowerCase();
                                                                                  if (signupEmail.isEmpty) {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Text('Please enter your email address first'),
                                                                                      ),
                                                                                    );
                                                                                    return;
                                                                                  }

                                                                                  final existingPayments = await VerifiedPaymentsTable().queryRows(
                                                                                    queryFn: (q) => q.eq('Email', signupEmail),
                                                                                  );
                                                                                  if (existingPayments.isEmpty) {
                                                                                    _model.pendingPaymentVerification = await VerifiedPaymentsTable().insert({
                                                                                      'Email': signupEmail,
                                                                                      'verified': false,
                                                                                    });
                                                                                  }
                                                                                  final registrationUsd = 45 * 0.056;
                                                                                  final paid = await actions.payWithPaypal(
                                                                                    context,
                                                                                    registrationUsd,
                                                                                    'RideShare Registration Fee (R45 / Year)',
                                                                                  );
                                                                                  if (!paid) {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Text('Payment was not completed. Please try again.'),
                                                                                      ),
                                                                                    );
                                                                                    return;
                                                                                  }
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        'Please send proof of payment via button below',
                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FontWeight.w900,
                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                              fontSize: 34.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w900,
                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                      duration: Duration(milliseconds: 5750),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                    ),
                                                                                  );

                                                                                  safeSetState(() {});
                                                                                },
                                                                                text: 'Pay Registration Fee (R45 / Year)',
                                                                                options: FFButtonOptions(
                                                                                  width: 230.0,
                                                                                  height: 52.0,
                                                                                  padding: EdgeInsets.all(0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).primary,
                                                                                  textStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                                        font: GoogleFonts.interTight(
                                                                                          fontWeight: FontWeight.w800,
                                                                                          fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                        ),
                                                                                        fontSize: 26.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w800,
                                                                                        fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                      ),
                                                                                  elevation: 0.0,
                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              30.0),
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed:
                                                                                () async {
                                                                              await launchURL('mailto:rideshare8855@gmail.com');

                                                                              safeSetState(() {});
                                                                            },
                                                                            text:
                                                                                'Email Proof of Payment',
                                                                            options:
                                                                                FFButtonOptions(
                                                                              width: 230.0,
                                                                              height: 52.0,
                                                                              padding: EdgeInsets.all(0.0),
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              textStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                                    font: GoogleFonts.interTight(
                                                                                      fontWeight: FontWeight.w800,
                                                                                      fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                    ),
                                                                                    fontSize: 26.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w800,
                                                                                    fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                  ),
                                                                              elevation: 0.0,
                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        if (signUppVerifiedPaymentsRow !=
                                                                            null)
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                FFButtonWidget(
                                                                              onPressed: () async {
                                                                                GoRouter.of(context).prepareAuthEvent();
                                                                                if (_model.passwordCreateTextController.text != _model.passwordConfirmTextController.text) {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    SnackBar(
                                                                                      content: Text(
                                                                                        'Passwords don\'t match!',
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                  return;
                                                                                }

                                                                                final user = await authManager.createAccountWithEmail(
                                                                                  context,
                                                                                  _model.emailAddressCreateTextController.text.trim(),
                                                                                  _model.passwordCreateTextController.text,
                                                                                );
                                                                                if (user == null) {
                                                                                  return;
                                                                                }

                                                                                context.pushNamedAuth(Screen3Widget.routeName, context.mounted);
                                                                              },
                                                                              text: 'Create Account',
                                                                              options: FFButtonOptions(
                                                                                width: 230.0,
                                                                                height: 52.0,
                                                                                padding: EdgeInsets.all(0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                textStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                                      font: GoogleFonts.interTight(
                                                                                        fontWeight: FontWeight.w800,
                                                                                        fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                      ),
                                                                                      fontSize: 28.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w800,
                                                                                      fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                    ),
                                                                                elevation: 3.0,
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.transparent,
                                                                                  width: 1.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(12.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            'Once you have paid and emailed your proof of payment, you can safely close the app. When you return, simply type your email into this Sign Up tab again, and the button will be unlocked to let you set your password!',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
