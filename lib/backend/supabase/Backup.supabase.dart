import 'package:supabase_flutter/supabase_flutter.dart';

export 'database/database.dart';
export 'supabase_queries.dart';

String _kSupabaseUrl = 'https://empawnadqvmalfqvbkbp.supabase.co';
String _kSupabaseAnonKey =
    'sb_publishable_pZ4EHm69Gsmf60Gze_59hw_3FdPiVq-';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        headers: {
          'X-Client-Info': 'flutterflow',
        },
        publishableKey: _kSupabaseAnonKey,
        debug: false,
        authOptions:
            FlutterAuthClientOptions(authFlowType: AuthFlowType.implicit),
      );
}