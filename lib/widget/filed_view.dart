


import 'package:flutter/material.dart';

class FiledView extends StatelessWidget {
  final String title;
  final String value;
  final double? width;
  final Function? onTapped;
  const FiledView({Key? key, required this.title, required this.value, this.width,  this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 55,
            width: width ?? 130,
            child: Text(
              '$title:',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    (onTapped!=null)?IconButton(onPressed: (){onTapped!();}, icon:const Icon(Icons.chevron_right) , splashRadius: 30,):Container(height: 35,),
                  ],
                ),
                const Divider(color: Colors.black12,thickness: 3,)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
