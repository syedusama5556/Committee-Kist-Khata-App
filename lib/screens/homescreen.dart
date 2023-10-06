import 'package:committee/data/authprovider.dart';
import 'package:committee/utils/colors.dart';
import 'package:committee/utils/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authcontroller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());
  final AuthProvider authProvider = Get.put(AuthProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
          ()=> Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              boldText("Committee", ColorResources.black, 26.0),
              const SizedBox(
                height: 40,
              ),
              authController.login.isFalse?textField("Full Name",
                  controller: authController.nameController):const SizedBox.shrink(),
              const SizedBox(
                height: 20,
              ),
              textField("Email Address",
                  controller: authController.emailController),
              const SizedBox(
                height: 20,
              ),
              textField("Password",
                  controller: authController.passwordController,obscureText:true),
              SizedBox(
                height: authController.login.isFalse? 20 : 0,
              ),
              authController.login.isFalse? textField("Contact Number",
                  controller: authController.numberController):const SizedBox.shrink(),
              SizedBox(
                height: authController.login.isFalse? 20 : 0,
              ),

              authController.login.isFalse? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                      (states) => ColorResources.black),
                              splashRadius: 5,
                              value: 'Participant',
                              groupValue: authController.selectedOption.value,
                              onChanged: (value) {
                                authController.selectedOption.value =
                                    value.toString();
                              },
                            ),
                            mediumText(
                                "Participant", ColorResources.black, 16.0),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                      (states) => ColorResources.black),
                              splashRadius: 5,
                              value: 'Lead',
                              groupValue: authController.selectedOption.value,
                              onChanged: (value)  async {
                                authController.selectedOption.value =
                                    value.toString();
                              },
                            ),
                            mediumText("Lead", ColorResources.black, 16.0)
                          ],
                        ),
                      ],
                    ):const SizedBox.shrink(),

              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    authController.login.toggle();
                  },
                  child: lightText(
                      authController.login.isTrue
                          ? "Don't have an account already? Sign-up"
                          : "Have an account already? Log-in",
                      ColorResources.black,
                      14.0),
                ),

              const SizedBox(
                height: 40,
              ),
              containerButton(
                    () {
                      if(authController.login.isTrue)
                        authProvider.handleSignIn(email: authController.emailController.text,password: authController.passwordController.text);
                      else
                        authProvider.handleSignUp(email: authController.emailController.text,password: authController.passwordController.text,username: authController.nameController.text,number: authController.numberController.text,role: authController.selectedOption.toString());

                    }, authController.login.isTrue ? "Login" : "Sign up"),

            ],
          ),
        ),
      ),
    );
  }
}
