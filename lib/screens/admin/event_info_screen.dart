


import 'package:flutter/material.dart';
import 'package:hatan/models/effectiveness.dart';

import '../../widget/filed_view.dart';

class EventInfoScreen extends StatelessWidget {
  final Effectiveness effectiveness;

  const EventInfoScreen({Key? key, required this.effectiveness}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:  const Color(0xFFA0dbf1),
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left , color: Colors.black,),),
          title:  const Text('معلومات الفعالية' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

        ),
        backgroundColor:  const Color(0xFFA0dbf1),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0 ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FiledView(title: 'رقم الفعالية',value: effectiveness.id.toString()),
                FiledView(title: 'اسم الفعالية',value: effectiveness.name),
                FiledView(title: 'عدد ساعات الفعالية',value: effectiveness.hours.toString()),
                FiledView(title: 'التاريخ',value: effectiveness.date),
                FiledView(title: 'الوقت',value: effectiveness.time),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: Text(
                          'المكان:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: double.infinity,
                        child: Text(
                          effectiveness.place,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const Divider(color: Colors.black12,thickness: 3,),
                      const SizedBox(
                        height: 40,
                        width: double.infinity,

                        child: Text(
                          'الأهداف:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: double.infinity,
                        child: Text(
                          effectiveness.goals,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const Divider(color: Colors.black12,thickness: 3,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
