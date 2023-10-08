import 'package:committee/data/authprovider.dart';
import 'package:committee/screens/loginscreen.dart';
import 'package:committee/utils/colors.dart';
import 'package:committee/utils/commonwidgets.dart';
import 'package:committee/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authcontroller.dart';

class GoogleSigninScreen extends StatelessWidget {
  GoogleSigninScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());
  final AuthProvider authProvider = Get.put(AuthProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            boldText("Committee", ColorResources.black, 26.0),
            const SizedBox(
              height: 20,
            ),
            mediumText("Experience the power of collaboration with Khist – your ultimate committee management app. Streamline communication, enhance efficiency, and make decisions seamlessly. Elevate your committee experience, download now!", ColorResources.black, 16.0),
            const SizedBox(
              height: 40,
            ),
            Image.asset(AppImages.backgroundPng),
            InkWell(
              onTap: () {
                Get.to(LoginScreen());
              },
              child: lightText("Have an account already? Log-in",
                  ColorResources.black, 14.0),
            ),
            const SizedBox(
              height: 40,
            ),
            containerButton(() {
             authProvider.signInWithGoogle();
            }, "Sign In with Google"),
          ],
        ),
      ),
    );
  }
}
