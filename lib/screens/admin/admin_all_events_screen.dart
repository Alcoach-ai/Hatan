import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/models/effectiveness.dart';
import 'package:hatan/screens/admin/event_info_screen.dart';

import '../../bloc/current_effectiveness_cubit.dart';
import '../../widget/button_home.dart';
import '../auth/team_screen.dart';

class AdminAllEventsScreen extends StatelessWidget {
  const AdminAllEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    StateEvent  stateEvent = StateEvent.all;
    CurrentEffectivenessCubit cubit = CurrentEffectivenessCubit();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor:  const Color(0xFFA0dbf1),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor:  const Color(0xFFA0dbf1),
            shadowColor: Colors.transparent,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left , color: Colors.black,),
            ),
            title:  const Text('الفعاليات' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(75.0),
              child:BlocProvider(
                create: (context) {
                  return cubit;
                },
                child:BlocConsumer<CurrentEffectivenessCubit, CurrentEffectivenessState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonFormField<StateEvent>(
                        decoration: const InputDecoration(labelText: 'فلتر حسب:' ,labelStyle: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
                        value:stateEvent,
                        items: StateEvent.values.map((state) {
                          return DropdownMenuItem<StateEvent>(
                            value: state,
                            alignment: Alignment.centerRight,
                            child: Text(state.value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if(value == null){
                            return;
                          }
                          stateEvent = value;
                          CurrentEffectivenessCubit.get(context).getCurrentEffectivenessAdmin(value.id);
                        },
                      ),
                    );
                  },
                ) ,
              ),
            ),
        ),
        body: BlocProvider(
          create: (context) {

            cubit.getCurrentEffectivenessAdmin(stateEvent.id);
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


              if(state is CurrentEffectivenessEmpty) {
                return const Center(
                  child: Text(
                    'لا يوجد فعاليات حالياً',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:  Colors.black,fontSize: 18, fontFamily: 'Tajawal'
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
                            CurrentEffectivenessCubit.get(context).getCurrentEffectivenessAdmin(stateEvent.id);
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
              List<Effectiveness> effectiveness = CurrentEffectivenessCubit.get(context).effectiveness;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children:effectiveness.map<Widget>((e){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 8),
                        child: ButtonHome(
                            title:e.name ,
                            onTapRemoveIcon: (){
                              CurrentEffectivenessCubit.get(context).removeEffectiveness(context, e);
                            },
                            onTapped:(){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_) =>  TeamScreen(title: 'المتطوعين' ,eventId:e.id)));
                            },
                            onTapIcon:(){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (_) =>  EventInfoScreen(effectiveness: e,)));
                            }

                        ),
                      );
                    }).toList(),
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
