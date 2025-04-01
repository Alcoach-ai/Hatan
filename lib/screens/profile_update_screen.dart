

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/profile_cubit.dart';
import 'package:hatan/widget/button_hatan.dart';
import 'package:hatan/widget/show_toast.dart';
import 'package:hatan/widget/textfield_hatan.dart';

import '../models/user.dart';

class ProfileUpdateScreen extends StatelessWidget {
  final User user ;
  final ProfileCubit profileCubit;
  const ProfileUpdateScreen({Key? key, required this.user, required this.profileCubit}) : super(key: key);

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
          title:  const Text('تعديل الملف الشخصي' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

        ),
        backgroundColor:  const Color(0xFFA0dbf1),
        body:BlocProvider(
          create: (context) {
            ProfileCubit  cubit = ProfileCubit();
            cubit.init(user);
            return cubit;
          },
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if(state is UpdateProfileError){
                showToast(text: 'حدث خطأ ما الرجاء مراجعة البيانات', color: Colors.redAccent);
              }else if(state is EmailAlreadyExist){
                showToast(text: 'البريد الالكتروني مسجل سابقاً', color: Colors.redAccent);
              }else if(state is PasswordIsNotValid){
                showToast(text: 'كلمة السر قصيرة', color: Colors.redAccent);
              }else if(state is PhoneIsNotValid){
                showToast(text: 'الرقم غير صالح يجب ان يبدأ ب 966 وان يكون مكون من 12 خانة', color: Colors.redAccent);
              }else if(state is EmailIsNotValid){
                showToast(text: 'البريد الالكتروني غير صالح', color: Colors.redAccent);
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
                      TextFieldHatan(title: 'رقم الجوال', controller: ProfileCubit.get(context).phoneForm ,width: width, inputType: TextInputType.number,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                      TextFieldHatan(title: 'البريد الالكتروني', controller: ProfileCubit.get(context).emailForm ,width: width, inputType: TextInputType.emailAddress,padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 4),),
                      const SizedBox(height: 16,),
                      Visibility(
                        visible: ProfileCubit.get(context).isNotAcceptableData,
                        child: const Directionality(
                            textDirection: TextDirection.rtl,
                            child:  Text('تأكد من صحة المعلومات المسجلة!' ,style: TextStyle(color: Colors.redAccent , fontWeight: FontWeight.bold),)
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        alignment: Alignment.center,
                        child: ButtonHatan(
                            text: 'تحديث',
                            height: 45,
                            width: 100,
                            color: ProfileCubit.get(context).isLoading?Colors.grey.withOpacity(0.5): null,
                            onTapped: (){
                              if(ProfileCubit.get(context).validator() && !ProfileCubit.get(context).isLoading){
                                ProfileCubit.get(context).profileUpdate(user, context , profileCubit);
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
