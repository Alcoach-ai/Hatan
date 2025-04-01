import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/models/validators.dart';

import '../local/cache_helper.dart';
import '../models/dio_helper.dart';
import '../models/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  User? user ;
  TextEditingController passwordForm = TextEditingController();
  TextEditingController emailForm = TextEditingController();
  bool isNotAcceptableData = false;
  bool isLoading = false;
  bool passwordVisible = true;
  bool validator(){
    if(passwordForm.text.isNotEmpty && emailForm.text.isValidEmail() ){
        isNotAcceptableData = false;
      return true;
    }
    isNotAcceptableData = true;
    emit(LoginIsNotAcceptableData());
    return false;

  }

  void login({required String email, required String password})async{
    isLoading = true;
    emit(LoginLoading());
    DioHelper.postData(url: 'login', data: {
      'email':email.trim(),
      'password':password.trim(),
    }).then((value) {
    isLoading = false;
      if(value == null  || value.data.toString().contains('error')){
        if (kDebugMode) {
          print('User not found!!!!!');
        }
        emit(LoginUserIsNull());
        return ;
      }
    if (kDebugMode) {
      print( 'state code for login is ${value.statusCode}');
      print(value.data);
    }

    user = User.fromJson(value.data) ;

      CacheHelper.saveData(key: 'email', value: user!.email);
      CacheHelper.saveData(key: 'id', value: user!.id);
      CacheHelper.saveData(key: 'type', value: user!.type??0);


      emit(LoginSuccess());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(LoginError());
    });
  }

  void hidePass(){
    passwordVisible = !passwordVisible;
    emit(PassHide());
  }


}
