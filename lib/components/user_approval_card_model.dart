import '/components/toggle_switch_verified_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'user_approval_card_widget.dart' show UserApprovalCardWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserApprovalCardModel extends FlutterFlowModel<UserApprovalCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ToggleSwitchVerified component.
  late ToggleSwitchVerifiedModel toggleSwitchVerifiedModel;

  @override
  void initState(BuildContext context) {
    toggleSwitchVerifiedModel =
        createModel(context, () => ToggleSwitchVerifiedModel());
  }

  @override
  void dispose() {
    toggleSwitchVerifiedModel.dispose();
  }
}
