import '/auth/supabase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/components/datetime_picker_widget.dart';
import '/components/location_input_arriva_widget.dart';
import '/components/location_input_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'create_rides_page_widget.dart' show CreateRidesPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateRidesPageModel extends FlutterFlowModel<CreateRidesPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for LocationInput.
  late LocationInputModel locationInputModel;
  // Model for LocationInputArriva component.
  late LocationInputArrivaModel locationInputArrivaModel;
  // Model for DatetimePicker component.
  late DatetimePickerModel datetimePickerModel1;
  // Model for DatetimePicker component.
  late DatetimePickerModel datetimePickerModel2;
  // Selected departure/arrival date-times captured by the pickers.
  DateTime? departureDateTime;
  DateTime? arrivalDateTime;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;

  @override
  void initState(BuildContext context) {
    locationInputModel = createModel(context, () => LocationInputModel());
    locationInputArrivaModel =
        createModel(context, () => LocationInputArrivaModel());
    datetimePickerModel1 = createModel(context, () => DatetimePickerModel());
    datetimePickerModel2 = createModel(context, () => DatetimePickerModel());
  }

  @override
  void dispose() {
    locationInputModel.dispose();
    locationInputArrivaModel.dispose();
    datetimePickerModel1.dispose();
    datetimePickerModel2.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();
  }
}
