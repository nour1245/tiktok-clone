import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/models/usermodel.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';
import 'package:tiktok_clone/views/screens/login_screen.dart';
import 'package:tiktok_clone/views/widgets/constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<File?> _pickedImage;
  late Rx<User?> _user;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());

    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  File? get profilePic => _pickedImage.value;

  //upload to firebaseStorage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorge
        .ref()
        .child('ProfileImages')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downlaodUrl = await snap.ref.getDownloadURL();
    return downlaodUrl;
  }

//picking image
  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Success', 'Image Picked');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //register
  void registerUser(
      String userName, String password, String email, File? image) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save user in firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);
        UserModel userModel = UserModel(
          name: userName,
          email: email,
          uid: cred.user!.uid,
          profilePic: downloadUrl,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(userModel.toJson());
        print('succes data send');
      } else {
        Get.snackbar('Error', 'Please Enter all the fields');
        print('sign eerror');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print('sign eerror');
    }
  }

//login

  void loginUser(
    String email,
    String password,
  ) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar('Error', 'Email or password are wrong');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
