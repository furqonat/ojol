import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  String? msg;
  String? idSender;
  String? idReceiver;
  DateTime? time;
  String? idTransaksi;
  String? attachment;

  Chat({
    this.msg,
    this.idSender,
    this.idReceiver,
    this.time,
    this.idTransaksi,
    this.attachment,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    msg: json["msg"],
    idSender: json["id_sender"],
    idReceiver: json["id_receiver"],
    time: (json["time"] as Timestamp).toDate(),
    idTransaksi: json["id_transaksi"],
    attachment: json["attachment"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "id_sender": idSender,
    "id_receiver": idReceiver,
    "time": time,
    "id_transaksi": idTransaksi,
    "attachment": attachment,
  };
}
