import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:committee/screens/leadscreen.dart';
import 'package:committee/screens/participantscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class AuthProvider extends GetxController {


  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

  void uploadProfileMetadata(profileData,userId) async {
   firebaseFirestore
        .collection('Profiles')
        .doc(userId)
        .set(profileData);
  }

 Future<bool> handleSignUp(
      {email,
        password,
        username,
        number,
        role}) async {
    try {
      EasyLoading.show(status: 'loading...');
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      if (firebaseUser != null) {
        uploadProfileMetadata(
          {
            "userId": firebaseUser.uid,
            "fullName": username,
            "emailAddress": email,
            "contactNumber": number,
            "role": role,
          },firebaseUser.uid
        );
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
        final ref= await firebaseFirestore.collection("Profiles").doc(firebaseUser.uid).get();
        if(ref.data()!['role']=="Lead"){
          Get.to( LeadScreen());
        }
        if(ref.data()!['role']=="Participant"){
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
}
