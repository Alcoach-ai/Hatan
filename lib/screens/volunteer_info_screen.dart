
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/team_cubit.dart';
import 'package:hatan/models/volunteer.dart';
import 'package:hatan/widget/button_hatan.dart';

import '../models/user.dart';
import '../widget/filed_view.dart';

class VolunteerScreen extends StatelessWidget {
  final User volunteer;
  const VolunteerScreen({Key? key, required this.volunteer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => TeamCubit(),
      child: BlocConsumer<TeamCubit, TeamState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
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
                  title:  const Text('معلومات المتطوع' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

                ),
                backgroundColor:  const Color(0xFFA0dbf1),
                body: Container(
                  height: height,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            FiledView(title: 'الأسم',value: volunteer.fullName),
                            FiledView(title: 'رقم الهوية',value: volunteer.idNumber,),
                            FiledView(title: 'رقم الجوال',value: volunteer.phone,),
                            FiledView(title: 'تاريخ الميلاد',value: volunteer.bornDate,),
                            FiledView(title: 'البريد الالكتروني',value: volunteer.email,),
                            FiledView(title: (volunteer.teamName!= null)?'الفريق':'القسم',value:(volunteer.teamName??((volunteer.section==0)?'':volunteer.sectionName!)),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ButtonHatan(
                          text:'حذف المتطوع',
                          width: 125,
                          height: 45,
                          onTapped: (){
                            if(!TeamCubit.get(context).isLoading) {
                              TeamCubit.get(context).removeVolunteer(context, volunteer);
                            }
                          },
                          color: TeamCubit.get(context).isLoading?Colors.grey.withOpacity(0.5):null,
                        ),
                      ),
                    ],
                  ),
                )
            ),
          );
        },
      ),
    );

  }
}
