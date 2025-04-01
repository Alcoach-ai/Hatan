
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/registration_cubit.dart';
import 'package:hatan/screens/auth/team_screen.dart';
import 'package:hatan/widget/show_toast.dart';
import '../../widget/button_hatan.dart';

class AdminAllTeam extends StatelessWidget {
  const AdminAllTeam({Key? key}) : super(key: key);

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
            title: const Text('الفرق الهتانيه' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

          ),
          backgroundColor:  const Color(0xFFA0dbf1),
          body: BlocProvider(
            create: (context) => RegistrationCubit()..getAllTeam(),
            child: BlocConsumer<RegistrationCubit, RegistrationState>(
              listener: (context, state) {
                if(state is AddTeamDown){
                  RegistrationCubit.get(context).getAllTeam();
                }
                if(state is AddTeamError){
                  showToast(text: 'حدث خطأ ما الرجاء المحاولة لاحقا', color: Colors.redAccent);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                int index=-1;

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
                              RegistrationCubit.get(context).getAllTeam();
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

                if(RegistrationCubit.get(context).teams.isEmpty){
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
                                children:RegistrationCubit.get(context).teams.map<Widget>((e) {
                                  return  ButtonHatan(
                                    text: e.name,
                                    height: 40,
                                    width: 125,
                                    onTapped: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (_) => TeamScreen(title:  e.name , teamId: e.id)));
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
                              text: 'إضاقة فريق',
                              height: 45,
                              width: 100,
                              color: RegistrationCubit.get(context).isLoading?Colors.grey.withOpacity(0.5): null,
                              onTapped: (){
                                if(!RegistrationCubit.get(context).isLoading){
                                  RegistrationCubit.get(context).addTeam();
                                }
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
