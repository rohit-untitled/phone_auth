import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:phoneauth/features/authentication/models/user_model.dart';
import 'package:phoneauth/utils/popups/loaders.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  var username = ''.obs;
  var phoneNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // print('User is logged in: ${user.uid}'); // Debug print
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          UserModel userModel =
              UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
          username.value = userModel.username;
          phoneNumber.value = userModel.phoneNumber;
          // print('User data retrieved: ${userDoc.data()}'); // Debug print
        } else {
          // print('User document does not exist'); // Debug print
          TLoaders.successSnackbar(title: 'Enter your username');
        }
      } else {
        // print('No user is logged in'); // Debug print
        TLoaders.errorSnackBar(title: 'User is not logged in');
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error retrieving user data');
      // print('Error retrieving user data: $e'); // Debug print
    }
  }
}
