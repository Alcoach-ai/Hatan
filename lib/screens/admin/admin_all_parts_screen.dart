
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/registration_cubit.dart';
import 'package:hatan/screens/admin/add_section_screen.dart';
import 'package:hatan/screens/auth/team_screen.dart';
import '../../widget/button_hatan.dart';

class AdminAllParts extends StatelessWidget {
  const AdminAllParts({Key? key}) : super(key: key);

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
            title: const Text('الأقسام الهتانيه' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

          ),
          backgroundColor:  const Color(0xFFA0dbf1),
          body: BlocProvider(
            create: (context) => RegistrationCubit()..getAllSections(),
            child: BlocConsumer<RegistrationCubit, RegistrationState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                int index = 0;


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
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 550,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        const SizedBox(height: 32,),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1/.4,
                                children:RegistrationCubit.get(context).sections.map<Widget>((e) {
                                  return  ButtonHatan(
                                    text: e.name,
                                    height: 40,
                                    width: 125,
                                    onTapped: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (_) => TeamScreen(title:  e.name , sectionId: e.id)));
                                    },
                                  );
                                }
                                ).toList(),

                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 16),
                          alignment: Alignment.center,
                          child: ButtonHatan(
                              text: 'إضاقة قسم',
                              height: 45,
                              width: 100,
                              onTapped: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_) =>  AddSectionScreen(registrationCubit: RegistrationCubit.get(context))));
                              }
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ),
    );
  }
}
