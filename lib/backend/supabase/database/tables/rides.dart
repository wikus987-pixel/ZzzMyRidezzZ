import '../database.dart';

class RidesTable extends SupabaseTable<RidesRow> {
  @override
  String get tableName => 'rides';

  @override
  RidesRow createRow(Map<String, dynamic> data) => RidesRow(data);
}

class RidesRow extends SupabaseDataRow {
  RidesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RidesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime? get departureTime => getField<DateTime>('departure_time');
  set departureTime(DateTime? value) =>
      setField<DateTime>('departure_time', value);

  String? get departureLocation => getField<String>('departure_location');
  set departureLocation(String? value) =>
      setField<String>('departure_location', value);

  String? get arrivalLocation => getField<String>('arrival_location');
  set arrivalLocation(String? value) =>
      setField<String>('arrival_location', value);

  DateTime? get arrivalTime => getField<DateTime>('arrival_time');
  set arrivalTime(DateTime? value) => setField<DateTime>('arrival_time', value);

  int? get seatsAvailable => getField<int>('seats_available');
  set seatsAvailable(int? value) => setField<int>('seats_available', value);

  double? get pricePerSeat => getField<double>('price_per_seat');
  set pricePerSeat(double? value) => setField<double>('price_per_seat', value);

  String? get additionalComments => getField<String>('additional_comments');
  set additionalComments(String? value) =>
      setField<String>('additional_comments', value);

  String? get driverReference => getField<String>('driver_reference');
  set driverReference(String? value) =>
      setField<String>('driver_reference', value);

  String? get rideStatus => getField<String>('RideStatus');
  set rideStatus(String? value) => setField<String>('RideStatus', value);

  String? get seatsBooked => getField<String>('SeatsBooked');
  set seatsBooked(String? value) => setField<String>('SeatsBooked', value);

  String? get createdBy => getField<String>('CreatedBy');
  set createdBy(String? value) => setField<String>('CreatedBy', value);

  String? get bookedBy => getField<String>('BookedBy');
  set bookedBy(String? value) => setField<String>('BookedBy', value);
}
