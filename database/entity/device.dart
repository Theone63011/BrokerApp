import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class device {

  int device_id;

  String device_authid;

  String device_os;

  String device_name;

  String device_model;

  String device_version;

  int user_id;

  DateTime device_created;

  DateTime device_updated;

  // New device (required fields only)
  device(this.device_authid, this.device_os, this.user_id);

  // Setup only for reads from DB, not writes
  device.fromJson(Map<String, dynamic> json):
        device_id = json['device_id'],
        device_authid = json['device_authid'],
        device_os = json['device_os'],
        device_name = json['device_name'],
        device_model = json['device_model'],
        device_version = json['device_version'],
        user_id = json['user_id'],
        device_created = json['device_created'],
        device_updated = json['device_updated'];

  // Setup only for writes to DB for the FIRST time
  Map<String, dynamic> toJson() => {
    'device_authid':device_authid,
    'device_os':device_os,
    'device_name':device_name,
    'device_model':device_model,
    'device_version':device_version,
    'user_id':user_id
  };
}