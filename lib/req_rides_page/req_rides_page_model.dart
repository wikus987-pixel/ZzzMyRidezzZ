import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/datetime_picker_widget.dart';
import '/components/location_input_arriva_widget.dart';
import '/components/location_input_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'req_rides_page_widget.dart' show ReqRidesPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReqRidesPageModel extends FlutterFlowModel<ReqRidesPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for LocationInput component.
  late LocationInputModel locationInputModel;
  // Model for LocationInputArriva component.
  late LocationInputArrivaModel locationInputArrivaModel;
  // Model for DatetimePicker.
  late DatetimePickerModel datetimePickerModel1;
  // Model for DatetimePicker.
  late DatetimePickerModel datetimePickerModel2;
  // Model for DatetimePicker.
  late DatetimePickerModel datetimePickerModel3;
  // Model for DatetimePicker.
  late DatetimePickerModel datetimePickerModel4;

  @override
  void initState(BuildContext context) {
    locationInputModel = createModel(context, () => LocationInputModel());
    locationInputArrivaModel =
        createModel(context, () => LocationInputArrivaModel());
    datetimePickerModel1 = createModel(context, () => DatetimePickerModel());
    datetimePickerModel2 = createModel(context, () => DatetimePickerModel());
    datetimePickerModel3 = createModel(context, () => DatetimePickerModel());
    datetimePickerModel4 = createModel(context, () => DatetimePickerModel());
  }

  @override
  void dispose() {
    locationInputModel.dispose();
    locationInputArrivaModel.dispose();
    datetimePickerModel1.dispose();
    datetimePickerModel2.dispose();
    datetimePickerModel3.dispose();
    datetimePickerModel4.dispose();
  }
}
