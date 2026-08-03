// Automatic FlutterFlow imports
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class PayPalOrderResult {
  final bool success;
  final String? orderId;
  final String? approveUrl;
  final String? errorMessage;
  
  PayPalOrderResult({
    required this.success,
    this.orderId,
    this.approveUrl,
    this.errorMessage,
  });
}

class PayPalCaptureResult {
  final bool success;
  final String? captureId;
  final String? status;
  final String? errorMessage;
  
  PayPalCaptureResult({
    required this.success,
    this.captureId,
    this.status,
    this.errorMessage,
  });
}



Future<PayPalOrderResult> processPayPalPayment({
  required BuildContext context,
  required double usdAmount,
  required String description,
  required String userEmail,
}) async {
  // Delegate to our Supabase function
  final supabaseUrl = Uri.parse('https://empawnadqvmalfqvbkbp.supabase.co/functions/v1/paypal');
  final requestBody = {
    'action': 'create-order',
    'usdAmount': usdAmount,
    'description': description,
    'userEmail': userEmail,
  };

  try {
    final response = await http.post(
      supabaseUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200) {
      return PayPalOrderResult(
        success: false,
        errorMessage: 'Failed to create payment order: ${response.body}',
      );
    }

    final responseData = jsonDecode(response.body);
    if (!responseData['success'] || !responseData.containsKey('approveUrl')) {
      return PayPalOrderResult(
        success: false,
        errorMessage: responseData['error'] ?? 'Unknown error creating order',
      );
    }

    // Note: This function is expected to return an order that can be captured later.
    // But our flow is: create order -> open WebView for approval -> capture later.
    // Since we can't launch a WebView from here and wait, we return the orderId
    // and expect the caller to use verifyPayPalPayment later.
    // However, the current caller (pay_with_paypal.dart) expects to get an orderId
    // and then call verifyPayPalPayment.
    // So we return the orderId.
    // The approveUrl is not used here — the WebView flow is handled elsewhere.
    
    return PayPalOrderResult(
      success: true,
      orderId: responseData['orderId'],
    );
  } catch (e) {
    return PayPalOrderResult(
      success: false,
      errorMessage: e.toString(),
    );
  }
}



Future<PayPalOrderResult> createPayPalOrderIdOnly({
  required double usdAmount,
  required String description,
  required String userEmail,
}) async {
  final supabaseUrl = Uri.parse('https://empawnadqvmalfqvbkbp.supabase.co/functions/v1/paypal');
  final requestBody = {
    'action': 'create-order',
    'usdAmount': usdAmount,
    'description': description,
    'userEmail': userEmail,
  };

  try {
    final response = await http.post(
      supabaseUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200) {
      return PayPalOrderResult(
        success: false,
        errorMessage: 'Failed to create order: ${response.body}',
      );
    }

    final responseData = jsonDecode(response.body);
    if (!responseData['success']) {
      return PayPalOrderResult(
        success: false,
        errorMessage: responseData['error'] ?? 'Unknown error',
      );
    }

    return PayPalOrderResult(
      success: true,
      orderId: responseData['orderId'],
    );
  } catch (e) {
    return PayPalOrderResult(
      success: false,
      errorMessage: e.toString(),
    );
  }
}



Future<PayPalCaptureResult> verifyPayPalPayment({
  required String orderId,
}) async {
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
      return PayPalCaptureResult(
        success: false,
        errorMessage: 'Failed to capture payment: ${response.body}',
      );
    }

    final responseData = jsonDecode(response.body);
    if (!responseData['success']) {
      return PayPalCaptureResult(
        success: false,
        errorMessage: responseData['error'] ?? 'Unknown error',
        status: 'FAILED',
      );
    }

    return PayPalCaptureResult(
      success: true,
      captureId: responseData['captureId'],
      status: responseData['status'] ?? 'UNKNOWN',
    );
  } catch (e) {
    return PayPalCaptureResult(
      success: false,
      errorMessage: e.toString(),
    );
  }
}