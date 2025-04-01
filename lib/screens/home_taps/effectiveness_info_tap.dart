import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/current_effectiveness_cubit.dart';
import 'package:hatan/widget/show_toast.dart';

import '../../models/effectiveness.dart';
import '../../widget/button_hatan.dart';
import '../../widget/filed_view.dart';
import '../../widget/show_dialog.dart';

class EffectivenessInfoTap extends StatelessWidget {
  final Effectiveness effectiveness;
  final TabController tabController;

  const EffectivenessInfoTap({Key? key,required this.effectiveness, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => CurrentEffectivenessCubit(),
        child: BlocConsumer<CurrentEffectivenessCubit, CurrentEffectivenessState>(
          listener: (context, state) {

            if(state is JoinToEffectivenessDown){
              showConfirmDialog(context , tabController, null);
            }else if (state is JoinToEffectivenessError){
              showToast(text: 'حدث خطأ الرجاء إعادة المحاولة لاحقا', color: Colors.redAccent);
            }else if (state is AlreadyRegistered){
              showToast(text: 'انت مشترك بالفعل', color: Colors.redAccent);
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            return Padding(
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

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: ButtonHatan(text:effectiveness.isRegistration? 'مغادرة' : 'الإنضمام', width: 100 ,  onTapped: (){
                        if(!CurrentEffectivenessCubit.get(context).isLoading) {
                          if(effectiveness.isRegistration){
                            CurrentEffectivenessCubit.get(context).exitEffectiveness(context, tabController, effectiveness);
                          }else{
                            CurrentEffectivenessCubit.get(context).joinToEffectiveness(effectiveness);
                          }
                        }
                      },
                        height: 35,
                        color: CurrentEffectivenessCubit.get(context).isLoading?Colors.grey.withOpacity(0.5):null,),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
