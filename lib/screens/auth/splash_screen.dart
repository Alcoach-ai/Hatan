import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/screens/auth/start_screen.dart';
import 'package:hatan/widget/show_toast.dart';

import '../../bloc/splash_cubit.dart';
import '../../local/cache_helper.dart';
import '../admin/admin_screen.dart';
import '../home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context){
        SplashCubit cubit  = SplashCubit();
        Future.delayed(const Duration(seconds: 2)).then((value) => cubit.start());
        return cubit;
      },
      child: BlocConsumer<SplashCubit, SplashState>(listener: (context, state) {
        print(state);
        if(state is UserOld){
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
        }else{
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) {
                return const StartScreen();
              }), (route) => false);
        }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor:  const Color(0xFFA0dbf1),
              body: SizedBox(
                height: height,
                width: width,
                child: Center(
                  child: Container(
                    height: height,
                    constraints: const BoxConstraints(
                      minHeight: 550,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
