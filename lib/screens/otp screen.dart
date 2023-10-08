import 'package:committee/screens/verfiyotp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/authprovider.dart';
import '../utils/colors.dart';
import '../utils/commonwidgets.dart';
import '../utils/fontfamily.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _selectedLocation = 'Pakistan';
  var items = ['Pakistan', 'Japan', 'South Korea', 'France'];
  bool checkedValue = false;
  final TextEditingController phoneController=TextEditingController();
  final authController=Get.put(AuthProvider());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Center(child:boldText("Committee", ColorResources.black, 40.0),),
              SizedBox(
                height: 60,
              ),
              mediumText("Country", ColorResources.black, 14.0),
              DropdownButton(
                isExpanded: true,
                value: _selectedLocation,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: ColorResources.black,
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(
                        color: ColorResources.black,
                        fontSize: 14,
                        fontFamily: TextFontFamily.poppinsRegular,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue.toString();
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              mediumText("Phone Number", ColorResources.black, 14.0),
              TextField(
                controller: phoneController,
                cursorColor: ColorResources.black,
                style: TextStyle(
                  color: ColorResources.black,
                  fontSize: 14,
                  fontFamily: TextFontFamily.poppinsRegular,
                ),
                decoration: InputDecoration(
                  hintText: "+92 333-555-666-9",
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintStyle: TextStyle(
                    color: ColorResources.grey9CA,
                    fontSize: 14,
                    fontFamily: TextFontFamily.poppinsRegular,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: ColorResources.grey9CA, width: 0.8),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: ColorResources.grey9CA, width: 0.8),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CheckboxListTile(
                fillColor: MaterialStateProperty.all(ColorResources.black),
                title: regularText("Agree to terms & conditions",
                    ColorResources.black, 14.0),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              Spacer(),
              containerButton(() {
                authController.signInWithPhone(phoneController.text.trim());
                // authController.verifyOtp("123456");
                Get.to(VerifyOtpScreen());
              }, "Send Otp",)
            ],
          ),
        ),
      ),
    );
  }
}
