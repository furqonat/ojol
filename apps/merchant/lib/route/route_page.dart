import 'package:get/get.dart';
import 'package:lugo_marchant/page/accout_info/binding_accountinfo.dart';
import 'package:lugo_marchant/page/accout_info/page_accountinfo.dart';
import 'package:lugo_marchant/page/auth/binding_auth.dart';
import 'package:lugo_marchant/page/auth/binding_password.dart';
import 'package:lugo_marchant/page/auth/forgot_password.dart';
import 'package:lugo_marchant/page/auth/page_auth.dart';
import 'package:lugo_marchant/page/balance/binding_balance.dart';
import 'package:lugo_marchant/page/balance/page_balance.dart';
import 'package:lugo_marchant/page/bottom_nav/binding_bottomnav.dart';
import 'package:lugo_marchant/page/bottom_nav/page_bottomnav.dart';
import 'package:lugo_marchant/page/category/binding_category.dart';
import 'package:lugo_marchant/page/category/page_category.dart';
import 'package:lugo_marchant/page/chat/page_chat.dart';
import 'package:lugo_marchant/page/dana/binding_dana.dart';
import 'package:lugo_marchant/page/dana/page_dana.dart';
import 'package:lugo_marchant/page/edit_product/binding_editproduct.dart';
import 'package:lugo_marchant/page/edit_product/page_editproduct.dart';
import 'package:lugo_marchant/page/history/binding_history.dart';
import 'package:lugo_marchant/page/history/page_history.dart';
import 'package:lugo_marchant/page/home/binding_home.dart';
import 'package:lugo_marchant/page/home/page_home.dart';
import 'package:lugo_marchant/page/operational/binding_operational.dart';
import 'package:lugo_marchant/page/operational/page_operational.dart';
import 'package:lugo_marchant/page/verification/binding.dart';
import 'package:lugo_marchant/page/verification/page.dart';
import 'package:lugo_marchant/page/privacy_terms/binding_privacy.dart';
import 'package:lugo_marchant/page/privacy_terms/page_privacy.dart';
import 'package:lugo_marchant/page/product/binding_product.dart';
import 'package:lugo_marchant/page/product/page_product.dart';
import 'package:lugo_marchant/page/profile/binding_profile.dart';
import 'package:lugo_marchant/page/profile/page_profile.dart';
import 'package:lugo_marchant/page/promo/binding_promo.dart';
import 'package:lugo_marchant/page/room_chat/binding_roomchat.dart';
import 'package:lugo_marchant/page/room_chat/page_roomchat.dart';
import 'package:lugo_marchant/page/running_order/binding_runningorder.dart';
import 'package:lugo_marchant/page/running_order/page_runningorder.dart';
import 'package:lugo_marchant/page/splash_screen/page_splash.dart';
import 'package:lugo_marchant/page/welcome/binding_welcome.dart';
import 'package:lugo_marchant/page/welcome/page_welcome.dart';
import 'package:lugo_marchant/route/route_name.dart';
import '../page/chat/binding_chat.dart';
import '../page/form_register/binding_form.dart';
import '../page/form_register/page_form.dart';
import '../page/promo/page_promo.dart';
import '../page/splash_screen/binding_splash.dart';

class RoutingPages {
  static final pages = [
    GetPage(
      name: Routes.init,
      page: () => const PageSplash(),
      binding: BindingSplash(),
    ),
    GetPage(
      name: Routes.welcome,
      page: () => const PageWelcome(),
      binding: BindingWelcome(),
    ),
    GetPage(
      name: Routes.auth,
      page: () => const PageAuth(),
      binding: BindingAuth(),
    ),
    GetPage(
      name: Routes.bottomNav,
      page: () => const PageBottomNav(),
      binding: BindingBottomNav(),
    ),
    GetPage(
      name: Routes.roomChat,
      page: () => const PageRoomChat(),
      binding: BindingRoomChat(),
    ),
    GetPage(
      name: Routes.chat,
      page: () => const PageChat(),
      binding: BindingChat(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const PageHome(),
      binding: BindingHome(),
    ),
    GetPage(
      name: Routes.history,
      page: () => const PageHistory(),
      binding: BindingHistory(),
    ),
    GetPage(
      name: Routes.runningOrder,
      page: () => const PageRunningOrder(),
      binding: BindingRunningOrder(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const PageProfile(),
      binding: BindingProfile(),
    ),
    GetPage(
      name: Routes.privacyTerm,
      page: () => const PagePrivacy(),
      binding: BindingPrivacy(),
    ),
    GetPage(
      name: Routes.operationalTime,
      page: () => const PageOperational(),
      binding: BindingOperational(),
    ),
    GetPage(
      name: Routes.accountInformation,
      page: () => const PageAccountInfo(),
      binding: BindingAccountInfo(),
    ),
    GetPage(
      name: Routes.formSignUp,
      page: () => const PageForm(),
      binding: BindingForm(),
    ),
    GetPage(
      name: Routes.danaBalance,
      page: () => const PageDana(),
      binding: BindingDana(),
    ),
    GetPage(
      name: Routes.product,
      page: () => const PageProduct(),
      binding: BindingProduct(),
    ),
    GetPage(
      name: Routes.category,
      page: () => const PageCategory(),
      binding: BindingCategory(),
    ),
    GetPage(
      name: Routes.promo,
      page: () => const PagePromo(),
      binding: BindingPromo(),
    ),
    GetPage(
      name: Routes.editProduct,
      page: () => const PageEditProduct(),
      binding: BindingEditProduct(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPassword(),
      binding: BindingPassword(),
    ),
    GetPage(
      name: Routes.verification,
      page: () => const Verification(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: Routes.balance,
      page: () => const PageBalance(),
      binding: BindingBalance(),
    ),
  ];
}
