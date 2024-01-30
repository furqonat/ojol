import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  String? msg;
  String? attachment;
  String? idSender;
  String? chatFor;
  DateTime? time;
  String? orderTransaksiId;

  Chat({
    this.msg,
    this.idSender,
    this.chatFor,
    this.time,
    this.orderTransaksiId,
    this.attachment,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    msg: json["msg"],
    idSender: json["id_sender"],
    chatFor: json["chatFor"],
    time: (json["time"] as Timestamp).toDate(),
    orderTransaksiId: json["orderTransaksiId"],
    attachment: json["attachment"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "id_sender": idSender,
    "chatFor": chatFor,
    "time": time,
    "orderTransaksiId": orderTransaksiId,
    "attachment": attachment,
  };
}
