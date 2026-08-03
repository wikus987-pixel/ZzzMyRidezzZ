import '../database.dart';

class ReqRidesTable extends SupabaseTable<ReqRidesRow> {
  @override
  String get tableName => 'ReqRides';

  @override
  ReqRidesRow createRow(Map<String, dynamic> data) => ReqRidesRow(data);
}

class ReqRidesRow extends SupabaseDataRow {
  ReqRidesRow(super.data);

  @override
  SupabaseTable get table => ReqRidesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get departureLocation => getField<String>('DepartureLocation');
  set departureLocation(String? value) =>
      setField<String>('DepartureLocation', value);

  DateTime? get departureTime => getField<DateTime>('DepartureTime');
  set departureTime(DateTime? value) =>
      setField<DateTime>('DepartureTime', value);

  String? get arrivalLocation => getField<String>('ArrivalLocation');
  set arrivalLocation(String? value) =>
      setField<String>('ArrivalLocation', value);

  DateTime? get arrivalTime => getField<DateTime>('ArrivalTime');
  set arrivalTime(DateTime? value) => setField<DateTime>('ArrivalTime', value);

  String? get seatsNeeded => getField<String>('SeatsNeeded');
  set seatsNeeded(String? value) => setField<String>('SeatsNeeded', value);

  String? get requestedBy => getField<String>('RequestedBy');
  set requestedBy(String? value) => setField<String>('RequestedBy', value);

  int? get numberOfParcelsReq => getField<int>('number_of_parcels_req');
  set numberOfParcelsReq(int? value) =>
      setField<int>('number_of_parcels_req', value);

  double? get pricePerParcelReq => getField<double>('price_per_parcel_req');
  set pricePerParcelReq(double? value) =>
      setField<double>('price_per_parcel_req', value);
}
