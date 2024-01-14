import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_driver/page/auth/controller_auth.dart';
import 'package:lugo_driver/route/route_name.dart';
import 'package:lugo_driver/shared/custom_widget/lugo_button.dart';
import 'package:validatorless/validatorless.dart';

class PageAuth extends GetView<ControllerAuth>{
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
                      image: AssetImage(
                          'assets/images/LUGO DRIVER.png'
                      )
                  ),
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
                    ]
                ),
              ),
              SliverToBoxAdapter(
                child: Expanded(
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height * 0.58,
                    child: Obx(() => TabBarView(
                        controller: controller.tabController,
                        children: [
                          Form(
                            key: controller.formkeyAuthLogin,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFF4B39EF)
                                          )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.grey
                                          )
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFF1D2428)
                                          )
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.red
                                          )
                                      ),
                                      contentPadding: const EdgeInsets.all(24),
                                    ),
                                    validator: Validatorless.multiple([
                                      Validatorless.required('Email tidak boleh kosong'),
                                      Validatorless.email('Email tidak sesuai')
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
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
                                            borderRadius: BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF4B39EF)
                                            )
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Colors.grey
                                            )
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF1D2428)
                                            )
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Colors.red
                                            )
                                        ),
                                        contentPadding: const EdgeInsets.all(24),
                                        suffixIcon: GestureDetector(
                                          onTap: ()=> controller.showPass.value ? controller.showPass(false) : controller.showPass(true),
                                          child: Icon(
                                              controller.showPass.value
                                                  ? Icons.visibility_rounded
                                                  : Icons.visibility_off_rounded,
                                              color: const Color(0xFF95A1AC)
                                          ),
                                        )
                                    ),
                                    validator: Validatorless.multiple([
                                      Validatorless.required('Password tidak boleh kosong'),
                                      Validatorless.min(8, 'Password tidak sesuai')
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: LugoButton(
                                      textButton: 'Masuk',
                                      textColor: Colors.white,
                                      textSize: 12,
                                      width: Get.width * 0.5,
                                      height: Get.height* 0.06,
                                      color: const Color(0xFF3978EF),
                                      onTap: () {
                                        if(controller.formkeyAuthLogin.currentState!.validate()){
                                          controller.firebaseLogin(context);
                                        }
                                      }
                                  ),
                                ),
                                // TextButton(
                                //     onPressed: (){},
                                //     child: Text(
                                //       "Lupa Password",
                                //       style: GoogleFonts.readexPro(
                                //           fontSize: 16,
                                //           fontWeight: FontWeight.bold,
                                //           color: const Color(0xFF14181B)
                                //       ),
                                //     )
                                // ),
                              ],
                            ),
                          ),
                          Form(
                            key: controller.formkeyAuthReferral,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey
                                      )
                                  ),
                                  margin: const EdgeInsets.all(20),
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: DropdownButton<String>(
                                    elevation: 2,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Color(0xFF95A1AC),
                                      size: 24,
                                    ),
                                    value: controller.partnerType.value,
                                    borderRadius: BorderRadius.circular(8),
                                    underline: const SizedBox(),
                                    isExpanded: true,
                                    items: controller.partnerList.map((element) {
                                      return DropdownMenuItem(
                                        value: element,
                                        child: Text(
                                          element,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) => controller.partnerType(value),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: controller.edtReferral,
                                    style: GoogleFonts.readexPro(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: const Color(0xFF95A1AC),
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Kode Refferal',
                                      labelStyle: GoogleFonts.readexPro(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xFF95A1AC),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFF4B39EF)
                                          )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.grey
                                          )
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFF1D2428)
                                          )
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.red
                                          )
                                      ),
                                      contentPadding: const EdgeInsets.all(24),
                                    ),
                                    validator: Validatorless.required("Kode refferal tidak boleh kosong"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: LugoButton(
                                      textButton: 'Daftar',
                                      textColor: Colors.white,
                                      textSize: 12,
                                      width: Get.width * 0.5,
                                      height: Get.height* 0.06,
                                      color: const Color(0xFF3978EF),
                                      onTap: () {
                                        if(controller.formkeyAuthReferral.currentState!.validate() && controller.partnerType.value != "Bergabung sebagai?"){
                                          Get.toNamed(
                                              Routes.form_join,
                                              arguments: {
                                                'partner_type' : controller.partnerType.value,
                                                'referal' : controller.edtReferral.text,
                                              }
                                          );
                                        }
                                      }
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]
                    )),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}