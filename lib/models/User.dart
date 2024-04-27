import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String ProfilePhoto;
  String email;
  String uid;

  User({
    required this.name,
    required this.ProfilePhoto,
    required this.email,
    required this.uid,
  });

  Map<String, dynamic> toJson() =>
      {'name': name, 'ProfilePhoto': ProfilePhoto, 'email': email, 'uid': uid};

  static User fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      name: snapshot['name'],
      ProfilePhoto: snapshot['ProfilePhoto'],
      email: snapshot['email'],
      uid: snapshot['uid'],
    );
  }
}
