import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/current_effectiveness_cubit.dart';

import '../../widget/button_home.dart';
import '../home_screen.dart';

class CurrentEffectivenessTap extends StatelessWidget {
  final TabController tabController;

  const CurrentEffectivenessTap({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        CurrentEffectivenessCubit cubit = CurrentEffectivenessCubit();
        cubit.getCurrentEffectiveness();
        return cubit;
      },
      child: BlocConsumer<CurrentEffectivenessCubit, CurrentEffectivenessState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is CurrentEffectivenessLoading){
            return const Center(
              child:CircularProgressIndicator() ,
            );
          }

          if(state is CurrentEffectivenessEmpty){
            return const Center(
              child: Text(
                'لا يوجد فعاليات حالياً',
                textAlign: TextAlign.center,
                style: TextStyle(

                    color:  Colors.black, fontSize: 18, fontFamily: 'Tajawal',
                ),
              ),
            );
          }

          if(state is CurrentEffectivenessError) {
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
                        CurrentEffectivenessCubit.get(context).getCurrentEffectiveness();
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

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children:CurrentEffectivenessCubit.get(context).effectiveness.map<Widget>((e){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 8),
                    child: ButtonHome(
                        title:e.name ,
                        onTapped:(){
                          selectedEffectiveness = e;
                          tabController.animateTo(4);
                        }
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
