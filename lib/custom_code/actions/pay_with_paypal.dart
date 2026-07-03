// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

// PayPal Sandbox REST API credentials for the "RideShare" app.
//
// NOTE: this package requires the client id + secret inside the app. That is
// acceptable for SANDBOX testing. Before going LIVE, move the secret to a
// server and never ship it inside the APK.
const String kPaypalSandboxMode = 'sandbox';
const String kPaypalClientId =
    'AW9m1uo9cdFCM2BznfNSKn6D5JBWn2l5IWnk4uDIfN1VE0BnCsNEDrjHWMDOjr7Dxs12V8HrKgFQAsNK';
const String kPaypalSecret =
    'EKiokA0lKSiM10-rsP4Z7ZnKXyqAj7nEDN2XwWzNxaE1zDGP6oS-MiFusU3FdVXyy5N7LP32LFZTWKOk';

/// Opens the PayPal checkout for [usdAmount] (US dollars) and resolves to true
/// only when the payment completes successfully. The buyer sees dollars on
/// PayPal's page (PayPal has no rand); everywhere else the app shows rand.
Future<bool> payWithPaypal(
  BuildContext context,
  double usdAmount,
  String description,
) async {
  final amountStr = usdAmount.toStringAsFixed(2);
  final completer = Completer<bool>();

  void finish(bool result) {
    if (!completer.isCompleted) {
      completer.complete(result);
    }
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: kPaypalClientId,
        secretKey: kPaypalSecret,
        transactions: [
          {
            'amount': {
              'total': amountStr,
              'currency': 'USD',
              'details': {
                'subtotal': amountStr,
                'shipping': '0',
                'shipping_discount': '0',
              },
            },
            'description': description,
            'item_list': {
              'items': [
                {
                  'name': description,
                  'quantity': 1,
                  'price': amountStr,
                  'currency': 'USD',
                },
              ],
            },
          },
        ],
        note: 'RideShare payment',
        onSuccess: (Map params) async {
          finish(true);
        },
        onError: (error) {
          finish(false);
        },
        onCancel: () {
          finish(false);
        },
      ),
    ),
  );

  return completer.future;
}
