

import 'package:flutter/material.dart';
import 'package:hatan/screens/profile_screen.dart';
import 'package:hatan/screens/auth/start_screen.dart';

import '../local/cache_helper.dart';
import '../screens/connect_with_us_screen.dart';


class DrawerBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const DrawerBody({Key? key, required this.scaffold,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50,),
            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: (){
                scaffold.currentState!.closeEndDrawer();
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) =>  const ProfileScreen()));
                }, child:  const Align( alignment: Alignment.centerRight,  child: Text('المعلومات الشخصية' ,maxLines: 1,textAlign: TextAlign.right,  style:TextStyle(color: Colors.black,fontSize: 16 ,),))),
            ),
            const Divider(color: Colors.black12, thickness: 3),
            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: (){
                scaffold.currentState!.closeEndDrawer();
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) =>  const ConnectWithUsScreen()));
              }, child:  const Align( alignment: Alignment.centerRight,  child: Text('تواصل مع الإدارة' ,maxLines: 1,textAlign: TextAlign.right,  style:TextStyle(color: Colors.black,fontSize: 16 ,),))),
            ),            const Divider(color: Colors.black12, thickness: 3),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(color: Colors.black12, thickness: 3),
            TextButton(onPressed: (){
              CacheHelper.clearData();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) {
                    return const StartScreen();
                  }), (route) => false);

            }, child: Row(
              children: const[
                Icon(Icons.exit_to_app , size: 32, color: Colors.black,),
                SizedBox(width: 4,),
                Text('الخروج' ,maxLines: 1,textAlign: TextAlign.right,  style:TextStyle(color: Colors.black,fontSize: 16 ,),),
              ],
            )),
          ],
        ),
      ],
    );
  }
}
