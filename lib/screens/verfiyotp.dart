import 'package:committee/data/authprovider.dart';
import 'package:committee/data/leadprovider.dart';
import 'package:committee/screens/loginscreen.dart';
import 'package:committee/screens/leadscreen.dart';
import 'package:committee/screens/signupscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../utils/colors.dart';
import '../utils/commonwidgets.dart';
import '../utils/fontfamily.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({Key? key}) : super(key: key);

  final controller = TextEditingController();
  final focusNode = FocusNode();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
      fontFamily: TextFontFamily.poppinsBold,
      fontSize: 18,
      color: ColorResources.black,
    ),
    decoration: const BoxDecoration(),
  );
  final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: ColorResources.grey9CA,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );
  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: ColorResources.grey9CA,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  final authController=Get.put(AuthProvider());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 60,),
              boldText("Secure Verification", ColorResources.black, 25.0),
              SizedBox(height: 30,),
              mediumText("Enter the One-Time Password (OTP) sent to your registered email or phone number to ensure safe access. Your security is our priority.", ColorResources.black, 16.0),
              SizedBox(height: 30,),
              Center(
                child: Pinput(
                  length: 6,
                  pinAnimationType: PinAnimationType.slide,
                  controller: controller,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  showCursor: true,
                  cursor: cursor,
                  preFilledWidget: preFilledWidget,
                ),
              ),
              SizedBox(height: 40,),
              lightText("Secure Verification Code on the Way! New OTP in: 01:54", ColorResources.black, 12.0),

              Spacer(),
              mediumText("Didn't receive your OTP? Request a new one now.", ColorResources.black, 13.0),
              SizedBox(height: 20,),
              containerButton(() async {
               await authController.verifyOtp(controller.text.trim());
                 Get.to(SignupScreen());
              }, "Continue", )
            ],
          ),
        ),
      ),
    );
  }


  }
