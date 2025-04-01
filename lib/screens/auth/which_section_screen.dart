import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/login_cubit.dart';
import 'package:hatan/bloc/registration_cubit.dart';
import 'package:hatan/screens/auth/all_section_screen.dart';
import 'package:hatan/screens/auth/registration_screen.dart';
import 'package:hatan/screens/auth/welcome_screen.dart';

import '../../widget/button_hatan.dart';
import '../../widget/radio_button.dart';
import '../../widget/show_toast.dart';

class WhichSectionScreen extends StatelessWidget {
  final RegistrationCubit cubit ;
  const WhichSectionScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => RegistrationCubit(),
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (context, state) {

          },
        builder: (context, state) {
          return Scaffold(
              backgroundColor:  const Color(0xFFA0dbf1),
              body: SizedBox(
                height: height,
                width: width,
                child: SingleChildScrollView(

                  child: Container(
                    height: height,
                    constraints: const BoxConstraints(
                      minHeight: 666,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        const SizedBox(height: 32,),
                        Container(
                          height: 300,
                          width: width,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Image.asset('assets/images/hatan_logo.png'),
                        ),
                        Container(
                          height: 140,
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:const [
                               Text('فريق هتان يحتوي على 15 قريق و 9 أقسام' ,textAlign: TextAlign.center, maxLines: 1,style: TextStyle(color: Colors.indigo,fontSize: 18,fontWeight: FontWeight.bold),),
                               SizedBox(height: 20,),
                               Text('الفرق تقدم فعاليات مختلفة اما الأقسام لهم فعاليات محددة' ,maxLines: 2,textAlign: TextAlign.center,  style: TextStyle(color: Colors.blue,fontSize: 14 ,fontWeight: FontWeight.bold ,),),
                               Text('وين حاب تنضم؟' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),
                            ],
                          ),
                        ),

                        Container(
                          width: 250,
                          alignment: Alignment.center,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child:RadioButtonHatan(
                                    value: 2,
                                    title: 'فريق',
                                    groupValue: RegistrationCubit.get(context).section, onChange: (value) {
                                    RegistrationCubit.get(context).selectSection(value ?? 0);
                                  },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: RadioButtonHatan(
                                    value: 1,
                                    title: 'قسم',
                                    groupValue: RegistrationCubit.get(context).section, onChange: (value) {
                                      RegistrationCubit.get(context).selectSection(value ?? 0);
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),

                        Container(
                          height: 138,
                          padding: const EdgeInsets.only(bottom: 16),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                                child: ButtonHatan(text: 'التالي', height: 32, width: 100,
                                  onTapped: (){
                                  if(RegistrationCubit.get(context).section == 2){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const WelcomeScreen()));
                                  }else{
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const AllSectionScreen()));
                                  }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                                child: ButtonHatan(text: 'الرجوع', height: 32, width: 100,
                                  onTapped: (){
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
