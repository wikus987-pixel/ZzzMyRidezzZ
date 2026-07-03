import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'personal_info_section_widget.dart' show PersonalInfoSectionWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PersonalInfoSectionModel
    extends FlutterFlowModel<PersonalInfoSectionWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for UserCardFullName.
  late TextFieldModel userCardFullNameModel;
  // Model for UserCardEmai.
  late TextFieldModel userCardEmaiModel;
  // Model for UserCardCellNr.
  late TextFieldModel userCardCellNrModel;
  // Model for UserCardPayPaylLink.
  late TextFieldModel userCardPayPaylLinkModel;
  // Model for UserCardBankName.
  late TextFieldModel userCardBankNameModel;
  // Model for UserCardBankAccName.
  late TextFieldModel userCardBankAccNameModel;
  // Model for UserCardBankAccNr.
  late TextFieldModel userCardBankAccNrModel;

  @override
  void initState(BuildContext context) {
    userCardFullNameModel = createModel(context, () => TextFieldModel());
    userCardEmaiModel = createModel(context, () => TextFieldModel());
    userCardCellNrModel = createModel(context, () => TextFieldModel());
    userCardPayPaylLinkModel = createModel(context, () => TextFieldModel());
    userCardBankNameModel = createModel(context, () => TextFieldModel());
    userCardBankAccNameModel = createModel(context, () => TextFieldModel());
    userCardBankAccNrModel = createModel(context, () => TextFieldModel());
  }

  @override
  void dispose() {
    userCardFullNameModel.dispose();
    userCardEmaiModel.dispose();
    userCardCellNrModel.dispose();
    userCardPayPaylLinkModel.dispose();
    userCardBankNameModel.dispose();
    userCardBankAccNameModel.dispose();
    userCardBankAccNrModel.dispose();
  }
}
