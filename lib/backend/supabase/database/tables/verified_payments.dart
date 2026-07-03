import '../database.dart';

class VerifiedPaymentsTable extends SupabaseTable<VerifiedPaymentsRow> {
  @override
  String get tableName => 'verified_payments';

  @override
  VerifiedPaymentsRow createRow(Map<String, dynamic> data) =>
      VerifiedPaymentsRow(data);
}

class VerifiedPaymentsRow extends SupabaseDataRow {
  VerifiedPaymentsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VerifiedPaymentsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get email => getField<String>('Email');
  set email(String? value) => setField<String>('Email', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  bool get verified => getField<bool>('verified') ?? false;
  set verified(bool value) => setField<bool>('verified', value);
}
