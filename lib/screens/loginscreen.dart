import 'package:committee/data/authprovider.dart';
import 'package:committee/screens/googlesigninscreen.dart';
import 'package:committee/screens/otp%20screen.dart';
import 'package:committee/utils/colors.dart';
import 'package:committee/utils/commonwidgets.dart';
import 'package:committee/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authcontroller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());
  final AuthProvider authProvider = Get.put(AuthProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              boldText("Committee", ColorResources.black, 26.0),
              const SizedBox(
                height: 40,
              ),

              textField("Email Address",
                  controller: authController.emailController),
              const SizedBox(
                height: 20,
              ),
              textField("Password",
                  controller: authController.passwordController,obscureText:true),

              const SizedBox(
                height: 10,
              ),

              InkWell(
                  onTap: () {
                    Get.to(GoogleSigninScreen());
                  },
                  child: lightText(
                       "Don't have an account already? Sign-up"
                         ,
                      ColorResources.black,
                      14.0),
                ),

              const SizedBox(
                height: 40,
              ),
              containerButton(
                    () {

                        authProvider.handleSignIn(email: authController.emailController.text,password: authController.passwordController.text);


                    }, "Login" ),

            ],
          ),
        ),

    );
  }
}
