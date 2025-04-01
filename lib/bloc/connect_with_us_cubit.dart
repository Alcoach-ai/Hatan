import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../local/cache_helper.dart';
import '../models/dio_helper.dart';

part 'connect_with_us_state.dart';

class ConnectWithUsCubit extends Cubit<ConnectWithUsState> {
  ConnectWithUsCubit() : super(ConnectWithUsInitial());
  static ConnectWithUsCubit get(context) => BlocProvider.of(context);
  TextEditingController messageForm = TextEditingController();

  bool isLoading = false;

  void sendData(){
    isLoading = true;
    emit(ConnectWithUsSending());

    DioHelper.postData(url: 'contactAdmin', data:{
      'userId': CacheHelper.getData(key: 'id'),
      'message': messageForm.text,
    }).then((value) {
      if(value == null){
        emit(ConnectWithUsError());
        return ;
      }
      isLoading = false;

      if (kDebugMode) {
        print( 'state code for sendData data is ${value.statusCode}');
        print(value.data);
      }
      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in sendData data!!!!!');
        }

        print(value.data['error']);

        emit(ConnectWithUsError());
        return ;
      }
      messageForm.text = '';
      emit(ConnectWithUsDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      isLoading = false;
      emit(ConnectWithUsError());
    });

  }


}
