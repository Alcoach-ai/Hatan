import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/login_cubit.dart';
import 'package:hatan/screens/admin/admin_all_events_screen.dart';
import 'package:hatan/screens/admin/admin_all_team_screen.dart';
import 'package:hatan/screens/admin/reports_screen.dart';
import 'package:hatan/screens/auth/start_screen.dart';

import '../../local/cache_helper.dart';
import '../../widget/button_hatan.dart';
import 'add_effectiveness_screen.dart';
import 'admin_all_parts_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

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
              appBar: AppBar(
                centerTitle: true,
                backgroundColor:  const Color(0xFFA0dbf1),
                shadowColor: Colors.transparent,
                leading: IconButton(
                  onPressed: (){
                    CacheHelper.clearData();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_){
                          return const StartScreen();
                        },
                        ), (route) => false);
                    },
                  icon: const Icon(Icons.exit_to_app , color: Colors.black,),),
              ),
              body: SizedBox(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Container(
                        height: height/2,
                        width: width,
                        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        child: Image.asset('assets/images/hatan_logo.png'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ButtonHatan(
                            text: 'الفرق',
                            height: 50,
                            width: 125,
                            onTapped: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const AdminAllTeam()));
                            },
                          ),
                          ButtonHatan(
                            text: 'الاقسام',
                            height: 50,
                            width: 125,
                            onTapped: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const AdminAllParts()));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ButtonHatan(
                            text: 'اضافة فعالية',
                            height: 50,
                            width: 125,
                            onTapped: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                      const AddEffectivenessScreen()));
                            },
                          ),
                          ButtonHatan(
                            text: 'الفعاليات',
                            height: 50,
                            width: 125,
                            onTapped: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                      const AdminAllEventsScreen()));
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      ButtonHatan(
                        text: 'التقارير',
                        height: 50,
                        width: 125,
                        onTapped: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                  const ReportScreen()));
                        },
                      ),
                      const SizedBox(height: 16,),
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}

