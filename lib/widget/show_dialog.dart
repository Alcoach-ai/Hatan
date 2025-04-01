

import 'package:flutter/material.dart';
import 'package:hatan/models/effectiveness.dart';

import '../screens/home_screen.dart';
import 'join_request_dialog.dart';

showConfirmDialog(BuildContext context , TabController tabController ,String? text) {

  // show the dialog
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return JoinRequestDialog(contextScreen: context, effectiveness: selectedEffectiveness ,tabController:tabController,text: text,);
    },
  );
}
