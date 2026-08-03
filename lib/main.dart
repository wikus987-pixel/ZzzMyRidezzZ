import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:ride_share_supa/auth/supabase_auth/auth_util.dart';

import 'package:ride_share_supa/backend/supabase/supabase.dart';
import 'package:ride_share_supa/auth/supabase_auth/supabase_user_provider.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_theme.dart';
import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await SupaFlow.initialize();

  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  String getRoute([RouteMatchBase? routeMatch]) {
    final RouteMatchBase lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.path;
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();

  late Stream<BaseAuthUser> userStream;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = rideShareSupaSupabaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });

    jwtTokenStream.listen((_) {});

    Future.delayed(
      Duration(milliseconds: 1000),
          () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
    _themeMode = mode;
    FlutterFlowTheme.saveThemeMode(mode);
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'RideShareSupa',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(
          interactive: false,
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.dragged)) {
              return const Color(0x4D3BB640);
            }
            if (states.contains(WidgetState.hovered)) {
              return const Color(0x4D3BB640);
            }
            return const Color(0x4D3BB640);
          }),
        ),
        colorSchemeSeed: FlutterFlowTheme.lightColorSchemeSeed,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scrollbarTheme: ScrollbarThemeData(
          interactive: false,
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.dragged)) {
              return const Color(0x4D3BB640);
            }
            if (states.contains(WidgetState.hovered)) {
              return const Color(0x4D3BB640);
            }
            return const Color(0x4D3BB640);
          }),
        ),
        colorSchemeSeed: FlutterFlowTheme.darkColorSchemeSeed,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}