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
          name: 'Auth_masuk_1',
          path: '/authMasuk1',
          builder: (context, params) => AuthMasuk1Widget(),
        ),
        FFRoute(
          name: 'Auth_masuk_2',
          path: '/authMasuk2',
          builder: (context, params) => AuthMasuk2Widget(),
        ),
        FFRoute(
          name: 'Halaman_depan',
          path: '/halamanDepan',
          builder: (context, params) => HalamanDepanWidget(),
        ),
        FFRoute(
          name: 'Halaman_depan_chat1',
          path: '/halamanDepanChat1',
          builder: (context, params) => HalamanDepanChat1Widget(),
        ),
        FFRoute(
          name: 'Halaman_depan_chat2',
          path: '/halamanDepanChat2',
          builder: (context, params) => HalamanDepanChat2Widget(),
        ),
        FFRoute(
          name: 'Akun',
          path: '/akun',
          builder: (context, params) => AkunWidget(),
        ),
        FFRoute(
          name: 'Bantuan',
          path: '/bantuan',
          builder: (context, params) => BantuanWidget(),
        ),
        FFRoute(
          name: 'Ride_1',
          path: '/ride1',
          builder: (context, params) => Ride1Widget(),
        ),
        FFRoute(
          name: 'Ride_2',
          path: '/ride2',
          builder: (context, params) => Ride2Widget(),
        ),
        FFRoute(
          name: 'Ride_4',
          path: '/ride4',
          builder: (context, params) => Ride4Widget(),
        ),
        FFRoute(
          name: 'Car_1',
          path: '/car1',
          builder: (context, params) => Car1Widget(),
        ),
        FFRoute(
          name: 'Car_2',
          path: '/car2',
          builder: (context, params) => Car2Widget(),
        ),
        FFRoute(
          name: 'Car_4',
          path: '/car4',
          builder: (context, params) => Car4Widget(),
        ),
        FFRoute(
          name: 'Saldo_1',
          path: '/saldo1',
          builder: (context, params) => Saldo1Widget(),
        ),
        FFRoute(
          name: 'Akun_profil',
          path: '/akunProfil',
          builder: (context, params) => AkunProfilWidget(),
        ),
        FFRoute(
          name: 'Akun_syarat_ketentuan',
          path: '/akunSyaratKetentuan',
          builder: (context, params) => AkunSyaratKetentuanWidget(),
        ),
        FFRoute(
          name: 'Akun_bantuan',
          path: '/akunBantuan',
          builder: (context, params) => AkunBantuanWidget(),
        ),
        FFRoute(
          name: 'Order_tersedia',
          path: '/orderTersedia',
          builder: (context, params) => OrderTersediaWidget(),
        ),
        FFRoute(
          name: 'Halaman_depan_history',
          path: '/halamanDepanHistory',
          builder: (context, params) => HalamanDepanHistoryWidget(),
        ),
        FFRoute(
          name: 'Akun_setting_orderan',
          path: '/akunSettingOrderan',
          builder: (context, params) => AkunSettingOrderanWidget(),
        ),
        FFRoute(
          name: 'Auth_daftar_motor',
          path: '/authDaftarMotor',
          builder: (context, params) => AuthDaftarMotorWidget(),
        ),
        FFRoute(
          name: 'Auth_daftar_mobil',
          path: '/authDaftarMobil',
          builder: (context, params) => AuthDaftarMobilWidget(),
        ),
        FFRoute(
          name: 'Deliv_1',
          path: '/deliv1',
          builder: (context, params) => Deliv1Widget(),
        ),
        FFRoute(
          name: 'Deliv_2',
          path: '/deliv2',
          builder: (context, params) => Deliv2Widget(),
        ),
        FFRoute(
          name: 'Deliv_4',
          path: '/deliv4',
          builder: (context, params) => Deliv4Widget(),
        ),
        FFRoute(
          name: 'Food_1',
          path: '/food1',
          builder: (context, params) => Food1Widget(),
        ),
        FFRoute(
          name: 'Food_3',
          path: '/food3',
          builder: (context, params) => Food3Widget(),
        ),
        FFRoute(
          name: 'Food_2',
          path: '/food2',
          builder: (context, params) => Food2Widget(),
        ),
        FFRoute(
          name: 'Food_4',
          path: '/food4',
          builder: (context, params) => Food4Widget(),
        ),
        FFRoute(
          name: 'Mart_1',
          path: '/mart1',
          builder: (context, params) => Mart1Widget(),
        ),
        FFRoute(
          name: 'Mart_2',
          path: '/mart2',
          builder: (context, params) => Mart2Widget(),
        ),
        FFRoute(
          name: 'Mart_3',
          path: '/mart3',
          builder: (context, params) => Mart3Widget(),
        ),
        FFRoute(
          name: 'Mart_4',
          path: '/mart4',
          builder: (context, params) => Mart4Widget(),
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
        ),
        FFRoute(
          name: 'Ride_3',
          path: '/ride3',
          builder: (context, params) => Ride3Widget(),
        ),
        FFRoute(
          name: 'Car_3',
          path: '/car3',
          builder: (context, params) => Car3Widget(),
        ),
        FFRoute(
          name: 'Deliv_3',
          path: '/deliv3',
          builder: (context, params) => Deliv3Widget(),
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
