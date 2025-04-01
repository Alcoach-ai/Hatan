import 'package:bloc/bloc.dart';
import 'package:hatan/local/cache_helper.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());


  void start(){
    try{
    String? value = CacheHelper.getData(key: 'email');

    if(value != null){
      emit(UserOld());
    }else{
      emit(UserNew());
    }

    }catch(e){
      print(e);
    }

  }


}
