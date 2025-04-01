

import 'package:flutter/material.dart';

class RadioButtonHatan extends StatelessWidget {
 final int value;
 final int groupValue;
 final String title;
 final Function(int?) onChange;
  const RadioButtonHatan({Key? key, required this.value, required this.groupValue, required this.title, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      value: value,
      title:  Text(title , maxLines: 1,style:const TextStyle(color: Colors.indigo,fontSize: 18,fontWeight: FontWeight.bold),),
      groupValue: groupValue,
      onChanged: onChange,
    );
  }
}
