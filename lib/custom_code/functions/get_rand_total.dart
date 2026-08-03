

/// Booking total shown to the user, in RAND, including the 10% per-seat markup.
/// e.g. price R250, 2 seats -> (250 * 1.10) * 2 = R550.00
String getRandTotal(
  double? price,
  String? seats,
) {
  if (price == null || seats == null) {
    return '0.00';
  }
  int seatCount = int.tryParse(seats) ?? 1;
  double totalRand = (price * 1.10) * seatCount;
  return totalRand.toStringAsFixed(2);
}
