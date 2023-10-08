import 'package:committee/data/authprovider.dart';
import 'package:committee/screens/leadscreen.dart';
import 'package:committee/utils/colors.dart';
import 'package:committee/utils/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authcontroller.dart';
import 'loginscreen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());
  final AuthProvider authProvider = Get.put(AuthProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              boldText("Committee", ColorResources.black, 26.0),
              const SizedBox(
                height: 40,
              ),
              textField("Full Name",
                  controller: authController.fullnameController),
              const SizedBox(
                height: 15,
              ),
              textField("Username",
                  controller: authController.usernamController),
              const SizedBox(
                height: 15,
              ),
              textField("Contact Number",
                  controller: authController.numberController),
              const SizedBox(
                height: 15,
              ),
              textField("Password",
                  controller: authController.passwordController,obscureText:true),
              SizedBox(
                height:  15 ,
              ),
               textField("Country",
                  controller: authController.countryController),
              SizedBox(
                height:  15 ,
              ),
               textField("City",
                  controller: authController.cityController),
              SizedBox(
                height:  15 ,
              ),
               textField("Zip Code",
                  controller: authController.zipController),

              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(LoginScreen());
                },
                child: lightText(
                     "Have an account already? Log-in",
                    ColorResources.black,
                    14.0),
              ),

              const SizedBox(
                height: 40,
              ),
              containerButton(
                      () async {
                     bool res=await authProvider.updateSignUpData(number: authController.numberController.text,password: authController.passwordController.text,fullname: authController.fullnameController.text,username: authController.usernamController.text,country: authController.countryController.text,city: authController.cityController.text,zip: authController.zipController.text);
                     if(res)
                       Get.to(LeadScreen());

                  }, "Sign up"),

            ],
          ),
        ),

    );
  }
}
