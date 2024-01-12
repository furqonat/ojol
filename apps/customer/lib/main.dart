import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lugo_customer/firebase_options.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:lugo_customer/route/route_page.dart';
import 'package:lugo_customer/shared/controller/controller_main.dart';
import 'package:lugo_customer/shared/local_notif.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  LocalNotificationService.initialize();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await GetStorage.init();
  runApp(const MyApp());
}

Future<void> backgroundHandler(RemoteMessage message) async {
  log(message.data.toString());
  // log(message.notification?.title?.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver{
  String pageName = '';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  updatePageRoute(value) {
    try {
      var name = value!.route!.settings.name.toString();
      log(name);
      setState(() {
        pageName = name;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);


    return ScreenUtilInit(
        designSize: const Size(393, 830),
        builder: (BuildContext context, Widget? child) => GetMaterialApp(
          navigatorKey: Get.key,
          title: 'Lugo Customer',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            platform: TargetPlatform.android,
            brightness: Brightness.light,
          ),
          builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
                child: Stack(
                  children: [
                    child!
                  ],
                ),
              )
          ),
          getPages: RoutingPages.pages,
          initialBinding: ControllerMain(),
          initialRoute: Routes.INITIAL,
          locale: const Locale('id', 'ID'),
          routingCallback: (value){
            if(value!= null){
              updatePageRoute(value);
            }
          },
          defaultTransition: Transition.cupertino,
        )
    );
  }
}
