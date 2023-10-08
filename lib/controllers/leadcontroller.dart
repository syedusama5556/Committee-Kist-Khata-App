import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LeadController extends GetxController{
  var addNewCommittee=false.obs;
  var duration=0.obs;
  var participantsCount=0.obs;
  // var selectedOption="".obs;
  TextEditingController nameController=TextEditingController();
  TextEditingController amountController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController countryController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController zipController=TextEditingController();

}