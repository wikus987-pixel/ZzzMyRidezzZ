import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_profile_page_model.dart';
export 'edit_profile_page_model.dart';

class EditProfilePageWidget extends StatefulWidget {
  const EditProfilePageWidget({super.key, this.userID});
  final String? userID;
  static String routeName = 'EditProfilePage';
  static String routePath = 'editProfilePage';
  @override
  State<EditProfilePageWidget> createState() => _EditProfilePageWidgetState();
}

class _EditProfilePageWidgetState extends State<EditProfilePageWidget> {
  late EditProfilePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _cellController = TextEditingController();
  final _homeTownController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _vehicleController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accHolderController = TextEditingController();
  final _accNumberController = TextEditingController();
  final _branchCodeController = TextEditingController();
  final _paypalController = TextEditingController();

  bool _fieldsInitialised = false;
  bool _saving = false;

  late final Future<List<UsersRow>> _userFuture;

  String get _targetUid =>
      (widget.userID != null && widget.userID!.isNotEmpty)
          ? widget.userID!
          : currentUserUid;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfilePageModel());
    _userFuture = UsersTable()
        .queryRows(queryFn: (q) => q.eq('uid', _targetUid).limit(1));
  }

  @override
  void dispose() {
    _model.dispose();
    _firstNameController.dispose();
    _surnameController.dispose();
    _cellController.dispose();
    _homeTownController.dispose();
    _idNumberController.dispose();
    _vehicleController.dispose();
    _bankNameController.dispose();
    _accHolderController.dispose();
    _accNumberController.dispose();
    _branchCodeController.dispose();
    _paypalController.dispose();
    super.dispose();
  }

  void _populate(UsersRow user) {
    if (_fieldsInitialised) return;
    _firstNameController.text = user.firstName ?? '';
    _surnameController.text = user.surname ?? '';
    _cellController.text = user.cellNumber ?? '';
    _homeTownController.text = user.homeTown ?? '';
    _idNumberController.text = user.iDNumber ?? '';
    _vehicleController.text = user.vehicleRegistration ?? '';
    _bankNameController.text = user.bankName ?? '';
    _accHolderController.text = user.accHolderName ?? '';
    _accNumberController.text = user.accountNumber ?? '';
    _branchCodeController.text = user.branchCode ?? '';
    _paypalController.text = user.paypalPayMeLink ?? '';
    _fieldsInitialised = true;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await UsersTable().update(
        data: {
          'FirstName': _firstNameController.text.trim(),
          'Surname': _surnameController.text.trim(),
          'CellNumber': _cellController.text.trim(),
          'HomeTown': _homeTownController.text.trim(),
          'IDNumber': _idNumberController.text.trim(),
          'VehicleRegistration': _vehicleController.text.trim(),
          'BankName': _bankNameController.text.trim(),
          'AccHolderName': _accHolderController.text.trim(),
          'AccountNumber': _accNumberController.text.trim(),
          'BranchCode': _branchCodeController.text.trim(),
          'PaypalPayMeLink': _paypalController.text.trim(),
        },
        matchingRows: (q) => q.eq('uid', _targetUid),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not save profile: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _field(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: FlutterFlowTheme.of(context).bodyMedium,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: FlutterFlowTheme.of(context).labelMedium,
          filled: true,
          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).primary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 40.0,
                        fillColor: Colors.transparent,
                        icon: Icon(Icons.arrow_back_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0),
                        onPressed: () => context.safePop(),
                      ),
                      const SizedBox(width: 16.0),
                      Text('Edit Profile',
                          style: FlutterFlowTheme.of(context)
                              .titleLarge
                              .override(
                                  font: GoogleFonts.interTight(
                                      fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<UsersRow>>(
                  future: _userFuture,
                  builder: (context, userSnapshot) {
                    if (!userSnapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final userRows = userSnapshot.data!;
                    final userProfile =
                        userRows.isNotEmpty ? userRows.first : null;
                    if (userProfile == null) {
                      return const Center(
                          child: Text('No profile found for this account.'));
                    }
                    _populate(userProfile);
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Personal Information',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                      font: GoogleFonts.interTight(
                                          fontWeight: FontWeight.bold))),
                          _field('First Name', _firstNameController),
                          _field('Surname', _surnameController),
                          _field('Cell Number', _cellController,
                              keyboardType: TextInputType.phone),
                          _field('ID Number', _idNumberController),
                          _field('Home Town', _homeTownController),
                          _field('Vehicle Registration', _vehicleController),
                          const SizedBox(height: 16.0),
                          Text('Banking Details',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                      font: GoogleFonts.interTight(
                                          fontWeight: FontWeight.bold))),
                          _field('Bank Name', _bankNameController),
                          _field('Account Holder', _accHolderController),
                          _field('Account Number', _accNumberController,
                              keyboardType: TextInputType.number),
                          _field('Branch Code', _branchCodeController,
                              keyboardType: TextInputType.number),
                          _field('PayPal PayMe Link', _paypalController),
                          const SizedBox(height: 24.0),
                          FFButtonWidget(
                            onPressed: _saving ? null : () => _save(),
                            text: _saving ? 'Saving...' : 'Save Changes',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 48.0,
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                      font: GoogleFonts.interTight(
                                          fontWeight: FontWeight.bold),
                                      color: Colors.white),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
