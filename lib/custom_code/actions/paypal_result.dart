class PayPalPaymentResult {
  final bool success;
  final String? orderId;
  final String? errorMessage;

  PayPalPaymentResult({
    required this.success,
    this.orderId,
    this.errorMessage,
  });
}