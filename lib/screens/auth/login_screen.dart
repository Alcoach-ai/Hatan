import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/login_cubit.dart';
import '../../local/cache_helper.dart';
import '../../widget/button_hatan.dart';
import '../../widget/show_toast.dart';
import '../../widget/textfield_hatan.dart';
import '../admin/admin_screen.dart';
import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor:  const Color(0xFFA0dbf1),
        body:BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if(state is LoginSuccess){
                if(CacheHelper.getData(key: 'type') != 1) {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) {
                        return const HomeScreen();
                      }), (route) => false);
                }else {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) {
                        return const AdminScreen();
                      }), (route) => false);
                }
              }

              if(state is LoginUserIsNull){
                showToast(text: 'عذراً كلمة السر او البريد الالكتروني خطأ!', color: Colors.redAccent);
              }


              // TODO: implement listener
            },
            builder: (context, state) {
              return SizedBox(
                height: height,
                width: width,
                child: SingleChildScrollView(

                  child: Container(
                    height: height,
                    constraints: const BoxConstraints(
                      minHeight: 722,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        const SizedBox(height: 32,),
                        Container(
                          height: 300,
                          width: width,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Image.asset('assets/images/hatan_logo.png'),
                        ),

                        TextFieldHatan(
                          title: 'البريد الالكتروني',
                          controller: LoginCubit.get(context).emailForm,
                          width: width,
                          inputType: TextInputType.emailAddress,
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          maxLines: 1,
                        ),
                        TextFieldHatan(
                            title: 'كلمة المرور',
                            controller: LoginCubit.get(context).passwordForm,
                            width: width,
                            inputType: TextInputType.visiblePassword,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 4),
                            maxLines: 1,
                            passwordVisible: LoginCubit.get(context).passwordVisible,
                            onPassHide: ()=>LoginCubit.get(context).hidePass(),
                        ),

                        Visibility(
                          visible:LoginCubit.get(context).isNotAcceptableData ,
                          child: const Directionality(
                              textDirection: TextDirection.rtl,
                              child:  Text('تأكد من صحة المعلومات المسجلة!' ,style: TextStyle(color: Colors.redAccent , fontWeight: FontWeight.bold),)
                          ),
                        ),
                        //const Text('هل نسيت كلمة المرور؟' ,maxLines: 2,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 14 ,fontWeight: FontWeight.normal ,),),

                        Container(
                          height: 90,
                          padding: const EdgeInsets.only(bottom: 16),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                                child: ButtonHatan(text: 'دخول', height: 45,
                                  width: 125,
                                  color: LoginCubit.get(context).isLoading?Colors.grey.withOpacity(0.5):null,
                                  onTapped: (){
                                    if(LoginCubit.get(context).validator() && !LoginCubit.get(context).isLoading){
                                      LoginCubit.get(context).login(email: LoginCubit.get(context).emailForm.text , password: LoginCubit.get(context).passwordForm.text);
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                                child: ButtonHatan(text: 'الرجوع', height: 45,
                                  width: 125,
                                  onTapped: (){
                                    Navigator.pop(context);
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
              );
            },
          ),
        )
    );
  }
}
