

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/registration_cubit.dart';
import 'package:hatan/widget/button_hatan.dart';
import 'package:hatan/widget/show_toast.dart';
import 'package:hatan/widget/textfield_hatan.dart';


class AddSectionScreen extends StatelessWidget {
  final RegistrationCubit registrationCubit;
  const AddSectionScreen({Key? key, required this.registrationCubit}) : super(key: key);

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
          title:  const Text('إضافة قسم' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

        ),
        backgroundColor:  const Color(0xFFA0dbf1),
        body:BlocProvider(
          create: (context) {
            RegistrationCubit  cubit = RegistrationCubit();

            return cubit;
          },
          child: BlocConsumer<RegistrationCubit, RegistrationState>(
            listener: (context, state) {
              if(state is AddTeamDown){
                registrationCubit.getAllSections();
                Navigator.pop(context);
              }
              if(state is AddTeamError){
                showToast(text: 'حدث خطأ ما الرجاء المحاولة لاحقا', color: Colors.redAccent);
              }
            },
            builder: (context, state) {


              return SizedBox(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      TextFieldHatan(title: 'اسم القسم', controller: RegistrationCubit.get(context).sectionNameForm ,width: width, inputType: TextInputType.name,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                      const SizedBox(height: 16,),

                      Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        alignment: Alignment.center,
                        child: ButtonHatan(
                            text: 'إضافة',
                            height: 45,
                            width: 100,
                            color: RegistrationCubit.get(context).isLoading?Colors.grey.withOpacity(0.5): null,
                            onTapped: (){
                              if(!RegistrationCubit.get(context).isLoading){
                                RegistrationCubit.get(context).addSection();
                              }
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ) ,
      ),
    );
  }
}
