import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/models/section.dart';
import 'package:hatan/models/team.dart';
import 'package:hatan/models/validators.dart';

import '../local/cache_helper.dart';
import '../models/dio_helper.dart';
import '../models/user.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  static RegistrationCubit get(context) => BlocProvider.of(context);
  User? user ;
  DateTime date = DateTime.now();
  int section = 0;
  List<Section> sections =[];
  List<Team> teams =[];
  bool isNotAcceptableData = false;
  bool isLoading = false;
  bool passwordVisible = true;


  TextEditingController birthDateForm = TextEditingController();
  TextEditingController firstNameForm = TextEditingController();
  TextEditingController secondNameForm = TextEditingController();
  TextEditingController lastNameForm = TextEditingController();
  TextEditingController passwordForm = TextEditingController();
  TextEditingController emailForm = TextEditingController();
  TextEditingController rePasswordForm = TextEditingController();
  TextEditingController phoneForm = TextEditingController();
  TextEditingController idForm = TextEditingController();
  TextEditingController sectionNameForm = TextEditingController();

  void hidePass(){
    passwordVisible = !passwordVisible;
    emit(PassHide());
  }

  void onTappedBirthDate(BuildContext context)async{
      await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now()).then((value) {
        if(value != null){
          date = value;
          birthDateForm.text = '${date.day}-${date.month}-${date.year}';
          emit(RegistrationUpdate());
        }
      });
  }

  void update(){
    emit(RegistrationUpdate());
  }

  void selectSection(int value){
    section = value;
    emit(RegistrationUpdate());
  }

  void registration(){
    isLoading = true;
    emit(RegistrationLoading());

    DioHelper.postData(url: 'register', data:{
    'bornDate': birthDateForm.text,
    'email' : emailForm.text.trim(),
    'fatherName' : secondNameForm.text.trim(),
    'firstName' : firstNameForm.text.trim(),
    'idNumber' : idForm.text,
    'lastName' : lastNameForm.text,
    'password' : passwordForm.text.trim(),
    'phone' : phoneForm.text,
    }).then((value) {
      isLoading = false;
      if(value == null){
        if (kDebugMode) {
          print('User not found!!!!!');
        }
        emit((RegistrationError()));
        return ;
      }

      if( value.data['error'] == 'email already exist'){
        if (kDebugMode) {
          print('email already exist!!!!!');
        }
        emit(EmailAlreadyExist());
        return ;
      }
      if( value.statusCode == 201){
        if (kDebugMode) {
          print('Sorry requested section full!!!!!');
        }
        emit(SorryIDoNotHavePlaceEmpty());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for registration is ${value.statusCode}');
        print(value.data);
      }
      user = User.fromJson(value.data) ;

      CacheHelper.saveData(key: 'email', value: user!.email);
      CacheHelper.saveData(key: 'id', value: user!.id);
      CacheHelper.saveData(key: 'type', value: user!.type??0);

      emit(RegistrationSuccess());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(RegistrationError());
    });

  }

  void getAllSections(){
    isLoading = true;
    emit(GetAllSectionsLoading());

    DioHelper.postData(url: 'getSections', data:{}).then((value) {
      isLoading = false;
      if(value == null){
        emit(GetAllSectionsError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for get all section is ${value.statusCode}');
        print(value.data);
      }


      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in get all sections!!!!!');
        }
        emit(GetAllSectionsError());
        return ;
      }

      sections = value.data.map<Section>((e)=>Section.fromJson(e)).toList();

      emit(GetAllSectionsDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetAllSectionsError());
    });

  }
  void getAllTeam(){
    isLoading = true;
    emit(GetAllSectionsLoading());

    DioHelper.postData(url: 'getTeams', data:{}).then((value) {
      isLoading = false;
      if(value == null){
        emit(GetAllSectionsError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for get all teams is ${value.statusCode}');
        print(value.data);
      }


      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in get all teams!!!!!');
        }
        emit(GetAllSectionsError());
        return ;
      }

      teams = value.data.map<Team>((e)=>Team.fromJson(e)).toList();

      emit(GetAllSectionsDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetAllSectionsError());
    });

  }

  void chooseSection(int userId , sectionId){
    isLoading = true;
    emit(ChooseSectionLoading());
    print(sectionId);

    DioHelper.postData(url: 'chooseSection', data:{
      'id': userId,
      'section' : sectionId,
    }).then((value) {
      isLoading = false;
      if(value == null){
        emit(ChooseSectionError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for chooseSection is ${value.statusCode}');
        print(value.data);
      }

      if(value.statusCode == 201){
        emit(SorryIDoNotHaveSectionEmpty());
        return;
      }

      if( value.data['error'] != null){
        if (kDebugMode) {
          print('Error in choose section!!!!!');
        }
        emit(ChooseSectionError());
        return ;
      }


      emit(ChooseSectionDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ChooseSectionError());
    });

  }

  void addTeam(){
    isLoading = true;
    emit(ChooseSectionLoading());

    DioHelper.postData(url: 'addTeam', data:{}).then((value) {
      isLoading = false;
      if(value == null){
        emit(AddTeamError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for add team is ${value.statusCode}');
        print(value.data);
      }

      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in add team!!!!!');
        }
        emit(AddTeamError());
        return ;
      }


      emit(AddTeamDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AddTeamError());
    });

  }
  void addSection(){
    isLoading = true;
    emit(ChooseSectionLoading());

    DioHelper.postData(url: 'addSection', data:{
      'name': sectionNameForm.text
    }).then((value) {
      isLoading = false;
      if(value == null){
        emit(AddTeamError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for add section is ${value.statusCode}');
        print(value.data);
      }

      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in add section!!!!!');
        }
        emit(AddTeamError());
        return ;
      }


      emit(AddTeamDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AddTeamError());
    });

  }

  bool validator(){
    if(!passwordForm.text.isValidPassword()){
      isNotAcceptableData = true;
      emit(PasswordIsNotValid());
      return false;
    }
    if(!phoneForm.text.isValidPhone()){
      isNotAcceptableData = true;
      emit(PhoneIsNotValid());
      return false;
    }
    if(!date.isValidAge()){
      isNotAcceptableData = true;
      emit(AgeIsNotValid());
      return false;
    }
    if(!idForm.text.isValidID()){
      isNotAcceptableData = true;
      emit(IDIsNotValid());
      return false;
    }

    if(passwordForm.text.isNotEmpty && emailForm.text.isValidEmail() && rePasswordForm.text == passwordForm.text && firstNameForm.text.isNotEmpty && secondNameForm.text.isNotEmpty && lastNameForm.text.isNotEmpty && idForm.text.isNotEmpty ){
      isNotAcceptableData = false;
      return true;
    }
    isNotAcceptableData = true;
    emit(RegistrationIsNotAcceptableData());
    return false;

  }

}
