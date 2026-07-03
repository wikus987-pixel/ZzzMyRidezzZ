import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'location_input_arriva_widget.dart' show LocationInputArrivaWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
