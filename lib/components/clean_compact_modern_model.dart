import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/components/button5_widget.dart';
import 'package:ride_share_supa/components/text_field2_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'clean_compact_modern_widget.dart' show CleanCompactModernWidget;
import 'package:flutter/material.dart';

class CleanCompactModernModel
    extends FlutterFlowModel<CleanCompactModernWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for TextField.
  late TextField2Model textFieldModel;
  // Model for Button.
  late Button5Model buttonModel;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<VerifiedPaymentsRow>? foundUser;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextField2Model());
    buttonModel = createModel(context, () => Button5Model());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    buttonModel.dispose();
  }
}
