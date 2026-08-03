

String? getPayPalAmount(
  double? price,
  String? seats,
) {
  if (price == null || seats == null) {
    return '0.00';
  }
  int seatCount = int.tryParse(seats) ?? 1;
  return ((price * 1.10) * seatCount).toStringAsFixed(2);
}
