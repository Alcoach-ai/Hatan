

import 'package:flutter/material.dart';

class ButtonHome extends StatelessWidget {
  final String title;
  final Function onTapped;
  final IconData? icon ;
  final Function? onTapIcon;
  final IconData? removeIcon;
  final Function? onTapRemoveIcon;

  const ButtonHome({required this.title, required this.onTapped, Key? key, this.icon, this.onTapIcon, this.removeIcon, this.onTapRemoveIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTapped();
      },
      child: Container(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(onTapRemoveIcon != null)
              SizedBox(
                width: 40,
                child: IconButton(
                  onPressed: (){
                    if(onTapRemoveIcon != null){
                      onTapRemoveIcon!();
                    }
                  }, icon: const Icon(Icons.playlist_remove),
                ),
              ),

            Expanded(
              child: SizedBox(
                  child: Text(title ,maxLines: 2,textAlign: TextAlign.center,  style: const TextStyle(color: Colors.black,fontSize: 16 ,fontWeight: FontWeight.bold ,),)),
            ),
            SizedBox(
                width: 40,
                child: IconButton(
                  onPressed: (){
                    if(onTapIcon != null){
                      onTapIcon!();
                    }else{
                      onTapped();
                    }
                  },
                  icon: const Icon(Icons.chevron_right),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
