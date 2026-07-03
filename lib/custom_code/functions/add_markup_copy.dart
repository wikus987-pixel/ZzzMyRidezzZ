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
