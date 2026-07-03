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
