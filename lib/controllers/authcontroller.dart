import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  var login=true.obs;
  var selectedOption="".obs;
  TextEditingController numberController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController usernamController=TextEditingController();
  TextEditingController fullnameController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController countryController=TextEditingController();
  TextEditingController zipController=TextEditingController();

}