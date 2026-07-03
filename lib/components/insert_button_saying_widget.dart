import '/components/button4_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'insert_button_saying_model.dart';
export 'insert_button_saying_model.dart';

/// insert button saying send proof of payment and open users default mail
/// client with to address alreadyy set to rideshare8855@gmail.com.
///
/// put it under the paynow button
class InsertButtonSayingWidget extends StatefulWidget {
  const InsertButtonSayingWidget({super.key});

  @override
  State<InsertButtonSayingWidget> createState() =>
      _InsertButtonSayingWidgetState();
}

class _InsertButtonSayingWidgetState extends State<InsertButtonSayingWidget> {
  late InsertButtonSayingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InsertButtonSayingModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        wrapWithModel(
          model: _model.buttonModel1,
          updateCallback: () => safeSetState(() {}),
          child: Button4Widget(
            iconPresent: false,
            iconEndPresent: false,
            content: 'Pay Now',
            variant: 'primary',
            size: 'medium',
            fullWidth: true,
            loading: false,
            disabled: false,
          ),
        ),
        wrapWithModel(
          model: _model.buttonModel2,
          updateCallback: () => safeSetState(() {}),
          child: Button4Widget(
            icon: Icon(
              Icons.mail_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            iconPresent: true,
            iconEndPresent: false,
            content: 'Send Proof of Payment',
            variant: 'outline',
            size: 'medium',
            fullWidth: true,
            loading: false,
            disabled: false,
          ),
        ),
      ].divide(SizedBox(height: 16.0)),
    );
  }
}
