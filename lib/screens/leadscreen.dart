import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:committee/controllers/leadcontroller.dart';
import 'package:committee/data/leadprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/commonwidgets.dart';

class LeadScreen extends StatelessWidget {
  LeadScreen({Key? key}) : super(key: key);
  final LeadController leadController = Get.put(LeadController());
  final LeadProvider leadProvider = Get.put(LeadProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

            ],
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorResources.black,
        onPressed: () {
          leadController.addNewCommittee.toggle();
          Get.bottomSheet(
            SingleChildScrollView(
              child: Container(
                height: Get.height ,
                decoration: const BoxDecoration(
                  color: ColorResources.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: Obx(
                    () {
                      return Column(
                        children: [
                          boldText("Create a new committee", ColorResources.white,
                              14.0),
                          const SizedBox(
                            height: 15,
                          ),
                          textField("Committee Name",
                              controller: leadController.nameController),
                          const SizedBox(
                            height: 15,
                          ),
                          textField("Monthly amount per person",
                              controller: leadController.amountController,
                              key: TextInputType.number),
                          const SizedBox(
                            height: 15,
                          ),textField("Description",
                              controller: leadController.descriptionController,),
                          const SizedBox(
                            height: 15,
                          ),textField("Country",
                              controller: leadController.countryController,
                              ),
                          const SizedBox(
                            height: 15,
                          ),textField("City",
                              controller: leadController.cityController,
                             ),
                          const SizedBox(
                            height: 15,
                          ),textField("Zip Code",
                              controller: leadController.zipController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              mediumText("Committee Duration in months",
                                  ColorResources.white, 14.0),
                              const SizedBox(
                                width: 20,
                              ),
                              leadController.duration.value != 0
                                  ? IconButton(
                                      icon: const Icon(
                                        CupertinoIcons.minus,
                                        size: 20,
                                        color: ColorResources.white,
                                      ),
                                      onPressed: () {
                                        leadController.duration.value--;
                                      },
                                    )
                                  : const SizedBox.shrink(),
                              mediumText(leadController.duration.value.toString(),
                                  ColorResources.white, 14.0),
                              IconButton(
                                icon: const Icon(
                                  CupertinoIcons.add,
                                  size: 20,
                                  color: ColorResources.white,
                                ),
                                onPressed: () {
                                  leadController.duration.value++;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              mediumText("Number of Participants",
                                  ColorResources.white, 14.0),
                              const SizedBox(
                                width: 20,
                              ),
                              leadController.participantsCount.value != 0
                                  ? IconButton(
                                      icon: const Icon(
                                        CupertinoIcons.minus,
                                        size: 20,
                                        color: ColorResources.white,
                                      ),
                                      onPressed: () {
                                        leadController.participantsCount.value--;
                                      },
                                    )
                                  : const SizedBox.shrink(),
                              mediumText(
                                  leadController.participantsCount.value
                                      .toString(),
                                  ColorResources.white,
                                  14.0),
                              IconButton(
                                icon: const Icon(
                                  CupertinoIcons.add,
                                  size: 20,
                                  color: ColorResources.white,
                                ),
                                onPressed: () {
                                  leadController.participantsCount.value++;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          boldText(
                              "Total amount: Rs. ${leadController.amountController.text.isNotEmpty ? int.parse(
                                    leadController.amountController.text
                                        .toString(),
                                  ) * leadController.participantsCount.value * leadController.duration.value : 0}",
                              ColorResources.white,
                              16.0),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () async {
                                String committeeId= DateTime.now().toIso8601String();
                                leadProvider.uploadCommitteeMetadata({
                                  "committeeName":
                                      leadController.nameController.text,
                                  "monthlyAmountPerPerson":
                                      leadController.amountController.text,
                                  "participantsCount":
                                      0,
                                  "totalParticipants":
                                  leadController.participantsCount.value,
                                  "createdAt":Timestamp.now(),
                                  "committeeDuration":
                                      leadController.duration.value,
                                  "totalAmount":
                                      "${leadController.amountController.text.isNotEmpty ? int.parse(
                                            leadController.amountController.text
                                                .toString(),
                                          ) * leadController.participantsCount.value * leadController.duration.value : 0}",
                                  "participants": [],
                                  "active": false,
                                  "description":leadController.descriptionController.text,
                                  "started": false,
                                  "country":leadController.countryController.text,
                                  "city":leadController.cityController.text,
                                  "zipCode":leadController.zipController.text,
                                "committeeId":committeeId,
                                  "committeeOwnerUserId":
                                      FirebaseAuth.instance.currentUser!.uid
                                },committeeId);
                              },
                              child: boldText("Save", ColorResources.white, 16.0),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: ColorResources.white,
          size: 30,
        ),
      ),
    );
  }
}
