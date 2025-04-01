import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/models/effectiveness.dart';

import '../local/cache_helper.dart';
import '../models/dio_helper.dart';
import '../widget/confirmation_dialog.dart';
import '../widget/show_dialog.dart';


part 'joint_effectiveness_state.dart';

class JointEffectivenessCubit extends Cubit<JointEffectivenessState> {
  JointEffectivenessCubit() : super(JointEffectivenessInitial());
  static JointEffectivenessCubit get(context) => BlocProvider.of(context);

  List<Effectiveness> effectiveness = [];

  void getJointEffectiveness (){
    emit(JointEffectivenessLoading());
    DioHelper.postData(url: 'getRegisteredEvents', data:{
      'id': CacheHelper.getData(key: 'id'),
    }).then((value) {
      if(value == null){
        emit(JointEffectivenessError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for home data is ${value.statusCode}');
        print(value.data);
      }
      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in get home tab data!!!!!');
        }
        emit(JointEffectivenessError());
        return ;
      }
      effectiveness = List<Effectiveness>.from(value.data.map((e) {
        Effectiveness effectiveness =Effectiveness.fromJson(e);
        effectiveness.isRegistration = true;
        return effectiveness;
      }));

      if(effectiveness.isEmpty){
        emit(JointEffectivenessEmpty());
        return;
      }


      emit(JointEffectivenessDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(JointEffectivenessError());
    });

  }


  void exitEffectiveness(BuildContext context ,TabController tabController ,Effectiveness effectiveness  ){
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return ConfirmationDialog(
          noOnPressed: () {
            Navigator.pop(context1);
          },
          yesOnPressed: (){
            Navigator.pop(context1);
            showConfirmDialog(context, tabController , 'تم الإنسحاب من الفعالية بنجاح');
          },
          title: 'هل تود الغاء التسجيل؟',
          effectiveness: effectiveness,
        );
      },
    );
  }


}
