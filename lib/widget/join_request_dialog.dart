import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/join_to_effectiveness_cubit.dart';
import 'package:flutter/material.dart';
import 'package:hatan/models/effectiveness.dart';
import 'package:hatan/widget/show_toast.dart';

import 'button_hatan.dart';


class JoinRequestDialog extends StatefulWidget {
  final BuildContext contextScreen;
  final Effectiveness effectiveness;
  final TabController tabController;
  final String? text;
  const JoinRequestDialog({Key? key, required this.contextScreen, required this.effectiveness, required this.tabController, this.text}) : super(key: key);

  @override
  State<JoinRequestDialog> createState() => _JoinRequestDialogState();
}

class _JoinRequestDialogState extends State<JoinRequestDialog> {

  late TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) {
          var cubit = JoinToEffectivenessCubit();

          return cubit;
        },
        child: BlocConsumer<JoinToEffectivenessCubit, JoinToEffectivenessState>(
          listener: (context, state) {
            if(state is JoinToEffectivenessError ){
              showToast(text: "حصل خطأ الرجاء المحالولة لاحقا", color: Colors.redAccent);
            }

            if(state is JoinToEffectivenessSuccess){
              //BlocProvider.of<MyCardsCubit>(widget.context).getMyCards();
              Navigator.of(context).pop();
              showToast(text: "تم تقديم الطلب بنجاح", color: Colors.green);
            }
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 32),

              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              height: height / 1.7,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 75, child: Image.asset('assets/icons/like.png',)),
                  Text(widget.text??'تم تأكيد انضمامك بفعالية ${widget.effectiveness.name}' ,maxLines: 2,textAlign: TextAlign.center,  style:const TextStyle(color: Colors.blue,fontSize: 16 ,fontWeight: FontWeight.bold ,),),
                  ButtonHatan(height: 35,width: 180, onTapped:(){
                    widget.tabController.animateTo(2);
                    Navigator.of(context).pop();
                  }, text: 'العودة إلى الصفحة الرئيسية',),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}
