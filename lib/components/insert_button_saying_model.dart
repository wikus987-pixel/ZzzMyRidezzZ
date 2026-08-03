import 'package:ride_share_supa/components/button4_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'insert_button_saying_widget.dart' show InsertButtonSayingWidget;
import 'package:flutter/material.dart';

class InsertButtonSayingModel
    extends FlutterFlowModel<InsertButtonSayingWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button4Model buttonModel1;
  // Model for Button.
  late Button4Model buttonModel2;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => Button4Model());
    buttonModel2 = createModel(context, () => Button4Model());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
