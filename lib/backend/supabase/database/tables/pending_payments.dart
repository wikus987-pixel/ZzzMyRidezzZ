import '../database.dart';

class PendingPaymentsTable extends SupabaseTable<PendingPaymentsRow> {
  @override
  String get tableName => 'PendingPayments';

  @override
  PendingPaymentsRow createRow(Map<String, dynamic> data) =>
      PendingPaymentsRow(data);
}

class PendingPaymentsRow extends SupabaseDataRow {
  PendingPaymentsRow(super.data);

  @override
  SupabaseTable get table => PendingPaymentsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get rideReference => getField<int>('ride_reference');
  set rideReference(int? value) => setField<int>('ride_reference', value);

  String? get userReference => getField<String>('user_reference');
  set userReference(String? value) => setField<String>('user_reference', value);

  String? get paymentProofUrl => getField<String>('payment_proof_url');
  set paymentProofUrl(String? value) =>
      setField<String>('payment_proof_url', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  int? get seatsRequested => getField<int>('seats_requested');
  set seatsRequested(int? value) => setField<int>('seats_requested', value);

  String? get bookedBy => getField<String>('BookedBy');
  set bookedBy(String? value) => setField<String>('BookedBy', value);
}
