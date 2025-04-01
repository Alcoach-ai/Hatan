import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/models/user.dart';
import 'package:hatan/models/validators.dart';

import '../local/cache_helper.dart';
import '../models/dio_helper.dart';


part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  TextEditingController passwordForm = TextEditingController();
  TextEditingController emailForm = TextEditingController();
  TextEditingController rePasswordForm = TextEditingController();
  TextEditingController phoneForm = TextEditingController();
  User? user ;
  bool isNotAcceptableData = false;

  bool isLoading = false;

  void init(User user){
    phoneForm.text = user.phone;
    emailForm.text = user.email;
    emit(ProfileInitial());
  }

  void getProfile(){

    emit(ProfileLoading());
    DioHelper.postData(url: 'profile', data: {
      'id': CacheHelper.getData(key: 'id'),
    }).then((value) {

      if(value == null  || value.data['error'] == 'User not found'){
        if (kDebugMode) {
          print('User not found!!!!!');
        }
        emit(ProfileError());
        return ;
      }
      if (kDebugMode) {
        print( 'state code for profile is ${value.statusCode}');
        print(value.data);
      }

      user = User.fromJson(value.data) ;

      emit(ProfileDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ProfileError());
    });

  }

  void profileUpdate(User user , BuildContext context , ProfileCubit profileCubit){
    isLoading = true;
    emit(ProfileLoading());
    DioHelper.postData(url: 'updateProfile?id=${user.id}&phone=${phoneForm.text}&emil=${emailForm.text}', data: {}).then((value) {
      isLoading = false;
      if(value == null  || value.data.toString().contains('error')){
        if (kDebugMode) {
          print('User not found!!!!!');
        }
        emit(ProfileError());
        return ;
      }
      if (kDebugMode) {
        print( 'state code for profile update  is ${value.statusCode}');
        print(value.data);
      }
      profileCubit.getProfile();
      Navigator.pop(context);
      emit(ProfileDown());
    }).catchError((error){
      isLoading = false;
      if (kDebugMode) {
        print(error.toString());
      }
      emit(UpdateProfileError());
    });

  }

  bool validator(){

    if(phoneForm.text.isEmpty || emailForm.text.isEmpty){
      isNotAcceptableData = true;
      emit(PhoneIsNotValid());
      return false;
    }
    if(!phoneForm.text.isValidPhone()){
      isNotAcceptableData = true;
      emit(PhoneIsNotValid());
      return false;
    }

    if( !emailForm.text.isValidEmail()){
      emit(EmailIsNotValid());
      isNotAcceptableData = true;
      return false;
    }
    isNotAcceptableData = false;
    return true;

  }



}
