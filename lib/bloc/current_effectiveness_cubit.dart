import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/models/effectiveness.dart';
import 'package:hatan/widget/confirmation_dialog.dart';
import 'package:hatan/widget/show_dialog.dart';

import '../local/cache_helper.dart';
import '../models/dio_helper.dart';

part 'current_effectiveness_state.dart';

class CurrentEffectivenessCubit extends Cubit<CurrentEffectivenessState> {
  CurrentEffectivenessCubit() : super(CurrentEffectivenessInitial());
  static CurrentEffectivenessCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;

  List<Effectiveness> effectiveness = [];

  void getCurrentEffectiveness (){
    emit(CurrentEffectivenessLoading());
    DioHelper.getData(url: 'getEvents?admin=2&type=3', query: {}).then((value) {
      if(value == null){
        emit(CurrentEffectivenessError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for home data is ${value.statusCode}');
        print(value.data);
      }
      if( value.data.toString().contains('error') ){
        if (kDebugMode) {
          print('Error in get home tab data!!!!!');
        }
        emit(CurrentEffectivenessError());
        return ;
      }

      effectiveness = List<Effectiveness>.from(value.data.map((e)=>Effectiveness.fromJson(e)));

      if(effectiveness.isEmpty){
        emit(CurrentEffectivenessEmpty());
        return;
      }

      emit(CurrentEffectivenessDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(CurrentEffectivenessError());
    });
  }

  void getCurrentEffectivenessAdmin (int type){
    emit(CurrentEffectivenessLoading());
    DioHelper.getData(url: 'getEvents?admin=1&type=$type', query: {}).then((value) {
      if(value == null){
        emit(CurrentEffectivenessError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for home data is ${value.statusCode}');
        print(value.data);
      }
      if( value.data.toString().contains('error') ){
        if (kDebugMode) {
          print('Error in get home tab data!!!!!');
        }
        emit(CurrentEffectivenessError());
        return ;
      }

      if(value.data is List) {
        effectiveness = List<Effectiveness>.from(value.data.map((e)=>Effectiveness.fromJson(e)));
      }

      if(effectiveness.isEmpty){
        emit(CurrentEffectivenessEmpty());
        return;
      }

      emit(CurrentEffectivenessDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(CurrentEffectivenessError());
    });
  }


  joinToEffectiveness(Effectiveness effectiveness){
    isLoading = true;
    emit(JoinToEffectivenessLoading());
    DioHelper.postData(url: 'joinEvent', data:{
      'id': CacheHelper.getData(key: 'id'),
      'eventId': effectiveness.id,
    }).then((value) {
      if(value == null){
        emit(JoinToEffectivenessError());
        return ;
      }
      isLoading = false;

      if (kDebugMode) {
        print( 'state code for home data is ${value.statusCode}');
        print(value.data);
      }
      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in join data!!!!!');
        }

        if(value.data['error'] == 'Already registered'){
          emit(AlreadyRegistered());
          return;
        }
        print(value.data['error']);

        emit(JoinToEffectivenessError());
        return ;
      }
      emit(JoinToEffectivenessDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      isLoading = false;
      emit(JoinToEffectivenessError());
    });
  }

  exitEffectiveness(BuildContext context ,TabController tabController ,Effectiveness effectiveness  ){
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


  removeEffectiveness(BuildContext context ,Effectiveness effectiveness  ){
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return ConfirmationDialog(
          noOnPressed: () {
            Navigator.pop(context1);
          },
          yesOnPressed: (){
            getCurrentEffectiveness();
            Navigator.pop(context1);
          },
          title: 'هل تود حذف الفعالية؟',
          effectiveness: effectiveness,
        );
      },
    );
  }


}
