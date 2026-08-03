import 'package:ride_share_supa/backend/supabase/supabase.dart';

Stream<List<RidesRow>> streamAllRides() {
  return SupaFlow.client
      .from('rides')
      .stream(primaryKey: ['id'])
      .order('departure_time')
      .map((rows) => rows.map((r) => RidesRow(r)).toList());
}

Stream<List<RidesRow>> streamRideById(int rideId) {
  return SupaFlow.client
      .from('rides')
      .stream(primaryKey: ['id'])
      .eq('id', rideId)
      .map((rows) => rows.map((r) => RidesRow(r)).toList());
}

Stream<List<RidesRow>> rideRowListStream(RidesRow? ride) {
  if (ride == null) return Stream.value(<RidesRow>[]);
  return streamRideById(ride.id);
}

Future<UsersRow?> getUserByUid(String uid) async {
  final rows = await UsersTable().querySingleRow(
    queryFn: (q) => q.eq('uid', uid),
  );
  return rows.isNotEmpty ? rows.first : null;
}

Stream<List<UsersRow>> streamUserByUid(String uid) {
  return SupaFlow.client
      .from('users')
      .stream(primaryKey: ['id'])
      .eq('uid', uid)
      .map((rows) => rows.map((r) => UsersRow(r)).toList());
}

Future<RidesRow?> getRideById(int rideId) async {
  final rows = await RidesTable().querySingleRow(
    queryFn: (q) => q.eq('id', rideId),
  );
  return rows.isNotEmpty ? rows.first : null;
}
