// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future verifypendinguser(
  String userUid,
  String useremail,
) async {
  await VerifiedPaymentsTable().insert({
    'Email': useremail.toLowerCase().trim(),
    'created_at': supaSerialize<DateTime>(getCurrentTimestamp),
  });

  await UsersTable().update(
    data: {'IsSignupPaid': true},
    matchingRows: (q) => q.eq('uid', userUid),
  );
}
