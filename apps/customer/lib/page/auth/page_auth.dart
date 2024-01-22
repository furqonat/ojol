import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/auth/controller_auth.dart';
import 'package:validatorless/validatorless.dart';

class PageAuth extends GetView<ControllerAuth> {
  const PageAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Selamat datang',
                    style: GoogleFonts.readexPro(
                      fontSize: 30.0,
                      color: const Color(0xFF3978EF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: const Image(
                    width: 300.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/2023-07-23.jpg')),
              ),
            ),
            SliverToBoxAdapter(
              child: TabBar(
                  labelColor: const Color(0xFF14181B),
                  indicatorColor: const Color(0xFF4B39EF),
                  labelStyle: GoogleFonts.outfit(
                    fontSize: 20,
                  ),
                  padding: const EdgeInsets.all(10),
                  unselectedLabelStyle: GoogleFonts.outfit(
                    fontSize: 20,
                    color: const Color(0xFF95A1AC),
                  ),
                  controller: controller.tabController,
                  tabs: const [
                    Tab(
                      text: 'Masuk',
                    ),
                    Tab(
                      text: 'Daftar',
                    ),
                  ]),
            ),
            Obx(() => SliverToBoxAdapter(
                  child: Expanded(
                    child: SizedBox(
                      width: Get.width,
                      height: Get.height * 0.58,
                      child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          Form(
                            key: controller.formkeyAuthLogin,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: controller.edtEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: GoogleFonts.readexPro(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xFF95A1AC),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFF4B39EF))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.grey)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFF1D2428))),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.red)),
                                      contentPadding: const EdgeInsets.all(24),
                                    ),
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'Email tidak boleh kosong'),
                                      Validatorless.email('Email tidak sesuai')
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 16, 8, 8),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: controller.edtPassword,
                                    obscureText: controller.showPass.value,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: GoogleFonts.readexPro(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF95A1AC),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF4B39EF))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.grey)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF1D2428))),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.red)),
                                        contentPadding:
                                            const EdgeInsets.all(24),
                                        suffixIcon: GestureDetector(
                                          onTap: () => controller.showPass.value
                                              ? controller.showPass(false)
                                              : controller.showPass(true),
                                          child: Icon(
                                              controller.showPass.value
                                                  ? Icons.visibility_rounded
                                                  : Icons
                                                      .visibility_off_rounded,
                                              color: const Color(0xFF95A1AC)),
                                        )),
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'Password tidak boleh kosong'),
                                      Validatorless.min(
                                          8, 'Password tidak sesuai')
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (controller
                                            .formkeyAuthLogin.currentState!
                                            .validate()) {
                                          controller.firebaseLogin(context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 5,
                                          fixedSize: Size(Get.width * 0.5,
                                              Get.height * 0.07),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          backgroundColor:
                                              const Color(0xFF3978EF)),
                                      child: Text(
                                        "Masuk",
                                        style: GoogleFonts.readexPro(
                                            fontSize: 16, color: Colors.white),
                                      )),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Lupa Password",
                                      style: GoogleFonts.readexPro(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF14181B)),
                                    )),
                              ],
                            ),
                          ),
                          Form(
                            key: controller.formkeyAuthRegister,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: controller.edtEmailDaftar,
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: GoogleFonts.readexPro(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF95A1AC),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF4B39EF))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.grey)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF1D2428))),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.red)),
                                        contentPadding:
                                            const EdgeInsets.all(24)),
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'Email tidak boleh kosong'),
                                      Validatorless.email('Email tidak sesuai')
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 16, 8, 8),
                                  child: TextFormField(
                                    autofocus: false,
                                    obscureText: controller.showPass.value,
                                    controller: controller.edtPasswordDaftar,
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: GoogleFonts.readexPro(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF95A1AC),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF4B39EF))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.grey)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF1D2428))),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.red)),
                                        contentPadding:
                                            const EdgeInsets.all(24),
                                        suffixIcon: GestureDetector(
                                          onTap: () => controller.showPass.value
                                              ? controller.showPass(false)
                                              : controller.showPass(true),
                                          child: Icon(
                                              controller.showPass.value
                                                  ? Icons.visibility_rounded
                                                  : Icons
                                                      .visibility_off_rounded,
                                              color: const Color(0xFF95A1AC)),
                                        )),
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'Password tidak boleh kosong'),
                                      Validatorless.min(
                                          8, 'Password tidak sesuai')
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (controller
                                            .formkeyAuthRegister.currentState!
                                            .validate()) {
                                          controller.firebaseRegister(context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 5,
                                          fixedSize: Size(Get.width * 0.5,
                                              Get.height * 0.07),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          backgroundColor:
                                              const Color(0xFF3978EF)),
                                      child: Text(
                                        "Daftar",
                                        style: GoogleFonts.readexPro(
                                            fontSize: 16, color: Colors.white),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
