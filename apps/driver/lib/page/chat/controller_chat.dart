import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_driver/response/chat.dart';
import 'package:lugo_driver/shared/controller/controller_user.dart';
import 'api_chat.dart';

class ControllerChat extends GetxController {
  final ApiChat api;
  ControllerChat({required this.api});

  var samplechat = [
    {'user': 'user_1', 'msg': 'oi', 'attachment': ''},
    {'user': 'user_2', 'msg': 'apa?', 'attachment': ''},
    {'user': 'user_1', 'msg': 'sudah di mana?', 'attachment': ''},
    {
      'user': 'user_2',
      'msg':
          'di depan rumah, ini paket sudah sampai depan rumah lu, buka pintu nya',
      'attachment': 'assets/images/paket_sampai.jpg'
    }
  ].obs.reversed.toList();

  var receiverId = ''.obs;
  var transactionId = ''.obs;
  var attachment = ''.obs;
  var showAttachment = false.obs;

  var edtChat = TextEditingController();

  var view = ''.obs;
  var upload = ''.obs;
  late XFile? file;

  ImagePicker picker = ImagePicker();

  ControllerUser controllerUser = Get.find<ControllerUser>();

  @override
  void dispose() {
    edtChat.dispose();
    super.dispose();
  }

  Stream<List<Chat>> getChat() {
    return api.getChat(fromJson: (data) => Chat.fromJson(data)).map(
        (chatList) => chatList
            .where((chat) =>
                chat.idSender == controllerUser.user.value.id &&
                chat.idReceiver == receiverId.value &&
                chat.idTransaksi == transactionId.value)
            .toList()
            .reversed
            .toList());
  }

  sendChat() async {
    try {
      await api.sendChat(
          msg: edtChat.text,
          idSender: controllerUser.user.value.id!,
          idReceiver: receiverId.value,
          time: DateTime.now(),
          idTrx: transactionId.value,
          attachment: attachment.value);
    } catch (e, stackTrace) {
      log("$e");
      log("$stackTrace");
    }
  }

  pickImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text("Ambil gambar dari?",
            style: GoogleFonts.poppins(fontSize: 12)),
        actions: [
          OutlinedButton(
              onPressed: () {
                getFromCamera();
                Get.back();
              },
              child: Text("Camera", style: GoogleFonts.poppins(fontSize: 12))),
          OutlinedButton(
              onPressed: () {
                getFromFile();
                Get.back();
              },
              child: Text("Galeri", style: GoogleFonts.poppins(fontSize: 12)))
        ],
      ),
    );
  }

  getFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      view.value = camImage.path;
      file = camImage;
      showAttachment(true);
      // uploadImage();
    }
  }

  getFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      view.value = fileImage.path;
      file = fileImage;
      showAttachment(true);
      // uploadImage();
    }
  }

  uploadImage() async {
    if (file == null) {
      log('Error: File is null.');
      return;
    }

    String fileName = file!.name;
    final path = 'chet/attachment/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      File fileToUpload = File(file!.path);

      UploadTask uploadTask = ref.putFile(fileToUpload);

      uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        upload.value = downloadURL;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto gagal di unggah');
    }
  }
}
