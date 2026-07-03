import '/components/switch_component2_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'toggle_switch_verified_widget.dart' show ToggleSwitchVerifiedWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
