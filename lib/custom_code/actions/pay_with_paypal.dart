// Automatic FlutterFlow imports
import 'package:flutter/material.dart';
import 'package:ride_share_supa/custom_code/actions/pay_with_paypal_direct.dart';
import 'package:ride_share_supa/custom_code/actions/paypal_result.dart';
import 'dart:async';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<PayPalPaymentResult> payWithPaypal({
  required BuildContext context,
  required double usdAmount,
  required String description,
}) async {
  // Call the actual direct implementation using WebView
  return await payWithPaypalDirect(
    context: context,
    usdAmount: usdAmount,
    description: description,
  );
}

// Simple version for compatibility
Future<bool> payWithPaypalSimple({
  required BuildContext context,
  required double usdAmount,
  required String description,
}) async {
  final res = await payWithPaypal(context: context, usdAmount: usdAmount, description: description);
  return res.success;
}
