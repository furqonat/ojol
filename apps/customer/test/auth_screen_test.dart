import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lugo_customer/flutter_flow/flutter_flow_widgets.dart';
import 'package:lugo_customer/index.dart';
import 'package:mockito/mockito.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

void main() {
  group('test signin otp screnn', () {
    FirebaseAuthMock authMock = FirebaseAuthMock();

    setUp(() {
      authMock = FirebaseAuthMock();
    });

    testWidgets('test signin screen not error', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SignInOTPScreen(
          auth: authMock,
        ),
      ));

      // default no interaction
      final buttonTextFinder = find.text("Kirim");
      final placeholderTextFinder = find.text("Nomor Telepon");

      expect(buttonTextFinder, findsOneWidget);
      expect(placeholderTextFinder, findsOneWidget);
    });

    testWidgets('test input text', (tester) async {
      when(authMock.verifyPhoneNumber(
        phoneNumber: anyNamed('phoneNumber'),
        verificationCompleted: (cred) {},
        verificationFailed: (c) {},
        codeSent: (c, a) {},
        codeAutoRetrievalTimeout: (c) {},
      )).thenAnswer((_) async {});

      await tester.pumpWidget(MaterialApp(
        home: SignInOTPScreen(
          auth: authMock,
        ),
      ));

      // enter phone number
      await tester.enterText(find.byType(TextFormField), "0812345678911");

      await tester.tap(find.widgetWithText(FFButtonWidget, "Kirim"));
      // rebuild a widget
      await tester.pumpAndSettle();

      expect(find.text('Code Sent to 0812345678911'), findsOneWidget);

      verify(authMock.verifyPhoneNumber(
        phoneNumber: anyNamed('phoneNumber'),
        verificationCompleted: (cred) {},
        verificationFailed: (c) {},
        codeSent: (c, a) {},
        codeAutoRetrievalTimeout: (c) {},
      )).called(1);
    });
  });
}
