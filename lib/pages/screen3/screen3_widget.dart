import 'package:ride_share_supa/auth/supabase_auth/auth_util.dart';
import 'package:ride_share_supa/backend/backend.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ride_share_supa/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screen3_model.dart';
export 'screen3_model.dart';

class Screen3Widget extends StatefulWidget {
  const Screen3Widget({
    super.key,
    this.paypalPayMeLink,
    this.uid,
  });

  final String? paypalPayMeLink;
  final String? uid;

  static String routeName = 'screen3';
  static String routePath = 'screen3';

  @override
  State<Screen3Widget> createState() => _Screen3WidgetState();
}

class _Screen3WidgetState extends State<Screen3Widget> {
  late Screen3Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Screen3Model());

    _model.firstNameInputTextController ??= TextEditingController();
    _model.firstNameInputFocusNode ??= FocusNode();

    _model.surnameInputTextController ??= TextEditingController();
    _model.surnameInputFocusNode ??= FocusNode();

    _model.iDnumberInputTextController ??= TextEditingController();
    _model.iDnumberInputFocusNode ??= FocusNode();

    _model.cellNumberInputTextController ??= TextEditingController();
    _model.cellNumberInputFocusNode ??= FocusNode();

    _model.vehicleRegistrationTextController ??= TextEditingController();
    _model.vehicleRegistrationFocusNode ??= FocusNode();

    _model.homeTownInputTextController ??= TextEditingController();
    _model.homeTownInputFocusNode ??= FocusNode();

    _model.textController7 ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.bankNameInputTextController ??= TextEditingController();
    _model.bankNameInputFocusNode ??= FocusNode();

    _model.accHolderNameInputTextController ??= TextEditingController();
    _model.accHolderNameInputFocusNode ??= FocusNode();

    _model.accNumberInputTextController ??= TextEditingController();
    _model.accNumberInputFocusNode ??= FocusNode();

    _model.branchCodeInputTextController ??= TextEditingController();
    _model.branchCodeInputFocusNode ??= FocusNode();

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
      title: 'screen3',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                FutureBuilder<List<UsersRow>>(
                  future: UsersTable().queryRows(
                    queryFn: (q) => q,
                  ),
                  builder: (context, snapshot) {
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
                    List<UsersRow> listViewUsersRowList = snapshot.data!;

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewUsersRowList.length,
                      itemBuilder: (context, listViewIndex) {
                        return Container(width: 100, height: 100, color: Colors.green);
                      },
                    );
                  },
                ),
                FutureBuilder<List<UsersRow>>(
                  future: UsersTable().querySingleRow(
                    queryFn: (q) => q,
                  ),
                  builder: (context, snapshot) {
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
                    List<UsersRow> columnUsersRowList = snapshot.data!;
                    final columnUsersRow = columnUsersRowList.isNotEmpty ? columnUsersRowList.first : null;

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, -1.0),
                            child: FutureBuilder<List<UsersRow>>(
                              future: UsersTable().querySingleRow(
                                queryFn: (q) => q.eqOrNull(
                                  'uid',
                                  columnUsersRow?.uid,
                                ),
                              ),
                              builder: (context, snapshot) {
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

                                return ScrollConfiguration(
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
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: const AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                                              child: AutoSizeText(
                                                'New User Details',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w900,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      fontSize: 40.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w900,
                                                      fontStyle: FontStyle.italic,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller: _model.firstNameInputTextController,
                                                focusNode: _model.firstNameInputFocusNode,
                                                onChanged: (_) => EasyDebounce.debounce(
                                                  '_model.firstNameInputTextController',
                                                  const Duration(milliseconds: 2000),
                                                  () => safeSetState(() {}),
                                                ),
                                                autofocus: false,
                                                textCapitalization: TextCapitalization.words,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: const Color(0xFF070708),
                                                        letterSpacing: 0.0,
                                                      ),
                                                  alignLabelWithHint: true,
                                                  hintText: 'First Name',
                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Color(0xFF01055C),
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: const Color(0xFFCDCCF6),
                                                  suffixIcon: _model.firstNameInputTextController!.text.isNotEmpty
                                                      ? InkWell(
                                                          onTap: () async {
                                                            _model.firstNameInputTextController?.clear();
                                                            safeSetState(() {});
                                                          },
                                                          child: const Icon(Icons.clear, size: 22),
                                                        )
                                                      : null,
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      color: const Color(0xFF060606),
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                                cursorColor: Colors.black,
                                                validator: _model.firstNameInputTextControllerValidator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller: _model.surnameInputTextController,
                                                focusNode: _model.surnameInputFocusNode,
                                                autofocus: false,
                                                textCapitalization: TextCapitalization.words,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: const Color(0xFF070708),
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText: 'Surname',
                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Color(0xFF01055C),
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: const Color(0xFFCDCCF6),
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      color: const Color(0xFF060606),
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                validator: _model.surnameInputTextControllerValidator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller: _model.iDnumberInputTextController,
                                                focusNode: _model.iDnumberInputFocusNode,
                                                autofocus: false,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: const Color(0xFF070708),
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText: 'ID Number',
                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Color(0xFF01055C),
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: const Color(0xFFCDCCF6),
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      color: const Color(0xFF060606),
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                validator: _model.iDnumberInputTextControllerValidator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller: _model.cellNumberInputTextController,
                                                focusNode: _model.cellNumberInputFocusNode,
                                                autofocus: false,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: const Color(0xFF070708),
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText: 'Cell Number (e.g. 27836850208)',
                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Color(0xFF01055C),
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: const Color(0xFFCDCCF6),
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      color: const Color(0xFF060606),
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.phone,
                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                validator: _model.cellNumberInputTextControllerValidator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller: _model.vehicleRegistrationTextController,
                                                focusNode: _model.vehicleRegistrationFocusNode,
                                                autofocus: false,
                                                textCapitalization: TextCapitalization.characters,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: const Color(0xFF070708),
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText: 'Vehicle Registration',
                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Color(0xFF01055C),
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: const Color(0xFFCDCCF6),
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      color: const Color(0xFF060606),
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                validator: _model.vehicleRegistrationTextControllerValidator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller: _model.homeTownInputTextController,
                                                focusNode: _model.homeTownInputFocusNode,
                                                autofocus: false,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: const Color(0xFF070708),
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText: 'Home Town',
                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Color(0xFF01055C),
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: const Color(0xFFCDCCF6),
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      color: const Color(0xFF060606),
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                validator: _model.homeTownInputTextControllerValidator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 5.0,
                                            color: Color(0xFF3D39D2),
                                          ),
                                          Text(
                                            'Your PayPal Pay Me Link:',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w900,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                  fontSize: 22.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller: _model.textController7,
                                                focusNode: _model.textFieldFocusNode,
                                                autofocus: false,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: const Color(0xFF070708),
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText: 'My PaypalPayMeLink',
                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Color(0xFF01055C),
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: const Color(0xFFCDCCF6),
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      color: const Color(0xFF060606),
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                validator: _model.textController7Validator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Create free PayPal account for instant payments',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await launchURL('https://www.paypal.com/us/welcome/signup/#/country_selection');
                                            },
                                            child: Text(
                                              'Create account ',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight: FontWeight.w600,
                                                      fontStyle: FontStyle.italic,
                                                    ),
                                                    color: const Color(0xFF030392),
                                                    letterSpacing: 0.0,
                                                    decoration: TextDecoration.underline,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                                            child: Text(
                                              'Banking details only needed for payments made to users for completed Rides, Refunds and Bookings',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller: _model.bankNameInputTextController,
                                                focusNode: _model.bankNameInputFocusNode,
                                                autofocus: false,
                                                textCapitalization: TextCapitalization.words,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: const Color(0xFF070708),
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText: 'Bank Name',
                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Color(0xFF01055C),
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: const Color(0xFFCDCCF6),
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      color: const Color(0xFF060606),
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                validator: _model.bankNameInputTextControllerValidator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller: _model.accHolderNameInputTextController,
                                                focusNode: _model.accHolderNameInputFocusNode,
                                                autofocus: false,
                                                textCapitalization: TextCapitalization.words,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: const Color(0xFF070708),
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText: 'Acc Holder Name',
                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Color(0xFF01055C),
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: const Color(0xFFCDCCF6),
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      color: const Color(0xFF060606),
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                validator: _model.accHolderNameInputTextControllerValidator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller: _model.accNumberInputTextController,
                                                focusNode: _model.accNumberInputFocusNode,
                                                autofocus: false,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: const Color(0xFF070708),
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText: 'Account Number',
                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Color(0xFF01055C),
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: const Color(0xFFCDCCF6),
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      color: const Color(0xFF060606),
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                validator: _model.accNumberInputTextControllerValidator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: SizedBox(
                                              width: 200.0,
                                              child: TextFormField(
                                                controller: _model.branchCodeInputTextController,
                                                focusNode: _model.branchCodeInputFocusNode,
                                                autofocus: false,
                                                textInputAction: TextInputAction.next,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: const Color(0xFF070708),
                                                        letterSpacing: 0.0,
                                                      ),
                                                  hintText: 'Branch Code',
                                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FontStyle.italic,
                                                        ),
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                      ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Color(0xFF01055C),
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme.of(context).error,
                                                      width: 4.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: const Color(0xFFCDCCF6),
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                      color: const Color(0xFF060606),
                                                      letterSpacing: 0.0,
                                                    ),
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                validator: _model.branchCodeInputTextControllerValidator.asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(24, 20, 24, 40),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      context.pushNamed(LoginPageWidget.routeName);
                                                    },
                                                    text: 'Cancel',
                                                    options: FFButtonOptions(
                                                      height: 50.0,
                                                      color: FlutterFlowTheme.of(context).alternate,
                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                            font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                          ),
                                                      elevation: 0.0,
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 16.0),
                                                Expanded(
                                                  child: StreamBuilder<List<UsersRow>>(
                                                    stream: streamUserByUid(currentUserUid),
                                                    builder: (context, snapshot) {
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
                                                      return FFButtonWidget(
                                                        onPressed: () async {
                                                          final cell = _model.cellNumberInputTextController.text.trim();
                                                          if (!cell.startsWith('27') || cell.length < 11) {
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('Invalid Cell Number. Must start with 27 (e.g. 27836850208)')),
                                                            );
                                                            return;
                                                          }

                                                          await UsersTable().insert({
                                                            'uid': currentUserUid,
                                                            'AccountCreatedDate': supaSerialize<DateTime>(getCurrentTimestamp),
                                                            'BankName': _model.bankNameInputTextController.text,
                                                            'BranchCode': _model.branchCodeInputTextController.text,
                                                            'CellNumber': _model.cellNumberInputTextController.text,
                                                            'FirstName': _model.firstNameInputTextController.text,
                                                            'HomeTown': _model.homeTownInputTextController.text,
                                                            'IDNumber': _model.iDnumberInputTextController.text,
                                                            'IsSignupPaid': true,
                                                            'Surname': _model.surnameInputTextController.text,
                                                            'email': currentUserEmail,
                                                            'display_name': '',
                                                            'photo_url': '',
                                                            'created_time': supaSerialize<DateTime>(getCurrentTimestamp),
                                                            'AccHolderName': _model.accHolderNameInputTextController.text,
                                                            'AccountNumber': _model.accNumberInputTextController.text,
                                                            'PaypalPayMeLink': _model.textController7.text,
                                                            'VehicleRegistration': _model.vehicleRegistrationTextController.text,
                                                          });
                                                          if (!context.mounted) return;
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Account Successfully Created!!',
                                                                style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
                                                              ),
                                                              duration: const Duration(milliseconds: 5000),
                                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                            ),
                                                          );
                                                          context.pushNamed(HomePageWidget.routeName);
                                                        },
                                                        text: 'Submit',
                                                        options: FFButtonOptions(
                                                          height: 50.0,
                                                          color: FlutterFlowTheme.of(context).primary,
                                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                font: GoogleFonts.interTight(fontWeight: FontWeight.bold),
                                                                color: Colors.white,
                                                              ),
                                                          elevation: 2.0,
                                                          borderRadius: BorderRadius.circular(12.0),
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
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
