import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/join_to_effectiveness_cubit.dart';
import 'package:hatan/bloc/joint_effectiveness_cubit.dart';

import '../../widget/button_home.dart';
import '../../widget/joint_effectiveness_button.dart';
import '../../widget/show_dialog.dart';
import '../home_screen.dart';

class JointEffectivenessTap extends StatelessWidget {
  final TabController tabController ;
  const JointEffectivenessTap({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        JointEffectivenessCubit cubit =JointEffectivenessCubit();
        cubit.getJointEffectiveness();
        return cubit;
      },
      child: BlocConsumer<JointEffectivenessCubit, JointEffectivenessState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {

          if(state is JointEffectivenessLoading){
            return const Center(
              child:CircularProgressIndicator() ,
            );
          }

          if(state is JointEffectivenessLoading) {
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
                        JointEffectivenessCubit.get(context).getJointEffectiveness();
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

          if(state is JointEffectivenessEmpty){
            return const Center(
              child: Text(
                'لا يوجد فعاليات مسجلة',
                style: TextStyle(
                    color:  Colors.black,fontSize: 18, fontFamily: 'Tajawal'
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child:Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children:JointEffectivenessCubit.get(context).effectiveness.map<Widget>((e){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 8),
                    child: ButtonHome(
                        icon: Icons.playlist_remove,
                        title:e.name ,
                        onTapRemoveIcon: (){
                         JointEffectivenessCubit.get(context).exitEffectiveness(context , tabController , e);
                        },
                        onTapped:(){
                          selectedEffectiveness = e;
                          tabController.animateTo(4);
                        }
                    ), //JointEffectivenessButton( title:'تجريب' , onTapped:(){}),
                  );
                }).toList(),
              ),
            ) ,
          );
        },
      ),
    );
  }
}
