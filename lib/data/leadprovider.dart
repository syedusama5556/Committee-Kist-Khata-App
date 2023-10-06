import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';


class LeadProvider extends GetxController {


  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;

  void uploadCommitteeMetadata(committeeData) async {
    firebaseFirestore
        .collection('Committees')
        .add(committeeData);
  }
  



}
