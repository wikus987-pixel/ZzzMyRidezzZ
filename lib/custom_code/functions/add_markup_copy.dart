

String addMarkupCopy(
  double price,
  int seats,
) {
// 1. Add the 10% markup to the base price
  double priceWithMarkup = price * 1.10;

  // 2. Multiply that marked-up price by the number of seats selected
  double total = priceWithMarkup * seats;

  // 3. Return the final total formatted to 2 decimal places
  return total.toStringAsFixed(2);
}
