
String addParcelMarkup(
  double price,
  int parcels,
) {
  // 1. Add the 15% markup to the base price for parcels
  double priceWithMarkup = price * 1.15;

  // 2. Multiply that marked-up price by the number of parcels selected
  double total = priceWithMarkup * parcels;

  // 3. Return the final total formatted to 2 decimal places
  return total.toStringAsFixed(2);
}
