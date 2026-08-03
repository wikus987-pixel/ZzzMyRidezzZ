import 'package:ride_share_supa/auth/supabase_auth/auth_util.dart';
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/components/text_field_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'personal_info_section_model.dart';
export 'personal_info_section_model.dart';

class PersonalInfoSectionWidget extends StatefulWidget {
  const PersonalInfoSectionWidget({
    super.key,
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.bankName = '',
    this.accountHolder = '',
    this.accountNumber = '',
    this.paypalpaymelink,
  });

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
  Stream<List<UsersRow>>? _userStream;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PersonalInfoSectionModel());
    _initializeStream();
  }

  void _initializeStream() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      setState(() {
        _userStream = SupaFlow.client
            .from('users')
            .stream(primaryKey: ['id'])
            .eq('uid', currentUserUid)
            .map((rows) => rows.map((r) => UsersRow(r)).toList());
      });
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UsersRow>>(
      stream: _userStream ?? const Stream.empty(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Profile connection lost'),
                TextButton(
                  onPressed: () => _initializeStream(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        final userList = snapshot.data ?? [];
        if (userList.isEmpty) {
          return const Center(child: Text('No profile data found.'));
        }
        final user = userList.first;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionHeader(context, Icons.person_outline_rounded, 'Personal Information', FlutterFlowTheme.of(context).primary),
            const SizedBox(height: 12),
            _buildCard(context, [
              wrapWithModel(
                model: _model.userCardFullNameModel,
                updateCallback: () => safeSetState(() {}),
                child: TextFieldWidget(
                  label: 'Full Name',
                  labelPresent: true,
                  leadingIcon: const Icon(Icons.person_rounded, size: 24.0),
                  leadingIconPresent: true,
                  value: '${user.firstName} ${user.surname}',
                  variant: 'filled',
                ),
              ),
              wrapWithModel(
                model: _model.userCardEmaiModel,
                updateCallback: () => safeSetState(() {}),
                child: TextFieldWidget(
                  label: 'Email Address',
                  labelPresent: true,
                  leadingIcon: const Icon(Icons.email_rounded, size: 24.0),
                  leadingIconPresent: true,
                  value: user.email ?? '',
                  variant: 'filled',
                ),
              ),
              wrapWithModel(
                model: _model.userCardCellNrModel,
                updateCallback: () => safeSetState(() {}),
                child: TextFieldWidget(
                  label: 'Phone Number',
                  labelPresent: true,
                  leadingIcon: const Icon(Icons.phone_rounded, size: 24.0),
                  leadingIconPresent: true,
                  value: user.cellNumber ?? '',
                  variant: 'filled',
                ),
              ),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader(context, Icons.account_balance_rounded, 'Banking Details', FlutterFlowTheme.of(context).secondary),
            const SizedBox(height: 12),
            _buildCard(context, [
              wrapWithModel(
                model: _model.userCardPayPaylLinkModel,
                updateCallback: () => safeSetState(() {}),
                child: TextFieldWidget(
                  label: 'PayPal PayMe Link',
                  labelPresent: true,
                  leadingIcon: const Icon(Icons.link_rounded, size: 24.0),
                  leadingIconPresent: true,
                  value: user.paypalPayMeLink ?? '',
                  variant: 'filled',
                ),
              ),
              wrapWithModel(
                model: _model.userCardBankNameModel,
                updateCallback: () => safeSetState(() {}),
                child: TextFieldWidget(
                  label: 'Bank Name',
                  labelPresent: true,
                  leadingIcon: const Icon(Icons.account_balance_rounded, size: 24.0),
                  leadingIconPresent: true,
                  value: user.bankName ?? '',
                  variant: 'filled',
                ),
              ),
              wrapWithModel(
                model: _model.userCardBankAccNameModel,
                updateCallback: () => safeSetState(() {}),
                child: TextFieldWidget(
                  label: 'Account Holder',
                  labelPresent: true,
                  leadingIcon: const Icon(Icons.badge_rounded, size: 24.0),
                  leadingIconPresent: true,
                  value: user.accHolderName ?? '',
                  variant: 'filled',
                ),
              ),
              wrapWithModel(
                model: _model.userCardBankAccNrModel,
                updateCallback: () => safeSetState(() {}),
                child: TextFieldWidget(
                  label: 'Account Number',
                  labelPresent: true,
                  leadingIcon: const Icon(Icons.numbers_rounded, size: 24.0),
                  leadingIconPresent: true,
                  value: user.accountNumber ?? '',
                  variant: 'filled',
                ),
              ),
            ]),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, IconData icon, String title, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20.0),
        const SizedBox(width: 8),
        Text(
          title,
          style: FlutterFlowTheme.of(context).titleMedium.override(
                font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                color: FlutterFlowTheme.of(context).primaryText,
              ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate, width: 1.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children.divide(const SizedBox(height: 16.0)),
      ),
    );
  }
}
