import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/dio_helper.dart';
part 'add_effectiveness_state.dart';

class AddEffectivenessCubit extends Cubit<AddEffectivenessState> {
  AddEffectivenessCubit() : super(AddEffectivenessInitial());

  static AddEffectivenessCubit get(context) => BlocProvider.of(context);
  DateTime date = DateTime.now();
  TimeOfDay time  = TimeOfDay.now();
 bool isLoading = false;


  TextEditingController effectivenessNameForm = TextEditingController();
  TextEditingController hoursNumberForm = TextEditingController();
  TextEditingController effectivenessDateForm = TextEditingController();
  TextEditingController effectivenessTimeForm = TextEditingController();
  TextEditingController placeForm = TextEditingController();
  TextEditingController targetForm = TextEditingController();

  void init(){
    effectivenessDateForm.text = '${date.day}-${date.month}-${date.year}';
    effectivenessTimeForm.text = '${time.hour}:${time.minute}';
  }

  void onTappedDateForm(BuildContext context)async{
    await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(3000)).then((value) {
      if(value != null){
        date = value;
        effectivenessDateForm.text = '${date.day}-${date.month}-${date.year}';
        emit(AddEffectivenessUpdate());
      }
    });
  }

  void onTappedTimeForm(BuildContext context)async{
    await showTimePicker( context: context, initialTime: TimeOfDay.now()).then((value) {
      if(value != null){
        time = value;
        effectivenessTimeForm.text = '${time.hour}:${time.minute}';
        emit(AddEffectivenessUpdate());
      }
    });
  }

  void update(){
    emit(AddEffectivenessUpdate());
  }

  void addEffectiveness(){
    isLoading = true;
    emit(AddEffectivenessLoading());

    DioHelper.postData(url: 'addEvent', data:{
      'hours': hoursNumberForm.text,
      'date' : effectivenessDateForm.text.toString(),
      'time' : effectivenessTimeForm.text.toString(),
      'place' : placeForm.text.trim(),
      'goals' : targetForm.text,
      'name' : effectivenessNameForm.text.trim(),
    }).then((value) {
      isLoading = false;
      if(value == null){
        emit((AddEffectivenessError()));
        return ;
      }
      if (kDebugMode) {
        print( 'state code for Add Effectiveness is ${value.statusCode}');
        print(value.data);
      }

      if(value.data.toString().contains('error')){
        emit((AddEffectivenessError()));
        return ;
      }

      emit(AddEffectivenessSuccess());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AddEffectivenessError());
    });


  }


}
