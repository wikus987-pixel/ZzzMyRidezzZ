import 'dart:convert';
import 'package:http/http.dart' as http;

/// Cached ZAR → USD rate so we don't hit the API on every call.
double? _cachedRate;
DateTime? _cachedAt;

/// How long the cached rate stays valid.
const _cacheDuration = Duration(minutes: 30);

/// Fallback rate used when the API is unreachable.
const double _fallbackRate = 0.056;

/// Returns the current ZAR → USD exchange rate.
///
/// Uses the free exchangerate.host API (no key required).
/// Falls back to a hardcoded rate if the request fails.
/// Caches the result for 30 minutes.
Future<double> getZarToUsdRate() async {
  // Return cached value if still fresh.
  if (_cachedRate != null &&
      _cachedAt != null &&
      DateTime.now().difference(_cachedAt!) < _cacheDuration) {
    return _cachedRate!;
  }

  try {
    final uri = Uri.parse(
        'https://open.er-api.com/v6/latest/ZAR');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rates = data['rates'] as Map<String, dynamic>?;
      if (rates != null && rates.containsKey('USD')) {
        _cachedRate = (rates['USD'] as num).toDouble();
        _cachedAt = DateTime.now();
        return _cachedRate!;
      }
    }
  } catch (_) {
    // Network error — fall through to fallback.
  }

  return _cachedRate ?? _fallbackRate;
}

/// Converts a ZAR amount to USD using the live rate.
Future<double> zarToUsd(double zarAmount) async {
  final rate = await getZarToUsdRate();
  return zarAmount * rate;
}
