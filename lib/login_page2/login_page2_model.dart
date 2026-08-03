import 'package:ride_share_supa/components/button6_widget.dart';
import 'package:ride_share_supa/components/text_field3_widget.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'login_page2_widget.dart' show LoginPage2Widget;
import 'package:flutter/material.dart';

class LoginPage2Model extends FlutterFlowModel<LoginPage2Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextField3Model textFieldModel1;
  // Model for TextField.
  late TextField3Model textFieldModel2;
  // Model for Button.
  late Button6Model buttonModel1;
  // Model for Button.
  late Button6Model buttonModel2;

  @override
  void initState(BuildContext context) {
    textFieldModel1 = createModel(context, () => TextField3Model());
    textFieldModel2 = createModel(context, () => TextField3Model());
    buttonModel1 = createModel(context, () => Button6Model());
    buttonModel2 = createModel(context, () => Button6Model());
  }

  @override
  void dispose() {
    textFieldModel1.dispose();
    textFieldModel2.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
