// Automatic FlutterFlow imports
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class PayPalNativeResult {
  final bool success;
  final String? orderId;
  final String? errorMessage;

  PayPalNativeResult({required this.success, this.orderId, this.errorMessage});
}

Future<PayPalNativeResult> paypalNativeCard({
  required String clientId,
  required bool isLive,
  required String orderId,
  required String cardNumber,
  required String expiryMonth,
  required String expiryYear,
  required String securityCode,
  String? streetAddress,
  String? extendedAddress,
  String? locality,
  String? region,
  String? postalCode,
  String? countryCode,
}) async {
  if (kIsWeb) {
    return PayPalNativeResult(
      success: false,
      errorMessage: "The Native Card form is only available in the mobile app. On Web, please use the 'PayPal' button to pay with card or account.",
    );
  }

  const platform = MethodChannel('com.m/paypal_native_card');
  
  try {
    final Map<dynamic, dynamic>? result = await platform.invokeMethod('approveOrder', {
      "clientId": clientId,
      "isLive": isLive,
      "orderId": orderId,
      "cardNumber": cardNumber,
      "expiryMonth": expiryMonth,
      "expiryYear": expiryYear,
      "securityCode": securityCode,
      "streetAddress": streetAddress ?? "",
      "extendedAddress": extendedAddress ?? "",
      "locality": locality ?? "",
      "region": region ?? "",
      "postalCode": postalCode ?? "",
      "countryCode": countryCode ?? "ZA",
    });

    if (result != null) {
      return PayPalNativeResult(
        success: result['success'] ?? false,
        orderId: result['orderId'],
        errorMessage: result['errorMessage'],
      );
    } else {
      return PayPalNativeResult(success: false, errorMessage: "Native bridge returned null");
    }
  } on PlatformException catch (e) {
    return PayPalNativeResult(success: false, errorMessage: e.message);
  } catch (e) {
    return PayPalNativeResult(success: false, errorMessage: e.toString());
  }
}
