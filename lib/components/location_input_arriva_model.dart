import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'location_input_arriva_widget.dart' show LocationInputArrivaWidget;
import 'package:flutter/material.dart';

class LocationInputArrivaModel
    extends FlutterFlowModel<LocationInputArrivaWidget> {
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
