import 'package:committee/controllers/leadcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/commonwidgets.dart';

class LeadScreen extends StatelessWidget {
  LeadScreen({Key? key}) : super(key: key);
  final LeadController leadController = Get.put(LeadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leadController.addNewCommittee.isTrue ? Text("data") : SizedBox()
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorResources.black,
        onPressed: () {
          leadController.addNewCommittee.toggle();
          Get.bottomSheet(Container(
            height: Get.height / 1.25,
            decoration: BoxDecoration(
              color: ColorResources.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Obx(() {
                return Column(
                  children: [
                    textField("Committee Name",
                        controller: leadController.nameController),
                    SizedBox(
                      height: 20,
                    ),
                    textField("Monthly amount per person",
                        controller: leadController.amountController,
                        key: TextInputType.number),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        mediumText("Committee Duration in years",
                            ColorResources.white, 14.0),
                        SizedBox(
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        mediumText("Number of Participants",
                            ColorResources.white, 14.0),
                        SizedBox(
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
                            leadController.participantsCount.value.toString(),
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
                    SizedBox(
                      height: 20,
                    ),
                    boldText(
                        "Total amount: Rs. ${
                            leadController.amountController.text.isNotEmpty?
                            int.parse(leadController.amountController.text.toString()) * leadController.participantsCount.value*leadController.duration.value:0}",
                        ColorResources.white,
                        16.0),
                  ],
                );
              }),
            ),
          ));
        },
        child: Icon(
          Icons.add,
          color: ColorResources.white,
          size: 30,
        ),
      ),
    );
  }
}
