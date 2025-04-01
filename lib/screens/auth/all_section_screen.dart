
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/registration_cubit.dart';
import 'package:hatan/screens/auth/welcome_screen.dart';
import 'package:hatan/widget/show_toast.dart';

import '../../local/cache_helper.dart';
import '../../widget/button_hatan.dart';
import '../../widget/radio_button.dart';

class AllSectionScreen extends StatelessWidget {
  const AllSectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
            title:  const Text('الأقسام الهتانيه' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

          ),
          backgroundColor:  const Color(0xFFA0dbf1),
          body:BlocProvider(
            create: (context) => RegistrationCubit()..getAllSections(),
            child: BlocConsumer<RegistrationCubit, RegistrationState>(
              listener: (context, state) {
                if(state is ChooseSectionDown){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const WelcomeScreen()));
                }else if (state is ChooseSectionError) {
                  showToast(text: "حدث خطأ ما الرجاء إعادة المحاولة", color: Colors.redAccent);
                }else if(state is SorryIDoNotHaveSectionEmpty){

                }

                // TODO: implement listener
              },
              builder: (context, state) {

                if(state is GetAllSectionsLoading){
                  return const Center(
                    child:CircularProgressIndicator(),
                  );
                }

                if(state is GetAllSectionsError) {
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
                              RegistrationCubit.get(context).getAllSections();
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

                if(RegistrationCubit.get(context).sections.isEmpty){
                  return const Center(
                    child: Text(
                      'عذراً القائمة فراغة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:  Colors.black,fontSize: 18, fontFamily: 'Tajawal'
                      ),
                    ),
                  );
                }


                return SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                      const SizedBox(height: 32,),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: RegistrationCubit.get(context).sections.map<Widget>((e) =>
                                RadioButtonHatan(
                                  value: e.id,
                                  title: e.name,
                                  groupValue: RegistrationCubit.get(context).section, onChange: (value) {
                                  if(value != null){
                                    RegistrationCubit.get(context).selectSection(value);
                                  }
                                },
                                ),
                            ).toList(),
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
                              child: ButtonHatan(
                                text: 'دخول',
                                height: 32,
                                width: 100,
                                color: RegistrationCubit.get(context).isLoading? Colors.grey.withOpacity(0.5): null,
                                onTapped: (){
                                  if(!RegistrationCubit.get(context).isLoading){
                                    RegistrationCubit.get(context).chooseSection(CacheHelper.getData(key: 'id'), RegistrationCubit.get(context).section);
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                              child: ButtonHatan(
                                text: 'الرجوع', height: 32, width: 100,
                                onTapped: (){
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
      ),
    );
  }
}
