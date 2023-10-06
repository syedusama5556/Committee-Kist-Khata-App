import 'package:committee/utils/colors.dart';
import 'package:committee/utils/commonwidgets.dart';
import 'package:flutter/material.dart';

class ParticipantScreen extends StatelessWidget {
  const ParticipantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          boldText("Participant Screen", ColorResources.black, 26.0,TextAlign.center)
        ],
      ),
    );
  }
}
