// Automatic FlutterFlow imports
import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
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
