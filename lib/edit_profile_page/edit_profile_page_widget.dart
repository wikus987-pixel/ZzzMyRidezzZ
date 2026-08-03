import 'package:ride_share_supa/auth/supabase_auth/auth_util.dart';
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_icon_button.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_widgets.dart';
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

  String _formatDate(DateTime? date) {
    if (date == null) return 'Not set';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatRidesCompleted(String? rides) {
    if (rides == null || rides.isEmpty) return '0';
    return rides;
  }

  bool _isRenewalDue(DateTime? createdDate) {
    if (createdDate == null) return false;
    final now = DateTime.now();
    final difference = now.difference(createdDate);
    return difference.inDays >= 365;
  }

  Future<void> _save() async {
    final cell = _cellController.text.trim();
    if (!cell.startsWith('27') || cell.length < 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Cell Number. Must start with 27 (e.g. 27836850208)')),
      );
      return;
    }

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
      {TextInputType keyboardType = TextInputType.text,
      String? hintText,
      TextCapitalization capitalization = TextCapitalization.none}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: capitalization,
        style: FlutterFlowTheme.of(context).bodyMedium,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
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

  Widget _readOnlyField(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        enabled: false,
        style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: FlutterFlowTheme.of(context).labelMedium,
          prefixIcon: Icon(icon, color: FlutterFlowTheme.of(context).alternate),
          filled: true,
          fillColor: FlutterFlowTheme.of(context).alternate.withValues(alpha: 0.3),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1.0,
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
                          Text('Account Information',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                      font: GoogleFonts.interTight(
                                          fontWeight: FontWeight.bold))),
                          _readOnlyField('Account Created',
                              _formatDate(userProfile.accountCreatedDate),
                              Icons.calendar_today),
                          _readOnlyField('Completed Rides',
                              _formatRidesCompleted(userProfile.ridesCompleted),
                              Icons.directions_car),
                          if (_isRenewalDue(userProfile.accountCreatedDate))
                            Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFCC80).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFFFCC80)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.warning_amber_rounded,
                                      color: Color(0xFFFFCC80), size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Yearly renewal is due! Your account was created over a year ago.',
                                      style: TextStyle(
                                        color: Colors.orange[900],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 24.0),
                          Text('Personal Information',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                      font: GoogleFonts.interTight(
                                          fontWeight: FontWeight.bold))),
                          _field('First Name', _firstNameController),
                          _field('Surname', _surnameController),
                          _field('Cell Number', _cellController,
                              keyboardType: TextInputType.phone,
                              hintText: 'e.g. 27836850208'),
                          _field('ID Number', _idNumberController),
                          _field('Home Town', _homeTownController),
                          _field('Vehicle Registration', _vehicleController,
                              capitalization: TextCapitalization.characters),
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
                          const SizedBox(height: 16),
                          FFButtonWidget(
                            onPressed: _model.isDeleting ? null : () => _showDeleteConfirmation(),
                            text: _model.isDeleting ? 'Deleting...' : 'Delete Account',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 48.0,
                              color: FlutterFlowTheme.of(context).error,
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

  Future<void> _showDeleteConfirmation() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete your account?'),
                Text('This action cannot be undone.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    setState(() => _model.isDeleting = true);
    try {
      final uid = _targetUid;
      
      // Update the user to request deletion instead of immediate delete
      await UsersTable().update(
        data: {
          'deletion_requested': true,
        },
        matchingRows: (q) => q.eq('uid', uid),
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Deletion request sent to admin for verification.'),
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to request deletion: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _model.isDeleting = false);
    }
  }
}
