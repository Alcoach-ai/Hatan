
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../local/cache_helper.dart';
import '../models/dio_helper.dart';

part 'certificates_info_state.dart';

class CertificatesInfoCubit extends Cubit<CertificatesInfoState> {
  CertificatesInfoCubit() : super(CertificatesInfoInitial());
  static CertificatesInfoCubit get(context) => BlocProvider.of(context);
  String image = '';

  void getCertificatesInfo(int eventId){
    emit(CertificatesInfoLoading());
    DioHelper.postData(url: 'getCertifcate', data:{
      'id': CacheHelper.getData(key: 'id'),
      'eventId': eventId,
    }).then((value) {
      if(value == null){
        emit(CertificatesInfoError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for CertificatesInfo data is ${value.statusCode}');
        print(value.data);
      }
      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in get CertificatesInfo tab data!!!!!');
        }
        emit(CertificatesInfoError());
        return ;
      }
      image = value.data;

      emit(CertificatesInfoDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(CertificatesInfoError());
    });

  }


}
