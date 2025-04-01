import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/registration_cubit.dart';
import 'package:hatan/local/cache_helper.dart';
import 'package:hatan/screens/admin/admin_screen.dart';
import 'package:hatan/screens/home_screen.dart';
import 'package:hatan/widget/button_hatan.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => RegistrationCubit(),
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
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
                      minHeight: 666,
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
                        Container(
                          height: 160,
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('مبروك الانضمام لعائلة هتان' ,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 16 ,fontWeight: FontWeight.bold ,),),
                              const SizedBox(height: 20,),
                              const Text('رقمك التطوعي الخاص' ,textAlign: TextAlign.center, style: TextStyle(color: Colors.indigo,fontSize: 24,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 20,),
                              Text(CacheHelper.getData(key: 'id').toString() ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 40 ,fontWeight: FontWeight.bold ,),),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                          child: ButtonHatan(
                            text: 'البدء',
                            height: 32,
                            width: 100,
                            onTapped: (){
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
                            },
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
