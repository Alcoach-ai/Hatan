import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/models/user.dart';

import '../local/cache_helper.dart';
import '../models/dio_helper.dart';
import '../models/volunteer.dart';
import '../widget/confirmation_dialog.dart';

part 'team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  TeamCubit() : super(TeamInitial());
  static TeamCubit get(context) => BlocProvider.of(context);
  List<User> team = [];
  bool isLoading = false;
  void getData({int? teamId, int? sectionId , int? eventId}){
    emit(TeamLoading());
    DioHelper.postData(url:(teamId != null)? 'getTeamMembers' :(eventId!= null)?'eventUsers' : 'getSectionMembers', data:{
      ((teamId != null)?'teamId':((eventId!= null)?'eventId' :'sectionId')): teamId??(sectionId??eventId),
    }).then((value) {
      if(value == null){
        emit(TeamError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for getTeamMembers data is ${value.statusCode}');
        print(value.data);
      }
      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in get TeamMembers data!!!!!');
        }
        emit(TeamError());
        return ;
      }
      team = List<User>.from(value.data.map((e)=>User.fromJson(e)));

      if(team.isEmpty){
        emit(TeamEmpty());
        return;
      }
      print('down!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');

      emit(TeamDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(TeamError());
    });

  }

  void removeVolunteer(BuildContext context ,User volunteer ){
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return ConfirmationDialog(
          noOnPressed: () {
            Navigator.pop(context1);
          },
          yesOnPressed: (){
            Navigator.pop(context1);
            Navigator.pop(context);
          },
          title: 'هل تود حذف المتطوع؟',
          volunteer: volunteer,
        );
      },
    );
  }
}

