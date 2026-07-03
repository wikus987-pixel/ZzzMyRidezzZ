import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'screen3_widget.dart' show Screen3Widget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Screen3Model extends FlutterFlowModel<Screen3Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for firstName_Input widget.
  FocusNode? firstNameInputFocusNode;
  TextEditingController? firstNameInputTextController;
  String? Function(BuildContext, String?)?
      firstNameInputTextControllerValidator;
  // State field(s) for Surname_Input widget.
  FocusNode? surnameInputFocusNode;
  TextEditingController? surnameInputTextController;
  String? Function(BuildContext, String?)? surnameInputTextControllerValidator;
  // State field(s) for IDnumber_Input widget.
  FocusNode? iDnumberInputFocusNode;
  TextEditingController? iDnumberInputTextController;
  String? Function(BuildContext, String?)? iDnumberInputTextControllerValidator;
  // State field(s) for CellNumber_Input widget.
  FocusNode? cellNumberInputFocusNode;
  TextEditingController? cellNumberInputTextController;
  String? Function(BuildContext, String?)?
      cellNumberInputTextControllerValidator;
  // State field(s) for VehicleRegistration widget.
  FocusNode? vehicleRegistrationFocusNode;
  TextEditingController? vehicleRegistrationTextController;
  String? Function(BuildContext, String?)?
      vehicleRegistrationTextControllerValidator;
  // State field(s) for HomeTown_Input widget.
  FocusNode? homeTownInputFocusNode;
  TextEditingController? homeTownInputTextController;
  String? Function(BuildContext, String?)? homeTownInputTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController7;
  String? Function(BuildContext, String?)? textController7Validator;
  // State field(s) for BankName_Input widget.
  FocusNode? bankNameInputFocusNode;
  TextEditingController? bankNameInputTextController;
  String? Function(BuildContext, String?)? bankNameInputTextControllerValidator;
  // State field(s) for AccHolderName_Input widget.
  FocusNode? accHolderNameInputFocusNode;
  TextEditingController? accHolderNameInputTextController;
  String? Function(BuildContext, String?)?
      accHolderNameInputTextControllerValidator;
  // State field(s) for AccNumber_Input widget.
  FocusNode? accNumberInputFocusNode;
  TextEditingController? accNumberInputTextController;
  String? Function(BuildContext, String?)?
      accNumberInputTextControllerValidator;
  // State field(s) for BranchCode_Input widget.
  FocusNode? branchCodeInputFocusNode;
  TextEditingController? branchCodeInputTextController;
  String? Function(BuildContext, String?)?
      branchCodeInputTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    firstNameInputFocusNode?.dispose();
    firstNameInputTextController?.dispose();

    surnameInputFocusNode?.dispose();
    surnameInputTextController?.dispose();

    iDnumberInputFocusNode?.dispose();
    iDnumberInputTextController?.dispose();

    cellNumberInputFocusNode?.dispose();
    cellNumberInputTextController?.dispose();

    vehicleRegistrationFocusNode?.dispose();
    vehicleRegistrationTextController?.dispose();

    homeTownInputFocusNode?.dispose();
    homeTownInputTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController7?.dispose();

    bankNameInputFocusNode?.dispose();
    bankNameInputTextController?.dispose();

    accHolderNameInputFocusNode?.dispose();
    accHolderNameInputTextController?.dispose();

    accNumberInputFocusNode?.dispose();
    accNumberInputTextController?.dispose();

    branchCodeInputFocusNode?.dispose();
    branchCodeInputTextController?.dispose();
  }
}
