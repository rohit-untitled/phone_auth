import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String username;
  final String createdAt;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.username,
    required this.createdAt,
    required this.phoneNumber,
  });

  // static function to create an empty user model
  static UserModel empty() => UserModel(
        id: '',
        username: '',
        createdAt: '',
        phoneNumber: '',
      );

  // Convert model to json structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'id': id,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
    };
  }

  // Create UserModel from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      id: map['id'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: (map['createdAt'] is Timestamp)
          ? (map['createdAt'] as Timestamp).toDate().toString()
          : map['createdAt'] ?? '',
    );
  }
}
