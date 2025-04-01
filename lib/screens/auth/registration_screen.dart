import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/screens/auth/sorry_screen.dart';
import 'package:hatan/screens/auth/which_section_screen.dart';

import '../../bloc/registration_cubit.dart';
import '../../widget/button_hatan.dart';
import '../../widget/show_toast.dart';
import '../../widget/textfield_hatan.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) {
        RegistrationCubit cubit = RegistrationCubit();
        DateTime date =  cubit.date;
        cubit.birthDateForm.text = '${date.day}/${date.month}/${date.year}';
        return cubit;

      },
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          if(state is RegistrationSuccess){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> WhichSectionScreen(cubit: RegistrationCubit.get(context),)));
          }else if(state is RegistrationError){
            showToast(text: 'حدث خطأ ما الرجاء مراجعة البيانات', color: Colors.redAccent);
          }else if(state is EmailAlreadyExist){
            showToast(text: 'البريد الالكتروني مسجل سابقاً', color: Colors.redAccent);
          }else if(state is PasswordIsNotValid){
            showToast(text: 'كلمة السر قصيرة', color: Colors.redAccent);
          }else if(state is PhoneIsNotValid){
            showToast(text: 'الرقم غير صالح يجب ان يبدأ ب 966 وان يكون مكون من 12 خانة', color: Colors.redAccent);
          }else if(state is AgeIsNotValid){
            showToast(text: 'عذراً لم تحقق شرط العمر', color: Colors.redAccent);
          }else if(state is IDIsNotValid){
            showToast(text: 'رقم الهوية يجب ان يتكون من عشرة ارقام', color: Colors.redAccent);
          }else if(state is SorryIDoNotHavePlaceEmpty){
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
                  return const SorryScreen();
                }), (route) => false);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
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
                  title:  const Text('حساب جديد' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

                ),
                backgroundColor:  const Color(0xFFA0dbf1),
                body: SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(

                    child: Container(
                      height: height,
                      constraints: const BoxConstraints(
                        minHeight: 845,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          TextFieldHatan(title: 'الاسم الاول' , controller: RegistrationCubit.get(context).firstNameForm , width: width, inputType: TextInputType.name,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(title: 'الاسم الثاني', controller: RegistrationCubit.get(context).secondNameForm , width: width, inputType: TextInputType.name,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(title: 'اسم العائلة', controller: RegistrationCubit.get(context).lastNameForm , width: width, inputType: TextInputType.name,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(title: 'رقم الهوية', controller: RegistrationCubit.get(context).idForm , width: width, inputType: TextInputType.number,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(title: 'رقم الجوال', controller: RegistrationCubit.get(context).phoneForm ,width: width, inputType: TextInputType.number,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(
                            readOnly: true,
                            title: 'تاريخ الميلاد', controller: RegistrationCubit.get(context).birthDateForm ,
                            onTapped: (){
                            RegistrationCubit.get(context).onTappedBirthDate(context);
                          }, width: width, inputType: TextInputType.datetime,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(title: 'البريد الالكتروني', controller: RegistrationCubit.get(context).emailForm ,width: width, inputType: TextInputType.emailAddress,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                          TextFieldHatan(
                            title: 'كلمة المرور',
                            controller:
                                RegistrationCubit.get(context).passwordForm,
                            width: width,
                            inputType: TextInputType.visiblePassword,
                            maxLines: 1,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            passwordVisible: RegistrationCubit.get(context).passwordVisible,
                            onPassHide: ()=>RegistrationCubit.get(context).hidePass(),
                          ),
                          TextFieldHatan(
                            title: 'تأكيد كلمة المرور',
                            controller:
                                RegistrationCubit.get(context).rePasswordForm,
                            width: width,
                            inputType: TextInputType.visiblePassword,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            maxLines: 1,
                            passwordVisible: RegistrationCubit.get(context).passwordVisible,
                            onPassHide: ()=>RegistrationCubit.get(context).hidePass(),
                          ),
                          const SizedBox(height: 16,),
                          Visibility(
                            visible: RegistrationCubit.get(context).isNotAcceptableData,
                            child: const Directionality(
                              textDirection: TextDirection.rtl,
                                child:  Text('تأكد من صحة المعلومات المسجلة!' ,style: TextStyle(color: Colors.redAccent , fontWeight: FontWeight.bold),)
                            ),
                          ),

                          Container(
                            //height: 138,
                            padding: const EdgeInsets.only(bottom: 16),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                                  child: ButtonHatan(
                                    text: 'الرجوع',
                                    height: 32,
                                    width: 100,
                                    onTapped: (){
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                                  child: ButtonHatan(
                                    text: 'التالي',
                                    height: 32,
                                    width: 100,
                                    color: RegistrationCubit.get(context).isLoading?Colors.grey.withOpacity(0.5): null,
                                    onTapped: (){
                                      if(RegistrationCubit.get(context).validator()&& !RegistrationCubit.get(context).isLoading){
                                        RegistrationCubit.get(context).registration();
                                      }

                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}

