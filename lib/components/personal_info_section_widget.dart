import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'personal_info_section_model.dart';
export 'personal_info_section_model.dart';

/// show the personal info section and use the fileds found in the users
/// collection also put the banking details separate and use the fields also
/// in user collection, just like you added the banking details the firsttime
class PersonalInfoSectionWidget extends StatefulWidget {
  const PersonalInfoSectionWidget({
    super.key,
    String? fullName,
    String? email,
    String? phone,
    String? bankName,
    String? accountHolder,
    String? accountNumber,
    this.paypalpaymelink,
  })  : this.fullName = fullName ?? '',
        this.email = email ?? '',
        this.phone = phone ?? '',
        this.bankName = bankName ?? '',
        this.accountHolder = accountHolder ?? '',
        this.accountNumber = accountNumber ?? '';

  final String fullName;
  final String email;
  final String phone;
  final String bankName;
  final String accountHolder;
  final String accountNumber;
  final String? paypalpaymelink;

  @override
  State<PersonalInfoSectionWidget> createState() =>
      _PersonalInfoSectionWidgetState();
}

class _PersonalInfoSectionWidgetState extends State<PersonalInfoSectionWidget> {
  late PersonalInfoSectionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PersonalInfoSectionModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UsersRow>>(
      stream: SupaFlow.client
          .from('users')
          .stream(primaryKey: ['uid'])
          .eq('uid', currentUserUid)
          .map((rows) => rows.map((r) => UsersRow(r)).toList()),
      builder: (context, snapshot) {
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
        List<UsersRow> columnUsersRowList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final columnUsersRow = columnUsersRowList.isNotEmpty
            ? columnUsersRowList.first
            : null;

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 20.0,
                    ),
                    Text(
                      'Personal Information',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.interTight(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                            lineHeight: 1.4,
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
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
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          wrapWithModel(
                            model: _model.userCardFullNameModel,
                            updateCallback: () => safeSetState(() {}),
                            child: TextFieldWidget(
                              labelPresent: true,
                              helper: '',
                              helperPresent: false,
                              leadingIcon: Icon(
                                Icons.person_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              leadingIconPresent: true,
                              trailingIconPresent: false,
                              hint: 'Type here...',
                              value: widget!.fullName,
                              onChange: '',
                              onSubmit: '',
                              variant: 'filled',
                              error: false,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.userCardEmaiModel,
                            updateCallback: () => safeSetState(() {}),
                            child: TextFieldWidget(
                              label: 'Email Address',
                              labelPresent: true,
                              helper: '',
                              helperPresent: false,
                              leadingIcon: Icon(
                                Icons.email_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              leadingIconPresent: true,
                              trailingIconPresent: false,
                              hint: 'Type here...',
                              value: widget!.email,
                              onChange: '',
                              onSubmit: '',
                              variant: 'filled',
                              error: false,
                            ),
                          ),
                          wrapWithModel(
                            model: _model.userCardCellNrModel,
                            updateCallback: () => safeSetState(() {}),
                            child: TextFieldWidget(
                              label: 'Phone Number',
                              labelPresent: true,
                              helper: '',
                              helperPresent: false,
                              leadingIcon: Icon(
                                Icons.phone_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              leadingIconPresent: true,
                              trailingIconPresent: false,
                              hint: 'Type here...',
                              value: widget!.phone,
                              onChange: '',
                              onSubmit: '',
                              variant: 'filled',
                              error: false,
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_balance_rounded,
                      color: FlutterFlowTheme.of(context).secondary,
                      size: 20.0,
                    ),
                    Text(
                      'Banking Details',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.interTight(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                            lineHeight: 1.4,
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
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
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      child: StreamBuilder<List<UsersRow>>(
                        stream: SupaFlow.client
                            .from('users')
                            .stream(primaryKey: ['uid'])
                            .eq('uid', currentUserUid)
                            .map((rows) =>
                                rows.map((r) => UsersRow(r)).toList()),
                        builder: (context, snapshot) {
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
                          List<UsersRow> columnUsersRowList =
                              snapshot.data!;
                          // Return an empty Container when the item does not exist.
                          if (snapshot.data!.isEmpty) {
                            return Container();
                          }
                          final columnUsersRow =
                              columnUsersRowList.isNotEmpty
                                  ? columnUsersRowList.first
                                  : null;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              wrapWithModel(
                                model: _model.userCardPayPaylLinkModel,
                                updateCallback: () => safeSetState(() {}),
                                child: TextFieldWidget(
                                  label: 'My PayPal PayMe Link',
                                  labelPresent: true,
                                  helper: '',
                                  helperPresent: false,
                                  leadingIcon: Icon(
                                    Icons.numbers_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  leadingIconPresent: true,
                                  trailingIconPresent: false,
                                  hint: 'Type here...',
                                  value: valueOrDefault<String>(
                                    columnUsersRow?.paypalPayMeLink,
                                    'Type here....',
                                  ),
                                  onChange: '',
                                  onSubmit: '',
                                  variant: '',
                                  error: false,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.userCardBankNameModel,
                                updateCallback: () => safeSetState(() {}),
                                child: TextFieldWidget(
                                  label: 'Bank Name',
                                  labelPresent: true,
                                  helper: '',
                                  helperPresent: false,
                                  leadingIcon: Icon(
                                    Icons.account_balance_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  leadingIconPresent: true,
                                  trailingIconPresent: false,
                                  hint: 'Type here...',
                                  value: valueOrDefault<String>(
                                    columnUsersRow?.bankName,
                                    'Type here....',
                                  ),
                                  onChange: '',
                                  onSubmit: '',
                                  variant: 'filled',
                                  error: false,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.userCardBankAccNameModel,
                                updateCallback: () => safeSetState(() {}),
                                child: TextFieldWidget(
                                  label: 'Account Holder',
                                  labelPresent: true,
                                  helper: '',
                                  helperPresent: false,
                                  leadingIcon: Icon(
                                    Icons.badge_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  leadingIconPresent: true,
                                  trailingIconPresent: false,
                                  hint: 'Type here...',
                                  value: valueOrDefault<String>(
                                    columnUsersRow?.accHolderName,
                                    'Account Holder Name',
                                  ),
                                  onChange: '',
                                  onSubmit: '',
                                  variant: 'filled',
                                  error: false,
                                ),
                              ),
                              wrapWithModel(
                                model: _model.userCardBankAccNrModel,
                                updateCallback: () => safeSetState(() {}),
                                child: TextFieldWidget(
                                  label: 'Account Number',
                                  labelPresent: true,
                                  helper: '',
                                  helperPresent: false,
                                  leadingIcon: Icon(
                                    Icons.numbers_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  leadingIconPresent: true,
                                  trailingIconPresent: false,
                                  hint: 'Type here...',
                                  value: valueOrDefault<String>(
                                    columnUsersRow?.accountNumber,
                                    'Type here....',
                                  ),
                                  onChange: '',
                                  onSubmit: '',
                                  variant: 'filled',
                                  error: false,
                                ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ].divide(SizedBox(height: 24.0)),
        );
      },
    );
  }
}
