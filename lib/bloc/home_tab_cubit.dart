import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../local/cache_helper.dart';
import '../models/dio_helper.dart';
import '../models/home_data.dart';

part 'home_tab_state.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  HomeTabCubit() : super(HomeTabInitial());
  static HomeTabCubit get(context) => BlocProvider.of(context);
  HomeData? data;

  void getData (){
    emit(HomeTabLoading());
      DioHelper.postData(url: 'home', data:{
        'id': CacheHelper.getData(key: 'id'),
      }).then((value) {
        if(value == null){
          emit(HomeTabError());
          return ;
        }

        if (kDebugMode) {
          print( 'state code for home data is ${value.statusCode}');
          print(value.data);
        }
        if( value.data['error'] != null){
          if (kDebugMode) {
            print('Error in get home tab data!!!!!');
          }
          emit(HomeTabError());
          return ;
        }
        data = HomeData.fromJson(value.data);

        emit(HomeTabDown());
      }).catchError((error){
        if (kDebugMode) {
          print(error.toString());
        }
        emit(HomeTabError());
      });

  }




}
