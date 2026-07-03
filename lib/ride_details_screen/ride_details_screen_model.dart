import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'ride_details_screen_widget.dart' show RideDetailsScreenWidget;
import 'package:flutter/material.dart';

class RideDetailsScreenModel extends FlutterFlowModel<RideDetailsScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  int? dropDownValue;
  FormFieldController<int>? dropDownValueController;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  PendingPaymentsRow? pending;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
