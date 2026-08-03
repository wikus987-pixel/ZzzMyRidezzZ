import 'package:ride_share_supa/components/switch_component2_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'toggle_switch_verified_widget.dart' show ToggleSwitchVerifiedWidget;
import 'package:flutter/material.dart';

class ToggleSwitchVerifiedModel
    extends FlutterFlowModel<ToggleSwitchVerifiedWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Switch.
  late SwitchComponent2Model switchModel;

  @override
  void initState(BuildContext context) {
    switchModel = createModel(context, () => SwitchComponent2Model());
  }

  @override
  void dispose() {
    switchModel.dispose();
  }
}
