import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:committee/screens/leadscreen.dart';
import 'package:committee/screens/otp%20screen.dart';
import 'package:committee/screens/participantscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/verfiyotp.dart';

class AuthProvider extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var verificationId = ''.obs;

  Future<void> signInWithPhone(String phone,) async {
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
         // UserCredential userCredential= await firebaseAuth.signInWithCredential(credential);
         //  if(userCredential.user!=null)
         //    print("success");
         //  else print("error1");
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
          if (exception.code == 'invalid-phone-numer') {
            Get.snackbar(
                "Failed to Verify!", "The phone number provided is not valid");
          } else {
            Get.snackbar(
                "Failed to Verify!", "Something went wrong, Try again!");
          }
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
        });
  }

  Future<void> verifyOtp(String otp) async {
    AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp);
    // UserCredential result = await firebaseAuth.signInWithCredential(credential);

    // return result.user != null ? true : false;
  }

  void uploadProfileMetadata(profileData, userId) async {
    firebaseFirestore.collection('Profiles').doc(userId).set(profileData);
  }

   Future<bool> signInWithGoogle() async {
    bool res = false;
    EasyLoading.show(status: 'loading...');
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
      await firebaseAuth.signInWithCredential(credentials).timeout(Duration(seconds: 10),onTimeout: ()=>
          showSnackbar(
              title: 'Timeout', message: 'Timeout failed to sign up with google,retry')
      );;
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await FirebaseFirestore.instance.collection('Profiles')
              .doc(user.uid)
              .set({
            "userId": user.uid,
            "fullName": '',
            "contactNumber": '',
            "username": '',
            "country": '',
            "city":'',
            "zipCode":''
          });
        }
        EasyLoading.dismiss();
        res = true;
        Get.to(OtpScreen());
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      showSnackbar(title: 'Failed to sign in',
          message: e.toString(),);
      res = false;
    }
    return res;
  }

  Future<bool> updateSignUpData({number, password, fullname, username, country, city, zip}) async {
    try {
      EasyLoading.show(status: 'loading...');
      User? firebaseUser = firebaseAuth.currentUser;;
      if (firebaseUser != null) {
        uploadProfileMetadata({
          "userId": firebaseUser.uid,
          "fullName": fullname,
          "contactNumber": number,
          "username": username,
          "country": country,
          "city":city,
          "zipCode":zip
        }, firebaseUser.uid);
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.dismiss();
        return false;
      }
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.message.toString());
    }
    return false;
  }

  Future<bool> handleSignIn({email, password}) async {
    try {
      EasyLoading.show(status: 'loading...');
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      if (firebaseUser != null) {
        final ref = await firebaseFirestore
            .collection("Profiles")
            .doc(firebaseUser.uid)
            .get();
        if (ref.data()!['role'] == "Lead") {
          Get.to(LeadScreen());
        }
        if (ref.data()!['role'] == "Participant") {
          Get.to(const ParticipantScreen());
        }
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.dismiss();
        return false;
      }
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.message.toString());
    }

    return false;
  }

  Future<void> resetPassword({required String email}) async {
    try {
      EasyLoading.show(status: 'loading...');
      await firebaseAuth.sendPasswordResetEmail(email: email);
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: "Email Sent!");
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  Future<void> handleSignOut() async {
    await firebaseAuth.signOut();
  }

  showSnackbar({required String title, required String message}) {
    return Get.snackbar(title, message);
  }
}
