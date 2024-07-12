import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String username;

  UserModel({
    required this.id,
    required this.username,
  });

  // static function to create an empty user model
  static UserModel empty() => UserModel(
        id: '',
        username: '',
      );

// convert model to json structure for starting data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Username': username,
    };
  }

  //factory method to create a usermodel from a firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        username: data['Username'] ?? '',
      );
    } else {
      throw StateError('Document does not exist');
    }
  }
}
