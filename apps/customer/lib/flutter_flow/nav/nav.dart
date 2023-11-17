import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';

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

final FirebaseAuth auth = FirebaseAuth.instance;

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => SignInOTPScreen(
        auth: auth,
      ),
      routes: [
        FFRoute(
          name: 'Authentic',
          path: '/authentic',
          builder: (context, params) => AuthenticWidget(),
        ),
        FFRoute(
          name: 'PinCode',
          path: '/pinCode',
          builder: (context, params) {
            final verificationId =
                params.getParam('verificationId', ParamType.String, false);
            return PinCodeWidget(
              auth: auth,
              verificationId: verificationId,
            );
          },
        ),
        FFRoute(
          name: 'Saldo',
          path: '/saldo',
          builder: (context, params) => SaldoWidget(),
        ),
        FFRoute(
          name: 'Halaman_Utama',
          path: '/halamanUtama',
          builder: (context, params) => HalamanUtamaWidget(),
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
          name: 'Deliv_3',
          path: '/deliv3',
          builder: (context, params) => Deliv3Widget(),
        ),
        FFRoute(
          name: 'Deliv_4',
          path: '/deliv4',
          builder: (context, params) => Deliv4Widget(),
        ),
        FFRoute(
          name: 'Chat_personal',
          path: '/chatPersonal',
          builder: (context, params) => ChatPersonalWidget(),
        ),
        FFRoute(
          name: 'Deliv_5',
          path: '/deliv5',
          builder: (context, params) => Deliv5Widget(),
        ),
        FFRoute(
          name: 'Chat_1',
          path: '/chat1',
          builder: (context, params) => Chat1Widget(),
        ),
        FFRoute(
          name: 'Halaman_promosi',
          path: '/halamanPromosi',
          builder: (context, params) => HalamanPromosiWidget(),
        ),
        FFRoute(
          name: 'Halaman_promosi_buka_page',
          path: '/halamanPromosiBukaPage',
          builder: (context, params) => HalamanPromosiBukaPageWidget(),
        ),
        FFRoute(
          name: 'Akun',
          path: '/akun',
          builder: (context, params) => AkunWidget(),
        ),
        FFRoute(
          name: 'Akun_edit',
          path: '/akunEdit',
          builder: (context, params) => AkunEditWidget(),
        ),
        FFRoute(
          name: 'Ride_3',
          path: '/ride3',
          builder: (context, params) => Ride3Widget(),
        ),
        FFRoute(
          name: 'Ride_5',
          path: '/ride5',
          builder: (context, params) => Ride5Widget(),
        ),
        FFRoute(
          name: 'Ride_history',
          path: '/rideHistory',
          builder: (context, params) => RideHistoryWidget(),
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
          name: 'Mart_order_aktif',
          path: '/martOrderAktif',
          builder: (context, params) => MartOrderAktifWidget(),
        ),
        FFRoute(
          name: 'Mart_6',
          path: '/mart6',
          builder: (context, params) => Mart6Widget(),
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
          name: 'Car_3',
          path: '/car3',
          builder: (context, params) => Car3Widget(),
        ),
        FFRoute(
          name: 'Car_4',
          path: '/car4',
          builder: (context, params) => Car4Widget(),
        ),
        FFRoute(
          name: 'Car_5',
          path: '/car5',
          builder: (context, params) => Car5Widget(),
        ),
        FFRoute(
          name: 'Car_history',
          path: '/carHistory',
          builder: (context, params) => CarHistoryWidget(),
        ),
        FFRoute(
          name: 'Mart_5',
          path: '/mart5',
          builder: (context, params) => Mart5Widget(),
        ),
        FFRoute(
          name: 'Mart_order_batal',
          path: '/martOrderBatal',
          builder: (context, params) => MartOrderBatalWidget(),
        ),
        FFRoute(
          name: 'Food_1',
          path: '/food1',
          builder: (context, params) => Food1Widget(),
        ),
        FFRoute(
          name: 'Food_2',
          path: '/food2',
          builder: (context, params) => Food2Widget(),
        ),
        FFRoute(
          name: 'Food_3',
          path: '/food3',
          builder: (context, params) => Food3Widget(),
        ),
        FFRoute(
          name: 'Food_4',
          path: '/food4',
          builder: (context, params) => Food4Widget(),
        ),
        FFRoute(
          name: 'Food_5',
          path: '/food5',
          builder: (context, params) => Food5Widget(),
        ),
        FFRoute(
          name: 'Food_6',
          path: '/food6',
          builder: (context, params) => Food6Widget(),
        ),
        FFRoute(
          name: 'Food_order_aktif',
          path: '/foodOrderAktif',
          builder: (context, params) => FoodOrderAktifWidget(),
        ),
        FFRoute(
          name: 'Food_order_batal',
          path: '/foodOrderBatal',
          builder: (context, params) => FoodOrderBatalWidget(),
        ),
        FFRoute(
          name: 'Food_riwayat',
          path: '/foodRiwayat',
          builder: (context, params) => FoodRiwayatWidget(),
        ),
        FFRoute(
          name: 'Mart_riwayat',
          path: '/martRiwayat',
          builder: (context, params) => MartRiwayatWidget(),
        ),
        FFRoute(
          name: 'Halaman_utama_poin_1',
          path: '/halamanUtamaPoin1',
          builder: (context, params) => HalamanUtamaPoin1Widget(),
        ),
        FFRoute(
          name: 'Halaman_utama_poin_2',
          path: '/halamanUtamaPoin2',
          builder: (context, params) => HalamanUtamaPoin2Widget(),
        ),
        FFRoute(
          name: 'Order_berjalan',
          path: '/orderBerjalan',
          builder: (context, params) => OrderBerjalanWidget(),
        ),
        FFRoute(
          name: 'Order_histoey',
          path: '/orderHistoey',
          builder: (context, params) => OrderHistoeyWidget(),
        ),
        FFRoute(
          name: 'Akun_whatsapp_admin',
          path: '/akunWhatsappAdmin',
          builder: (context, params) => AkunWhatsappAdminWidget(),
        ),
        FFRoute(
          name: 'Akun_kasih_rating',
          path: '/akunKasihRating',
          builder: (context, params) => AkunKasihRatingWidget(),
        ),
        FFRoute(
          name: 'Akun_kebijakan_privasi',
          path: '/akunKebijakanPrivasi',
          builder: (context, params) => AkunKebijakanPrivasiWidget(),
        ),
        FFRoute(
          name: 'Akun_tentang_kami',
          path: '/akunTentangKami',
          builder: (context, params) => AkunTentangKamiWidget(),
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

  static TransitionInfo appDefault() =>
      const TransitionInfo(hasTransition: false);
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
