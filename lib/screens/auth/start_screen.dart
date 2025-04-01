import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/login_cubit.dart';
import 'package:hatan/screens/auth/login_screen.dart';
import 'package:hatan/screens/auth/registration_screen.dart';
import 'package:hatan/widget/button_hatan.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   double height = MediaQuery.of(context).size.height;
   double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {

          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor:  const Color(0xFFA0dbf1),
              body: SizedBox(
                height: height,
                width: width,
                child: SingleChildScrollView(

                  child: Container(
                    height: height,
                    constraints: const BoxConstraints(
                      minHeight: 550,
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
                        SizedBox(
                          height: 70,
                          child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 32),
                                  alignment: Alignment.centerRight,
                                  child: const Text('شغف وحب التطوع وألهامنا لنكون' , maxLines: 1,style: TextStyle(color: Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold),)
                              ),
                              const SizedBox(height: 20,),
                              Container(
                                width: width,
                                  margin: const EdgeInsets.symmetric(horizontal: 32),
                                  alignment: Alignment.centerLeft,
                                  child: const Text('سحابة تُمطر هتاناً ' , style: TextStyle(color: Colors.indigo,fontSize: 14 ,fontWeight: FontWeight.bold ,),)
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 138,
                          padding: const EdgeInsets.only(bottom: 16),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                                child: ButtonHatan(text: 'تسجيل دخول', height: 45, width: width,
                                  onTapped: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                                child: ButtonHatan(text: 'تسجيل جديد', height: 45, width: width,
                                  onTapped: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const RegistrationScreen()));
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
          );
        },
      ),
    );
  }
}

