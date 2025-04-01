import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/models/effectiveness.dart';

import '../local/cache_helper.dart';
import '../models/dio_helper.dart';
import '../models/user.dart';

part 'dialog_out_state.dart';

class DialogOutCubit extends Cubit<DialogOutState> {
  DialogOutCubit() : super(DialogOutInitial());
 static DialogOutCubit get(context) => BlocProvider.of(context);

  void exit(BuildContext context , Effectiveness effectiveness){
    emit(ExitLoading());
    DioHelper.postData(url: 'cancelRegisteredEvent', data:{
      'userId': CacheHelper.getData(key: 'id'),
      'eventId': effectiveness.id,
    }).then((value) {
      if(value == null){
        emit(ExitError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for cancelRegisteredEvent data is ${value.statusCode}');
        print(value.data);
      }
      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in exit data!!!!!');
        }
        emit(ExitError());
        return ;
      }

      emit(ExitDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ExitError());
    });
  }
  void removeEvent(BuildContext context , Effectiveness effectiveness){
    emit(ExitLoading());
    DioHelper.postData(url: 'deleteEvent', data:{
      'id': effectiveness.id,
    }).then((value) {
      if(value == null){
        emit(ExitError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for remove event data is ${value.statusCode}');
        print(value.data);
      }
      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in remove !!!!!');
        }
        emit(ExitError());
        return ;
      }
      emit(ExitDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ExitError());
    });
  }
  void removeVolunteer(BuildContext context , User volunteer){
    emit(ExitLoading());
    DioHelper.postData(url: 'deleteTeamMember', data:{
      'id': volunteer.id,
    }).then((value) {
      if(value == null){
        emit(ExitError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for remove volunteer data is ${value.statusCode}');
        print(value.data);
      }
      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in remove !!!!!');
        }
        emit(ExitError());
        return ;
      }
      emit(ExitDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ExitError());
    });
  }
}
