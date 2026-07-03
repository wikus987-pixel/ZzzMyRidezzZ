import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

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

  // Convert to USD (approx rate)
  double totalUSD = totalRand * 0.056;

  return totalUSD.toStringAsFixed(2);
}
