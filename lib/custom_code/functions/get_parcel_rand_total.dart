
String getParcelRandTotal(
  double? price,
  String? parcels,
) {
  if (price == null || parcels == null) {
    return '0.00';
  }
  int parcelCount = int.tryParse(parcels) ?? 1;
  double totalRand = (price * 1.15) * parcelCount;
  return totalRand.toStringAsFixed(2);
}
