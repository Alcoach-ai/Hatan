import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/models/dio_helper.dart';
import 'package:hatan/models/section.dart';
import 'package:hatan/models/team.dart';

part 'chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  static ChartCubit get(context)=>BlocProvider.of(context);
  ChartCubit() : super(ChartInitial());

  bool isLoading = false;
  String reportOf = 'الفعاليات';
  int year = 1444;
  int? selectedSectionId ;
  int? selectedTeamId ;

  List<double> data = List.generate(12, (index) => 0);

  List<Section> sections = [];
  List<Team> teams = [];

  List<String> month = [
    "محرم",
    "صفر",
    "ربيع الاول",
    "ربيع الثاني",
    "جمادى الاول",
    "جمادى الثاني",
    "رجب",
    "شعبان",
    "رمضان",
    "شوال",
    "ذو القعدة",
    "ذو الحجة",
  ];

  void update(){
    emit(ChartUpdate());
  }
  void getAllSections(){
    isLoading = true;

    DioHelper.postData(url: 'getSections', data:{}).then((value) {
      isLoading = false;
      if(value == null){
        emit(ChartError());
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
        emit(ChartError());
        return ;
      }

      sections = value.data.map<Section>((e)=>Section.fromJson(e)).toList();

      getAllTeam();
    }).catchError((error){
      if(kDebugMode) {
        print(error.toString());
      }
      emit(GetAllSectionsError());
    });

  }
  void getAllTeam(){
    isLoading = true;

    DioHelper.postData(url: 'getTeams', data:{}).then((value) {
      isLoading = false;
      if(value == null){
        emit(ChartError());
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
        emit(ChartError());
        return ;
      }

      teams = value.data.map<Team>((e)=>Team.fromJson(e)).toList();

      emit(ChartDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ChartError());
    });

  }

  void getEventsChart(){
    isLoading = true;
    emit(ChartLoading());

    DioHelper.postData(url: 'eventsChart', data:{
      'year':year
    }).then((value) {
      isLoading = false;
      if(value == null){
        emit(ChartError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for get chart is ${value.statusCode}');
        print(value.data);
      }



      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in get chart!!!!!');
        }
        emit(ChartError());
        return ;
      }

      data = month.map<double>((e) => value.data[e].toDouble()).toList();
      if (kDebugMode) {
        print( 'get chart down');
      }

      getAllSections();
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ChartError());
    });

  }

  void getSectionChart(){
    isLoading = true;
    emit(ChartLoading());

    DioHelper.postData(url: 'sectionChart', data:{
      'sectionId':selectedSectionId,
      'year':year
    }).then((value) {
      isLoading = false;
      if(value == null){
        emit(ChartError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for get chart is ${value.statusCode}');
        print(value.data);
      }

      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in get chart!!!!!');
        }
        emit(ChartError());
        return ;
      }

      data = month.map<double>((e) => value.data[e].toDouble()).toList();
      if (kDebugMode) {
        print( 'get chart down');
      }

      emit(ChartDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ChartError());
    });

  }
  void getTeamChart(){
    isLoading = true;
    emit(ChartLoading());

    DioHelper.postData(url: 'teamChart', data:{
      'teamId':selectedTeamId,
      'year':year
    }).then((value) {
      isLoading = false;
      if(value == null){
        emit(ChartError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for get chart is ${value.statusCode}');
        print(value.data);
      }



      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in get chart!!!!!');
        }
        emit(ChartError());
        return ;
      }

      data = month.map<double>((e) => value.data[e].toDouble()).toList();
      if (kDebugMode) {
        print( 'get chart down');
      }

      getAllSections();
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ChartError());
    });

  }

}
