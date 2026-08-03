import '/flutter_flow/flutter_flow_util.dart';
import 'payment_page_widget.dart' show PaymentPageWidget;
import 'package:flutter/material.dart';

class PaymentPageModel extends FlutterFlowModel<PaymentPageWidget> {
  // Amount controllers
  TextEditingController? customAmountTextController;
  FocusNode? customAmountFocusNode;
  
  TextEditingController? customAmountController;
  FocusNode? customAmountFocusNode2;

  // Card details controllers
  TextEditingController? cardNumberTextController;
  FocusNode? cardNumberFocusNode;
  
  TextEditingController? expiryDateTextController;
  FocusNode? expiryDateFocusNode;
  
  TextEditingController? cvvTextController;
  FocusNode? cvvFocusNode;

  bool isNativeProcessing = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    customAmountTextController?.dispose();
    customAmountFocusNode?.dispose();
    customAmountController?.dispose();
    customAmountFocusNode2?.dispose();
    cardNumberTextController?.dispose();
    cardNumberFocusNode?.dispose();
    expiryDateTextController?.dispose();
    expiryDateFocusNode?.dispose();
    cvvTextController?.dispose();
    cvvFocusNode?.dispose();
  }
}
