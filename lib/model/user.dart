import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? fname;
  String? lname;
  String? phone;
  String? userProfileImageUrl;
  String? location;

  UserModel({this.id, this.email, this.lname, this.fname, this.phone});

  UserModel.fromSnapShot(DocumentSnapshot userSnapShot) {
    id = userSnapShot.id;
    email = userSnapShot['email'];
    fname = userSnapShot['fname'];
    lname = userSnapShot['lname'];
    phone = userSnapShot['phone'];
    location = userSnapShot['location'];
    userProfileImageUrl = userSnapShot['userProfileImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['fname'] = fname;
    data['lname'] = lname;
    data['phone'] = phone;
    data['location'] = location;
    data['userProfileImageUrl'] = userProfileImageUrl;
    return data;
  }
}
