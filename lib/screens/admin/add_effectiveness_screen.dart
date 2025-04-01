import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/add_effectiveness_cubit.dart';
import 'package:hatan/widget/show_toast.dart';
import '../../widget/button_hatan.dart';
import '../../widget/textfield_hatan.dart';

class AddEffectivenessScreen extends StatelessWidget {
  const AddEffectivenessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor:  const Color(0xFFA0dbf1),
            shadowColor: Colors.transparent,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left , color: Colors.black,),),
            title:  const Text('اضافة فعالية' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

          ),
          backgroundColor:  const Color(0xFFA0dbf1),
          body: BlocProvider(
            create: (context) {
              AddEffectivenessCubit cubit = AddEffectivenessCubit();
              cubit.init();
              return cubit;

            },
            child: BlocConsumer<AddEffectivenessCubit, AddEffectivenessState>(
              listener: (context, state) {
                if(state is AddEffectivenessSuccess){
                  showToast(text: 'تمت إضافة الفعالية بنجاح', color: Colors.green);
                  Navigator.pop(context);
                }
                if(state is AddEffectivenessError){
                  showToast(text: 'حدث خطأ ما الرجاء التأكد من البيانات و إعادة المحاولة', color: Colors.redAccent);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                return SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(

                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 500,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          TextFieldHatan(title: 'اسم الفعالية' , controller: AddEffectivenessCubit.get(context).effectivenessNameForm , width: width, inputType: TextInputType.name,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(title: 'عدد ساعات الفعالية', controller: AddEffectivenessCubit.get(context).hoursNumberForm , width: width, inputType: TextInputType.number,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(
                            readOnly: true,
                            title: 'تاريخ الفعالية', controller: AddEffectivenessCubit.get(context).effectivenessDateForm ,onTapped: (){
                            AddEffectivenessCubit.get(context).onTappedDateForm(context);
                          }, width: width, inputType: TextInputType.datetime,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(
                            readOnly: true,
                            title: 'وقت الفعالية', controller: AddEffectivenessCubit.get(context).effectivenessTimeForm ,onTapped: (){
                            AddEffectivenessCubit.get(context).onTappedTimeForm(context);
                          }, width: width, inputType: TextInputType.datetime,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(title: 'المكان' , controller: AddEffectivenessCubit.get(context).placeForm , width: width, inputType: TextInputType.text,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(title: 'الأهداف' , controller: AddEffectivenessCubit.get(context).targetForm , width: width, height: 150, inputType: TextInputType.text,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),maxLines: 999,),
                          const SizedBox(height: 16,),

                          Container(
                            //height: 138,
                            padding: const EdgeInsets.only(bottom: 16),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                              child: ButtonHatan(
                                text: 'تنزيل',
                                height: 32,
                                width: 100,
                                color: (state is AddEffectivenessLoading )? Colors.grey.withOpacity(0.5):null,
                                onTapped: (){
                                  if(state is! AddEffectivenessLoading){
                                    AddEffectivenessCubit.get(context).addEffectiveness();
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
      ),
    );
  }
}

