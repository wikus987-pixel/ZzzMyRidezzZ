import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsersTable();

  String get uid => getField<String>('uid')!;
  set uid(String value) => setField<String>('uid', value);

  DateTime? get accountCreatedDate => getField<DateTime>('AccountCreatedDate');
  set accountCreatedDate(DateTime? value) =>
      setField<DateTime>('AccountCreatedDate', value);

  String? get bankName => getField<String>('BankName');
  set bankName(String? value) => setField<String>('BankName', value);

  String? get branchCode => getField<String>('BranchCode');
  set branchCode(String? value) => setField<String>('BranchCode', value);

  String? get cellNumber => getField<String>('CellNumber');
  set cellNumber(String? value) => setField<String>('CellNumber', value);

  String? get firstName => getField<String>('FirstName');
  set firstName(String? value) => setField<String>('FirstName', value);

  String? get homeTown => getField<String>('HomeTown');
  set homeTown(String? value) => setField<String>('HomeTown', value);

  String? get iDNumber => getField<String>('IDNumber');
  set iDNumber(String? value) => setField<String>('IDNumber', value);

  bool? get isSignupPaid => getField<bool>('IsSignupPaid');
  set isSignupPaid(bool? value) => setField<bool>('IsSignupPaid', value);

  String? get surname => getField<String>('Surname');
  set surname(String? value) => setField<String>('Surname', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get displayName => getField<String>('display_name');
  set displayName(String? value) => setField<String>('display_name', value);

  String? get photoUrl => getField<String>('photo_url');
  set photoUrl(String? value) => setField<String>('photo_url', value);

  DateTime? get createdTime => getField<DateTime>('created_time');
  set createdTime(DateTime? value) => setField<DateTime>('created_time', value);

  String? get phoneNumber => getField<String>('phone_number');
  set phoneNumber(String? value) => setField<String>('phone_number', value);

  String? get ridesCompleted => getField<String>('RidesCompleted');
  set ridesCompleted(String? value) =>
      setField<String>('RidesCompleted', value);

  String? get accHolderName => getField<String>('AccHolderName');
  set accHolderName(String? value) => setField<String>('AccHolderName', value);

  String? get accountNumber => getField<String>('AccountNumber');
  set accountNumber(String? value) => setField<String>('AccountNumber', value);

  String? get paypalPayMeLink => getField<String>('PaypalPayMeLink');
  set paypalPayMeLink(String? value) =>
      setField<String>('PaypalPayMeLink', value);

  String? get vehicleRegistration => getField<String>('VehicleRegistration');
  set vehicleRegistration(String? value) =>
      setField<String>('VehicleRegistration', value);

  String? get userID => getField<String>('UserID');
  set userID(String? value) => setField<String>('UserID', value);

  double? get rating => getField<double>('Rating');
  set rating(double? value) => setField<double>('Rating', value);
}
