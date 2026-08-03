// Automatic FlutterFlow imports
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class YocoPaymentResult {
  final bool success;
  final String? checkoutId;
  final String? errorMessage;

  YocoPaymentResult({required this.success, this.checkoutId, this.errorMessage});
}

Future<YocoPaymentResult> payWithYoco({
  required BuildContext context,
  required double amount, // In ZAR (e.g., 45.00)
  required String description,
  Map<String, dynamic>? metadata,
}) async {
  try {
    final String secretKey = 'yoco_live_c40297e972327aae_93c3433b67493d429962c658d40eea49';
    final int amountInCents = (amount * 100).round();

    final response = await http.post(
      Uri.parse('https://payments.yoco.com/api/checkouts'),
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'amount': amountInCents,
        'currency': 'ZAR',
        'successUrl': 'ridesharel://yoco-success',
        'cancelUrl': 'ridesharel://yoco-cancel',
        'failureUrl': 'ridesharel://yoco-failure',
        'metadata': metadata ?? {},
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final String? redirectUrl = data['redirectUrl'];
      final String? checkoutId = data['id'];

      if (redirectUrl != null) {
        final launched = await launchUrl(
          Uri.parse(redirectUrl),
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          return YocoPaymentResult(success: true, checkoutId: checkoutId);
        } else {
          return YocoPaymentResult(
            success: false,
            errorMessage: 'Could not open secure payment page.',
          );
        }
      } else {
        return YocoPaymentResult(
          success: false,
          errorMessage: 'Invalid response from Yoco: Missing redirect URL.',
        );
      }
    } else {
      final errorData = jsonDecode(response.body);
      return YocoPaymentResult(
        success: false,
        errorMessage: errorData['message'] ?? 'Failed to create Yoco checkout session (${response.statusCode}).',
      );
    }
  } catch (e) {
    return YocoPaymentResult(
      success: false,
      errorMessage: 'Payment Error: ${e.toString()}',
    );
  }
}
