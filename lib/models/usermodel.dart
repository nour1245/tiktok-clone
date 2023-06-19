import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String profilePic;
  String email;
  String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.profilePic,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilepic": profilePic,
        "email": email,
        "uid": uid,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        name: snapshot['name'],
        email: snapshot['email'],
        uid: snapshot['uid'],
        profilePic: snapshot['profilepic']);
  }
}
