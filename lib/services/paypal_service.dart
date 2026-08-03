import 'package:flutter/material.dart';
import 'package:ride_share_supa/custom_code/actions/pay_with_paypal.dart';

class PayPalService {
  // Your PayPal Client ID
  static const String clientId =
      "AW9m1uo9cdFCM2BznfNSKn6D5JBWn2l5IWnk4uDIfN1VE0BnCsNEDrjHWMDOjr7Dxs12V8HrKgFQAsNK";

  /// Process payment with PayPal
  /// [amount] - Payment amount (e.g., "9.99")
  /// [currency] - Currency code (e.g., "USD")
  /// [description] - Payment description
  /// [context] - BuildContext for navigation
  static Future<bool> processPayment({
    required String amount,
    required String currency,
    required String description,
    required BuildContext context,
  }) async {
    try {
      final result = await payWithPaypal(
        context: context,
        usdAmount: double.parse(amount),
        description: description,
      );
      return result.success;
    } catch (e) {
      debugPrint("Payment error: \$e");
      return false;
    }
  }

  /// Process payment for ride fare
  static Future<bool> processRidePayment({
    required String rideAmount,
    required String rideId,
    required String driverName,
    required BuildContext context,
  }) async {
    return processPayment(
      amount: rideAmount,
      currency: "USD",
      description: "RideShare Payment - Driver: $driverName (Ride ID: $rideId)",
      context: context,
    );
  }

  /// Process payment for in-app services
  static Future<bool> processServicePayment({
    required String amount,
    required String serviceType,
    required BuildContext context,
  }) async {
    return processPayment(
      amount: amount,
      currency: "USD",
      description: "RideShare $serviceType Payment",
      context: context,
    );
  }
}
