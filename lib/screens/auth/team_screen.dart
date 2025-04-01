
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/team_cubit.dart';
import 'package:hatan/screens/volunteer_info_screen.dart';

class TeamScreen extends StatelessWidget {
  final String title;
  final int? teamId;
  final int? sectionId;
  final int? eventId;
  const TeamScreen({Key? key, required this.title, this.teamId, this.sectionId, this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return  Directionality(
      textDirection: TextDirection.rtl,
      child:Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor:  const Color(0xFFA0dbf1),
            shadowColor: Colors.transparent,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left , color: Colors.black,),),
            title: Text(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.indigo,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor:  const Color(0xFFA0dbf1),
          body: BlocProvider(
            create: (context) {
              TeamCubit cubit =TeamCubit();
              cubit.getData(teamId: teamId , sectionId: sectionId,eventId: eventId);
              return cubit;
            },
            child: BlocConsumer<TeamCubit, TeamState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {

                if(state is TeamLoading){
                  return const Center(
                    child:CircularProgressIndicator(),
                  );
                }

                if(state is TeamError) {
                  return Center(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'عذراً حدث خطأ ما',
                            style: TextStyle(
                                color:  Colors.black,fontSize: 18, fontFamily: 'Tajawal'
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              TeamCubit.get(context).getData(teamId: teamId , sectionId: sectionId , eventId: eventId);
                            },
                            child: const Text(
                              'إعادة محاولة',
                              style: TextStyle(
                                  color:  Colors.indigo,fontSize: 18, fontFamily: 'Tajawal', fontWeight: FontWeight.bold
                              ),
                            ),
                          ),

                        ],
                      )
                  );
                }

                if(TeamCubit.get(context).team.isEmpty){
                  return const Center(
                    child: Text(
                      'عذراً القائمة فراغة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:  Colors.black,fontSize: 18, fontFamily: 'Tajawal'
                      ),
                    ),
                  );
                }

                return Container(
                  constraints: const BoxConstraints(
                    minHeight: 550,
                  ),
                  height: height,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ListView(
                      children: TeamCubit.get(context).team.map((e) => Column(
                        children: [
                          ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>VolunteerScreen(volunteer: e,))).then((value) {
                                TeamCubit.get(context).getData(teamId: teamId , sectionId: sectionId,eventId: eventId);
                              });
                            },
                            leading: Text(
                              (TeamCubit.get(context).team.indexOf(e)+1).toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            trailing: IconButton(icon: const Icon(Icons.chevron_right),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>VolunteerScreen(volunteer: e,))).then((value) {
                                  TeamCubit.get(context).getData(teamId: teamId , sectionId: sectionId,eventId: eventId);
                                });
                              },
                            ),

                            title: Container(
                              alignment: Alignment.center,
                              child: Text(
                                e.fullName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Divider(color: Colors.grey, ),
                        ],
                      )).toList(),
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
