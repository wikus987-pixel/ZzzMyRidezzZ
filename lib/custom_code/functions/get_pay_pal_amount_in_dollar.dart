
import 'package:ride_share_supa/custom_code/functions/exchange_rate.dart';

String? getPayPalAmountInDollar(
  double? price,
  String? seats,
) {
  // ignore: unnecessary_null_comparison
  if (price == null || seats == null) {
    return '0.00';
  }
  int seatCount = int.tryParse(seats) ?? 1;

  // 10% markup in Rand
  double totalRand = (price * 1.10) * seatCount;

  // Convert to USD using fallback rate (synchronous version for display).
  // The actual payment uses the async version with live rate.
  double totalUSD = totalRand * 0.056;

  return totalUSD.toStringAsFixed(2);
}

/// Async version that fetches the live ZAR → USD exchange rate.
Future<String> getPayPalAmountInDollarLive(
  double? price,
  String? seats,
) async {
  if (price == null || seats == null) {
    return '0.00';
  }
  int seatCount = int.tryParse(seats) ?? 1;

  // 10% markup in Rand
  double totalRand = (price * 1.10) * seatCount;

  // Convert to USD using live rate
  final rate = await getZarToUsdRate();
  double totalUSD = totalRand * rate;

  return totalUSD.toStringAsFixed(2);
}
