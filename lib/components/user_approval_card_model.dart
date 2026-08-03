import 'package:ride_share_supa/components/toggle_switch_verified_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'user_approval_card_widget.dart' show UserApprovalCardWidget;
import 'package:flutter/material.dart';

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
