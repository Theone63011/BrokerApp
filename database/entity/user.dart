import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
//part 'user.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
//@JsonSerializable()
class user {

  //@JsonKey(required: true)
  int user_id;

  //@JsonKey(required: true)
  String user_authid;

  //@JsonKey(required: true)
  String user_email;

  //@JsonKey(required: false)
  String user_firstname;

  //@JsonKey(required: false)
  String user_lastname;

  //@JsonKey(required: false)
  String user_phonenumber;

  //@JsonKey(required: true)
  DateTime user_created;

  //@JsonKey(required: true)
  DateTime user_updated;

  // New User (required fields only)
  user(this.user_authid, this.user_email);

  // Setup only for reads from DB, not writes
  user.fromJson(Map<String, dynamic> json):
        user_id = json['user_id'],
        user_authid = json['user_authid'],
        user_email = json['user_email'],
        user_firstname = json['user_firstname'],
        user_lastname = json['user_lastname'],
        user_phonenumber = json['user_phonenumber'],
        user_created = json['user_created'],
        user_updated = json['user_updated'];

  // Setup only for writes to DB for the FIRST time
  Map<String, dynamic> toJson() => {
//    'user_id':user_id,
    'user_authid':user_authid,
    'user_email':user_email,
    'user_firstname':user_firstname,
    'user_lastname':user_lastname,
    'user_phonenumber':user_phonenumber
//    'user_created':user_created,
//    'user_updated':user_updated
  };

  //TODO- Decode example:
  //Map userMap = jsonDecode(jsonString);
  //var user = User.fromJson(userMap);
  //print('Howdy, ${user.name}!');
  //print('We sent the verification link to ${user.email}.');

  //TODO- Encode example:
  //String json = jsonEncode(user);


  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  //factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  //Map<String, dynamic> toJson() => _$UserToJson(this);


}