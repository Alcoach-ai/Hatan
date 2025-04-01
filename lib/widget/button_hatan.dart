
import 'package:flutter/material.dart';

class ButtonHatan extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Function onTapped;
  final Color? color;
  final Color? fontColor;

  const ButtonHatan({Key? key, required this.height, required this.width, required this.text, required this.onTapped, this.color, this.fontColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTapped();
      },
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color?? Colors.blue,
          borderRadius: BorderRadius.circular(9999),
        ),
          child: Text(text ,style: TextStyle(color: fontColor??Colors.white , fontWeight: FontWeight.bold),)
      ),
    );
  }
}
