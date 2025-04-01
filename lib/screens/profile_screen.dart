
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/profile_cubit.dart';
import 'package:hatan/bloc/team_cubit.dart';
import 'package:hatan/models/volunteer.dart';
import 'package:hatan/screens/profile_update_screen.dart';
import 'package:hatan/widget/button_hatan.dart';

import '../models/user.dart';
import '../widget/filed_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Directionality(
        textDirection: TextDirection.rtl,
        child:Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor:  const Color(0xFFA0dbf1),
              shadowColor: Colors.transparent,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.chevron_left , color: Colors.black,),),
              title:  const Text('المعلومات الشخصية' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

            ),
            backgroundColor:  const Color(0xFFA0dbf1),
            body: BlocProvider(
              create: (context) {
                ProfileCubit cubit  = ProfileCubit();
                cubit.getProfile();
                return cubit ;
              },
              child: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if(state is ProfileLoading){
                    return const Center(
                      child:CircularProgressIndicator() ,
                    );
                  }

                  if(state is ProfileError) {
                    return Center(
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'عذراً حدث خطأ ما',
                              style: TextStyle(
                                  color:  Colors.black,fontSize: 18, fontFamily: 'Tajawal'
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                ProfileCubit.get(context).getProfile();
                              },
                              child: const Text(
                                'إعادة محاولة',
                                style: TextStyle(
                                    color:  Colors.indigo,fontSize: 18, fontFamily: 'Tajawal', fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                          ],
                        )
                    );
                  }

                  User user = ProfileCubit.get(context).user!;


                  return Container(
                    constraints: const BoxConstraints(
                      minHeight: 550,
                    ),
                    height: height,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: ListView(
                        children: [
                          FiledView(title: 'الأسم',value: user.fullName,),
                          FiledView(title: 'رقم الهوية',value: user.idNumber,),
                          FiledView(title: 'رقم الجوال',value: user.phone,onTapped: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (_) => ProfileUpdateScreen(user: user,profileCubit: ProfileCubit.get(context),)));
                          },),
                          FiledView(title: 'تاريخ الميلاد',value: user.bornDate,),
                          FiledView(title: 'البريد الالكتروني',value: user.email,onTapped: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (_) => ProfileUpdateScreen(user: user,profileCubit: ProfileCubit.get(context),)));
                          },),
                          FiledView(title: (user.teamName!=null)?'الفريق':'القسم',value: (user.teamName!=null)? 'الفريق ${user.team}':user.sectionName!,),
                          const SizedBox(height: 50,),
                          Container(
                            padding: const EdgeInsets.only(bottom: 16),
                            alignment: Alignment.center,
                            child: ButtonHatan(
                                text: 'تعديل',
                                height: 45,
                                width: 100,
                                onTapped:(){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (_) => ProfileUpdateScreen(user: user,profileCubit: ProfileCubit.get(context),)));
                                },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
        ),
    );

  }
}
