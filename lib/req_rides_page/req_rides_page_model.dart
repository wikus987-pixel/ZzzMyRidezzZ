import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:ride_share_supa/components/location_input_widget.dart';
import 'package:ride_share_supa/components/location_input_arriva_widget.dart';
import 'package:ride_share_supa/components/datetime_picker_widget.dart';
import 'req_rides_page_widget.dart' show ReqRidesPageWidget;
import 'package:flutter/material.dart';

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

  // Selected date-times
  DateTime? departureDateTime;
  DateTime? arrivalDateTime;

  // Local state for seats needed
  int seatsNeeded = 0;
  int parcelsNeeded = 0;

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
