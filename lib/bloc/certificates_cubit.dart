import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../local/cache_helper.dart';
import '../models/dio_helper.dart';
import '../models/effectiveness.dart';
part 'certificates_state.dart';


class CertificatesCubit extends Cubit<CertificatesState> {
  CertificatesCubit() : super(CertificatesInitial());
  static CertificatesCubit get(context) => BlocProvider.of(context);

  List<Effectiveness> certificates = [];

  void getCertificates (){
    emit(CertificatesLoading());
    DioHelper.postData(url: 'getEventsCertificate', data:{
      'id': CacheHelper.getData(key: 'id'),
    }).then((value) {
      if(value == null){
        emit(CertificatesError());
        return ;
      }

      if (kDebugMode) {
        print( 'state code for home data is ${value.statusCode}');
        print(value.data);
      }
      if( value.data.toString().contains('error')){
        if (kDebugMode) {
          print('Error in get certificates data!!!!!');
        }
        emit(CertificatesError());
        return ;
      }
      certificates = List<Effectiveness>.from(value.data.map((e)=>Effectiveness.fromJson(e)));

      if(certificates.isEmpty){
        emit(CertificatesEmpty());
        return;
      }

      emit(CertificatesDown());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(CertificatesError());
    });

  }


}
