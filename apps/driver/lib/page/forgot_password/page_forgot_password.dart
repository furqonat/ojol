import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller_forgot_password.dart';

class PageForgotPassword extends GetView<ControllerForgotPassword> {
  const PageForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Forgot Password',
            style: GoogleFonts.readexPro(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Enter your email address and we will send you a link to reset your password.',
            style: GoogleFonts.readexPro(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: GoogleFonts.readexPro(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.forgotPassword();
            },
            child: Text(
              'Send',
              style: GoogleFonts.readexPro(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
