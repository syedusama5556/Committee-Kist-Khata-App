import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  var login=true.obs;
  var selectedOption="".obs;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController numberController=TextEditingController();
  TextEditingController nameController=TextEditingController();

}