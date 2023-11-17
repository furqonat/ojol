import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => Auth1Widget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => Auth1Widget(),
        ),
        FFRoute(
          name: 'Auth1',
          path: '/auth1',
          builder: (context, params) => Auth1Widget(),
        ),
        FFRoute(
          name: 'Auth2',
          path: '/auth2',
          builder: (context, params) => Auth2Widget(),
        ),
        FFRoute(
          name: 'Auth_daftar_food',
          path: '/authDaftarFood',
          builder: (context, params) => AuthDaftarFoodWidget(),
        ),
        FFRoute(
          name: 'Auth_masuk_1',
          path: '/authMasuk1',
          builder: (context, params) => AuthMasuk1Widget(),
        ),
        FFRoute(
          name: 'Halaman_depan',
          path: '/halamanDepan',
          builder: (context, params) => HalamanDepanWidget(),
        ),
        FFRoute(
          name: 'Halaman_pesanan_1',
          path: '/halamanPesanan1',
          builder: (context, params) => HalamanPesanan1Widget(),
        ),
        FFRoute(
          name: 'Kategori_1',
          path: '/kategori1',
          builder: (context, params) => Kategori1Widget(),
        ),
        FFRoute(
          name: 'Jualan_1',
          path: '/jualan1',
          builder: (context, params) => Jualan1Widget(),
        ),
        FFRoute(
          name: 'Saldo',
          path: '/saldo',
          builder: (context, params) => SaldoWidget(),
        ),
        FFRoute(
          name: 'Promosi_1',
          path: '/promosi1',
          builder: (context, params) => Promosi1Widget(),
        ),
        FFRoute(
          name: 'Chat_1',
          path: '/chat1',
          builder: (context, params) => Chat1Widget(),
        ),
        FFRoute(
          name: 'Chat_2',
          path: '/chat2',
          builder: (context, params) => Chat2Widget(),
        ),
        FFRoute(
          name: 'Akun_1',
          path: '/akun1',
          builder: (context, params) => Akun1Widget(),
        ),
        FFRoute(
          name: 'Akun_jam_buka',
          path: '/akunJamBuka',
          builder: (context, params) => AkunJamBukaWidget(),
        ),
        FFRoute(
          name: 'Akun_informasi_akun',
          path: '/akunInformasiAkun',
          builder: (context, params) => AkunInformasiAkunWidget(),
        ),
        FFRoute(
          name: 'Akun_kebijakan_privasi',
          path: '/akunKebijakanPrivasi',
          builder: (context, params) => AkunKebijakanPrivasiWidget(),
        ),
        FFRoute(
          name: 'Akun_bantuan',
          path: '/akunBantuan',
          builder: (context, params) => AkunBantuanWidget(),
        ),
        FFRoute(
          name: 'Auth_daftar_mart',
          path: '/authDaftarMart',
          builder: (context, params) => AuthDaftarMartWidget(),
        ),
        FFRoute(
          name: 'Auth_masuk_2',
          path: '/authMasuk2',
          builder: (context, params) => AuthMasuk2Widget(),
        ),
        FFRoute(
          name: 'Promosi_2',
          path: '/promosi2',
          builder: (context, params) => Promosi2Widget(),
        ),
        FFRoute(
          name: 'History',
          path: '/history',
          builder: (context, params) => HistoryWidget(),
        ),
        FFRoute(
          name: 'Halaman_pesanan_terima',
          path: '/halamanPesananTerima',
          builder: (context, params) => HalamanPesananTerimaWidget(),
        ),
        FFRoute(
          name: 'Saldo_dana',
          path: '/saldoDana',
          builder: (context, params) => SaldoDanaWidget(),
        ),
        FFRoute(
          name: 'Saldo_dompet',
          path: '/saldoDompet',
          builder: (context, params) => SaldoDompetWidget(),
        ),
        FFRoute(
          name: 'Saldo_dompet_history',
          path: '/saldoDompetHistory',
          builder: (context, params) => SaldoDompetHistoryWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
