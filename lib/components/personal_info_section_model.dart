import 'package:ride_share_supa/components/text_field_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'personal_info_section_widget.dart' show PersonalInfoSectionWidget;
import 'package:flutter/material.dart';

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
