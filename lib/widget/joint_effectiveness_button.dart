

import 'package:flutter/material.dart';

class JointEffectivenessButton extends StatelessWidget {
  final String title;
  final Function onTapped;
  const JointEffectivenessButton({Key? key, required this.title, required this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: double.infinity,
            padding:const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow:const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  offset: Offset(0, 0), // Shadow position
                ),
              ],
            ),
            child: SizedBox(
              height: 60,
                child: Center(child: Text(title ,maxLines: 2,textAlign: TextAlign.center,  style: const TextStyle(color: Colors.black,fontSize: 16 ,fontWeight: FontWeight.bold ,),))),
          ),
          InkWell(
            onTap: (){
              onTapped();
            },
            child: Container(
              height: 32,
              width: 100,
              padding:const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(16),
                boxShadow:const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(0, 0), // Shadow position
                  ),
                ],
              ),
              child:const Center(child: Text('إلغاء التسجيل' ,maxLines: 2,textAlign: TextAlign.center,  style:  TextStyle(color: Colors.white,fontSize: 12 ,fontWeight: FontWeight.bold ,),)),
            ),
          ),
        ],
      ),
    );
  }
}
