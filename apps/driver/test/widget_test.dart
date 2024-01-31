// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/page/auth/controller_auth.dart';
import 'package:lugo_driver/page/auth/page_auth.dart';
import 'package:mockito/mockito.dart';

class AuthControllerMock extends GetxController
    with Mock
    implements ControllerAuth {}

void main() {
  testWidgets('SignIn Test return null', (WidgetTester tester) async {
    final authController = Get.put<ControllerAuth>(AuthControllerMock());
    authController.tabController = TabController(length: 2, vsync: tester);
    await tester.pumpWidget(const GetMaterialApp(
      home: PageAuth(),
    ));
    // enter text to email form field
    await tester.enterText(find.byKey(const Key("emailSignIn")), "email");
    // enter text to password form field
    await tester.enterText(find.byKey(const Key("passwordSignIn")), "password");
    // tap on button
    await tester.tap(find.byKey(const Key("signInButton")));
    await tester.pump();
    expect(authController.handlSignIn(), null);
  });
}
