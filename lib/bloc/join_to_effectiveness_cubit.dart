import 'package:flutter_bloc/flutter_bloc.dart';

part 'join_to_effectiveness_state.dart';

class JoinToEffectivenessCubit extends Cubit<JoinToEffectivenessState> {
  JoinToEffectivenessCubit() : super(JoinToEffectivenessInitial());
  static JoinToEffectivenessCubit get(context) => BlocProvider.of(context);

  void join(){
    emit(JoinToEffectivenessLoading());

    Future.delayed(const Duration(seconds: 1)).then((value){
      emit(JoinToEffectivenessSuccess());
    });


  }


}
