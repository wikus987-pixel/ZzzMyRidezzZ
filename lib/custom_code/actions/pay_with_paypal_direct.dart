// Automatic FlutterFlow imports
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ride_share_supa/widgets/paypal_checkout_webview.dart';
import 'package:ride_share_supa/custom_code/actions/paypal_result.dart';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<PayPalPaymentResult> payWithPaypalDirect({
  required BuildContext context,
  required double usdAmount,
  required String description,
}) async {
  // Step 1: Call our Supabase function to create the order and get approveUrl
  final supabaseUrl = Uri.parse('https://empawnadqvmalfqvbkbp.supabase.co/functions/v1/paypal');
  final requestBody = {
    'action': 'create-order',
    'usdAmount': usdAmount,
    'description': description,
    'userEmail': '', // optional
  };

  try {
    final response = await http.post(
      supabaseUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200) {
      return PayPalPaymentResult(
        success: false,
        errorMessage: 'Failed to create payment order: ${response.body}',
      );
    }

    final responseData = jsonDecode(response.body);
    if (!responseData['success'] || !responseData.containsKey('approveUrl')) {
      return PayPalPaymentResult(
        success: false,
        errorMessage: responseData['error'] ?? 'Unknown error creating order',
      );
    }

    final approveUrl = responseData['approveUrl'] as String;

    // Step 2: Launch WebView to let user approve payment
    if (!context.mounted) {
      return PayPalPaymentResult(success: false, errorMessage: 'Context lost');
    }

    // We'll use a Completer to wait for the WebView result via callbacks
    final completer = Completer<PayPalPaymentResult>();

    // Show the WebView and wait for result via callbacks
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PayPalCheckoutWebView(
          approveUrl: approveUrl,
          onSuccess: (orderId) {
            // User approved the payment — now we need to capture it via our backend
            _captureOrderAndComplete(context, orderId, completer);
          },
          onCancel: () {
            if (!completer.isCompleted) {
              completer.complete(
                PayPalPaymentResult(success: false, errorMessage: 'Payment cancelled by user.'),
              );
            }
          },
          onError: (error) {
            if (!completer.isCompleted) {
              completer.complete(
                PayPalPaymentResult(success: false, errorMessage: 'Payment failed: $error'),
              );
            }
          },
        ),
      ),
    );

    return completer.future;
  } catch (e) {
    return PayPalPaymentResult(
      success: false,
      errorMessage: 'Error processing payment: $e',
    );
  }
}

// Helper function to capture the order via backend and complete the future
Future<void> _captureOrderAndComplete(
    BuildContext context,
    String orderId,
    Completer<PayPalPaymentResult> completer,
) async {
  final supabaseUrl = Uri.parse('https://empawnadqvmalfqvbkbp.supabase.co/functions/v1/paypal');
  final requestBody = {
    'action': 'capture-order',
    'orderId': orderId,
  };

  try {
    final response = await http.post(
      supabaseUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200) {
      if (!completer.isCompleted) {
        completer.complete(
          PayPalPaymentResult(
            success: false,
            errorMessage: 'Failed to capture payment: ${response.body}',
          ),
        );
      }
    } else {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        if (!completer.isCompleted) {
          completer.complete(
            PayPalPaymentResult(success: true),
          );
        }
      } else {
        if (!completer.isCompleted) {
          completer.complete(
            PayPalPaymentResult(
              success: false,
              errorMessage: responseData['error'] ?? 'Capture failed',
            ),
          );
        }
      }
    }
  } catch (e) {
    if (!completer.isCompleted) {
      completer.complete(
        PayPalPaymentResult(success: false, errorMessage: 'Error capturing payment: $e'),
      );
    }
  } finally {
    // Always try to pop the navigator if we pushed a route and haven't completed yet
    // We avoid using `mounted` since we're not in a State
    if (!completer.isCompleted) {
      // Prevent double-complete
      if (!completer.isCompleted) {
        completer.complete(
          PayPalPaymentResult(success: false, errorMessage: 'Payment timed out or canceled'),
        );
      }
      // Try to pop the nav stack — safe to call even if already popped
      try {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      } catch (_) {
        // Ignore if navigator is already gone
      }
    }
  }
}