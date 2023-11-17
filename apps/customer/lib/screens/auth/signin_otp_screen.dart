import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'signin_otp_model.dart';

export 'signin_otp_model.dart';

class SignInOTPScreen extends StatefulWidget {
  const SignInOTPScreen({super.key, required this.auth});
  final FirebaseAuth auth;

  @override
  createState() => _SignInOTPScreenState();
}

class _SignInOTPScreenState extends State<SignInOTPScreen> {
  late SignInOTPModel _model;
  String _verificationId = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignInOTPModel());

    _model.phoneNumberController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsetsDirectional.fromSTEB(
                //       12.0, 24.0, 12.0, 24.0),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       // FlutterFlowIconButton(
                //       //   key: const Key('back-button-otp-screen'),
                //       //   borderColor: const Color(0xFF3978EF),
                //       //   borderRadius: 20.0,
                //       //   borderWidth: 1.0,
                //       //   buttonSize: 40.0,
                //       //   fillColor: const Color(0xFF3978EF),
                //       //   icon: Icon(
                //       //     Icons.chevron_left,
                //       //     color:
                //       //         FlutterFlowTheme.of(context).secondaryBackground,
                //       //     size: 24.0,
                //       //   ),
                //       //   onPressed: () {
                //       //     print('IconButton pressed ...');
                //       //   },
                //       // ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      12.0, 24.0, 12.0, 24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Masukan Nomor Telepon Veritifikasi Anda',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      10.0, 0.0, 10.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.phoneNumberController,
                              focusNode: _model.phoneNumberFocusNode,
                              autofocus: true,
                              autofillHints: const [
                                AutofillHints.telephoneNumber
                              ],
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Nomor Telepon',
                                labelStyle:
                                    FlutterFlowTheme.of(context).labelLarge,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        24.0, 24.0, 0.0, 24.0),
                              ),
                              style: FlutterFlowTheme.of(context).bodyLarge,
                              keyboardType: TextInputType.phone,
                              validator: _model.emailAddressControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 16.0),
                    child: FFButtonWidget(
                      key: const Key('send-button-otp-screen'),
                      onPressed: _model.phoneNumberController.text.length < 6
                          ? null
                          : () {
                              // print('Button pressed ...');
                              _verifyPhoneNumber();
                            },
                      text: 'Kirim',
                      options: FFButtonOptions(
                        width: 230.0,
                        height: 52.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: const Color(0xFF3978EF),
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                        elevation: 3.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyPhoneNumber() async {
    await widget.auth.verifyPhoneNumber(
      phoneNumber: _model.phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval of the verification code completed.
        // Sign in using the automatically retrieved verification code.
        await widget.auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification Failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // print('Code Sent to $_phoneNumber');
        setState(() {
          _verificationId = verificationId;
        });
        _showMessage("Code Sent to ${_model.phoneNumberController.text}");

        Future.delayed(const Duration(seconds: 2)).then((value) {
          // navigate to verification code
          context.pushNamed('otp', queryParameters: {});
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Auto Retrieval Timeout: $verificationId');
      },
    );
  }

  _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // Future<void> _signInWithPhoneNumber() async {
  //   try {
  //     final AuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: _verificationId,
  //       smsCode: _verificationCode,
  //     );
  //     await _auth.signInWithCredential(credential);
  //     print('Sign In Successful');
  //   } catch (e) {
  //     print('Sign In Failed: $e');
  //   }
  // }
}
