import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'location_input_widget.dart' show LocationInputWidget;
import 'package:flutter/material.dart';

class LocationInputModel extends FlutterFlowModel<LocationInputWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Text widget.
  FocusNode? textFocusNode;
  TextEditingController? textTextController;
  String? Function(BuildContext, String?)? textTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFocusNode?.dispose();
    textTextController?.dispose();
  }
}
