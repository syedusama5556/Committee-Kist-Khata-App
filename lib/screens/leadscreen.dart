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
      body: Obx(
        () {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              leadController.addNewCommittee.isTrue
                  ? const Text("data")
                  : const SizedBox(),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Committees')
                      .where("committeeOwnerUserId",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context,index){
                      var data=snapshot.data!.docs[index].data();
                      return ListTile(
                        leading: boldText(data['CommitteeName'], ColorResources.black, 16.0),
                      );
                    },);

                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorResources.black,
        onPressed: () {
          leadController.addNewCommittee.toggle();
          Get.bottomSheet(
            Container(
              height: Get.height / 1.25,
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
                              leadProvider.uploadCommitteeMetadata({
                                "committeeName":
                                    leadController.nameController.text,
                                "monthlyAmountPerPerson":
                                    leadController.amountController.text,
                                "participantsCount":
                                    leadController.participantsCount.value,
                                "committeeDuration":
                                    leadController.duration.value,
                                "totalAmount":
                                    "${leadController.amountController.text.isNotEmpty ? int.parse(
                                          leadController.amountController.text
                                              .toString(),
                                        ) * leadController.participantsCount.value * leadController.duration.value : 0}",
                                "participants": [],
                                "active": false,
                                "started": false,
                                "committeeOwnerUserId":
                                    FirebaseAuth.instance.currentUser!.uid
                              });
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
