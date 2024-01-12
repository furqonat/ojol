import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validatorless/validatorless.dart';
import '../../shared/custom_widget/lugo_button.dart';
import 'controller_form.dart';

class PageFormJoin extends GetView<ControllerFormJoin>{
  const PageFormJoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: ()=> Get.back(),
          style: IconButton.styleFrom(
              backgroundColor: const Color(0xFF3978EF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)
              )
          ),
          icon: const Icon(Icons.chevron_left_rounded, color: Colors.white),
        ),
      ),
      body: Obx(() => Form(
          key: controller.formkeyAuthRegister,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("*Form Email")),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                autofocus: false,
                                controller: controller.edtEmail,
                                keyboardType: TextInputType.emailAddress,
                                style: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xFF95A1AC),
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: GoogleFonts.readexPro(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: const Color(0xFF95A1AC),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: const BorderSide(
                                          width: 1, color: Color(0xFF4B39EF))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.grey)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: const BorderSide(
                                          width: 1, color: Color(0xFF1D2428))),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red)),
                                  contentPadding: const EdgeInsets.all(24),
                                ),
                                validator: Validatorless.multiple([
                                  Validatorless.required(
                                      'Email tidak boleh kosong'),
                                  Validatorless.email('Email tidak sesuai')
                                ]),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                controller: controller.edtPassword,
                                obscureText: controller.showPassword.value,
                                keyboardType: TextInputType.visiblePassword,
                                style: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xFF95A1AC),
                                ),
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: GoogleFonts.readexPro(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: const Color(0xFF95A1AC),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color(0xFF4B39EF))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.grey)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color(0xFF1D2428))),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.red)),
                                    contentPadding: const EdgeInsets.all(24),
                                    suffixIcon: GestureDetector(
                                      onTap: () => controller.showPassword.value
                                          ? controller.showPassword(false)
                                          : controller.showPassword(true),
                                      child: Icon(
                                          controller.showPassword.value
                                              ? Icons.visibility_rounded
                                              : Icons.visibility_off_rounded,
                                          color: const Color(0xFF95A1AC)),
                                    )),
                                validator: Validatorless.multiple([
                                  Validatorless.required(
                                      'Password tidak boleh kosong'),
                                  Validatorless.min(8, 'Password tidak sesuai')
                                ]),
                              )),
                        ],
                      )),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text("*Form Driver")),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    autofocus: false,
                    controller: controller.edtFullName,
                    style: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
                      labelStyle: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF95A1AC),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF4B39EF))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Colors.grey)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF1D2428))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Colors.red)),
                      contentPadding: const EdgeInsets.all(24),
                    ),
                    validator: Validatorless.required("Nama tidak boleh kosong"),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    autofocus: false,
                    controller: controller.edtCompleteAddress,
                    style: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Alamat Lengkap',
                      labelStyle: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF95A1AC),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF4B39EF))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Colors.grey)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF1D2428))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Colors.red)),
                      contentPadding: const EdgeInsets.all(24),
                    ),
                    validator: Validatorless.required("Alamat tidak boleh kosong"),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.phone,
                    controller: controller.edtPhone,
                    style: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Nomor Ponsel',
                      labelStyle: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF95A1AC),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF4B39EF))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Colors.grey)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF1D2428))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Colors.red)),
                      contentPadding: const EdgeInsets.all(24),
                    ),
                    validator: Validatorless.required("Nomor ponsel tidak boleh kosong"),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    autofocus: false,
                    controller: controller.edtBrandTransport,
                    style: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Merk Kendaraan (Xenia, Avanza, Brio)',
                      labelStyle: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF95A1AC),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF4B39EF))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Colors.grey)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF1D2428))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Colors.red)),
                      contentPadding: const EdgeInsets.all(24),
                    ),
                    validator: Validatorless.required(
                        "Pastikan jenis kendaraan anda tidak kosong"),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    autofocus: false,
                    controller: controller.edtYearTransport,
                    style: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Tahun Kendaraan',
                      labelStyle: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF95A1AC),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF4B39EF))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Colors.grey)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF1D2428))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Colors.red)),
                      contentPadding: const EdgeInsets.all(24),
                    ),
                    validator: Validatorless.required("Tahun kendaraan tidak boleh kosong"),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    autofocus: false,
                    controller: controller.edtPlateTransport,
                    style: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Plat Kendaraan',
                      labelStyle: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF95A1AC),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF4B39EF))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Colors.grey)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(width: 1, color: Color(0xFF1D2428))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide:const BorderSide(width: 1, color: Colors.red)),
                      contentPadding: const EdgeInsets.all(24),
                    ),
                    validator: Validatorless.required("Plat kendaraan tidak boleh kosong"),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog.adaptive(
                      content: Text(
                        'Ingin ambil gambar dari mana?',
                        style: GoogleFonts.readexPro(fontSize: 12),
                      ),
                      actions: [
                        OutlinedButton(
                            onPressed: () {
                              controller.getKTPFromFile();
                              Get.back();
                            },
                            child: Text(
                              'Galeri',
                              style: GoogleFonts.readexPro(fontSize: 12),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              controller.getKTPFromCamera();
                              Get.back();
                            },
                            child: Text(
                              'Kamera',
                              style: GoogleFonts.readexPro(fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                  child: controller.viewKTP.value.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                                width: Get.width,
                                height: Get.height * 0.25,
                                fit: BoxFit.cover,
                                File(controller.viewKTP.value)),
                          ),
                        )
                      : Container(
                          width: Get.width,
                          height: Get.height * 0.25,
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          child: Text(
                            'Upload KTP',
                            style: GoogleFonts.readexPro(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3978EF),
                            ),
                          ),
                        ),
                ),
              ),
              SliverToBoxAdapter(
                  child: GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog.adaptive(
                    content: Text(
                      'Ingin ambil gambar dari mana?',
                      style: GoogleFonts.readexPro(fontSize: 12),
                    ),
                    actions: [
                      OutlinedButton(
                          onPressed: () {
                            controller.getSTNKFromFile();
                            Get.back();
                          },
                          child: Text(
                            'Galeri',
                            style: GoogleFonts.readexPro(fontSize: 12),
                          )),
                      OutlinedButton(
                          onPressed: () {
                            controller.getSTNKFromCamera();
                            Get.back();
                          },
                          child: Text(
                            'Kamera',
                            style: GoogleFonts.readexPro(fontSize: 12),
                          )),
                    ],
                  ),
                ),
                child: controller.viewSTNK.value.isEmpty
                    ? Container(
                        width: Get.width,
                        height: Get.height * 0.25,
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.center,
                        child: Text(
                          'Upload STNK',
                          style: GoogleFonts.readexPro(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3978EF),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(controller.viewSTNK.value),
                            width: Get.width,
                            height: Get.height * 0.25,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              )),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog.adaptive(
                      content: Text(
                        'Ingin ambil gambar dari mana?',
                        style: GoogleFonts.readexPro(fontSize: 12),
                      ),
                      actions: [
                        OutlinedButton(
                            onPressed: () {
                              controller.getSIMFromFile();
                              Get.back();
                            },
                            child: Text(
                              'Galeri',
                              style: GoogleFonts.readexPro(fontSize: 12),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              controller.getSIMFromCamera();
                              Get.back();
                            },
                            child: Text(
                              'Kamera',
                              style: GoogleFonts.readexPro(fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                  child: controller.viewSIM.value.isEmpty
                      ? Container(
                          width: Get.width,
                          height: Get.height * 0.25,
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          child: Text(
                            'Upload SIM',
                            style: GoogleFonts.readexPro(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3978EF),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(controller.viewSIM.value),
                              width: Get.width,
                              height: Get.height * 0.25,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog.adaptive(
                      content: Text(
                        'Ingin ambil gambar dari mana?',
                        style: GoogleFonts.readexPro(fontSize: 12),
                      ),
                      actions: [
                        OutlinedButton(
                            onPressed: () {
                              controller.getKendaraanFromFile();
                              Get.back();
                            },
                            child: Text(
                              'Galeri',
                              style: GoogleFonts.readexPro(fontSize: 12),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              controller.getKendaraanFromCamera();
                              Get.back();
                            },
                            child: Text(
                              'Kamera',
                              style: GoogleFonts.readexPro(fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                  child: controller.viewKendaraan.value.isEmpty
                      ? Container(
                          width: Get.width,
                          height: Get.height * 0.25,
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.center,
                          child: Text(
                            'Upload Foto Kendaraan',
                            style: GoogleFonts.readexPro(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3978EF),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(controller.viewKendaraan.value),
                              width: Get.width,
                              height: Get.height * 0.25,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: LugoButton(
                      textButton: "Simpan Profile",
                      textColor: Colors.white,
                      textSize: 12,
                      width: Get.width * 0.45,
                      height: Get.height * 0.07,
                      color: const Color(0xFF3978EF),
                      onTap: () {
                        if (controller.formkeyAuthRegister.currentState!.validate()) {
                          controller.firebaseRegister(context);
                        }
                      }),
                ),
              )
            ],
      ))),
    );
  }
}

