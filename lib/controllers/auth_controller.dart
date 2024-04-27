import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/User.dart' as model;
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth_Controller extends GetxController {
  static Auth_Controller instance = Get.find();
  // late Rx<File?> _pickedImage;
  late Rx<File?> _pickedImage = Rx<File?>(null);
  late Rx<User?> _user;
  User get user => _user.value!;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(Firebase_auth.currentUser);
    _user.bindStream(Firebase_auth.authStateChanges());
    ever(_user, setinitialscreen);
  }

  setinitialscreen(User? user) {
    if (user == null) {
      Get.offAll(() => Login_Screen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  File? get profilePhoto => _pickedImage.value;

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();

    final pickedImage = await showDialog<ImageSource>(
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          elevation: 0.0,
          backgroundColor: Colors.black,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select Image Source",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.camera_alt, color: Colors.white),
                      SizedBox(width: 10.0),
                      Text(
                        "Camera",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.photo_library, color: Colors.white),
                      SizedBox(width: 10.0),
                      Text(
                        "Gallery",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (pickedImage != null) {
      final pickedFile = await _picker.pickImage(source: pickedImage);
      if (pickedFile != null) {
        Get.snackbar(
          'Profile Image',
          'You have successfully picked your profile image',
        );
        _pickedImage.value = File(pickedFile.path);
        // _pickedImage = Rx<File?>(File(pickedFile.path));
      }
    }
  }

  Future<String> _uploadToDatabase(File image) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Encode the image to base64
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    // Construct the request body
    Map<String, dynamic> requestBody = {
      'userId': userId,
      'imageData': base64Image,
    };

    // Make the HTTP POST request
    final url = Uri.https(
        'tiktok-22380-default-rtdb.firebaseio.com', '/Profile_pics.json');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String imageKey = responseData['name']; // Firebase generated key
      String downloadURL =
          'https://tiktok-22380-default-rtdb.firebaseio.com/Profile_pics/$imageKey/imageData';

      return downloadURL;
    } else {
      throw Exception('Failed to upload image');
    }
  }

  // Future<String> _uploadtostorage(File image) async {
  //   Reference ref = Firebase_storage.ref()
  //       .child('Profile_pics')
  //       .child(Firebase_auth.currentUser!.uid);
  //   UploadTask uploadtask = ref.putFile(image);
  //   TaskSnapshot taskSnapshot = await uploadtask;
  //   String downloadURL = await taskSnapshot.ref.getDownloadURL();
  //   return downloadURL;
  // }

  void register_user(
      String Username, String Email, String password, File? image) async {
    try {
      if (Username.isNotEmpty &&
          password.isNotEmpty &&
          Email.isNotEmpty &&
          image != null) {
        UserCredential cred =
            await Firebase_auth.createUserWithEmailAndPassword(
          email: Email,
          password: password,
        );
        String downloadurl = await _uploadToDatabase(image);
        model.User user = model.User(
          name: Username,
          email: Email,
          uid: cred.user!.uid,
          ProfilePhoto: downloadurl,
        );
        await Firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
      } else {
        Get.snackbar(
            'Error Creating Account', "Please enter all the required fields");
      }
    } catch (e) {
      Get.snackbar('Error Creating Account', e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (password.isNotEmpty && email.isNotEmpty) {
        await Firebase_auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar(
            'Error Logging In Account', "Please enter all the required fields");
      }
    } catch (e) {
      Get.snackbar('Error Logging in ', e.toString());
    }
  }

  void signOut() async {
    await Firebase_auth.signOut();
  }
}
