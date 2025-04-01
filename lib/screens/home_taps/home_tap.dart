import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/home_tab_cubit.dart';


class HomeTapScreen extends StatelessWidget {

  const HomeTapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        HomeTabCubit cubit = HomeTabCubit();
        cubit.getData();

        return cubit;
      },
      child: BlocConsumer<HomeTabCubit, HomeTabState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {

          if(state is HomeTabLoading){
            return const Center(
              child:CircularProgressIndicator() ,
            );
          }

          if(state is HomeTabError) {
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
                        HomeTabCubit.get(context).getData();
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



          return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0 , horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('مرحبا' ,maxLines: 1,textAlign: TextAlign.center,  style:  TextStyle(color: Colors.white,fontSize: 24 ,fontWeight: FontWeight.bold ,),),
                        Text(HomeTabCubit.get(context).data!.name.toString() ,maxLines: 1,textAlign: TextAlign.center,  style: const TextStyle(color: Colors.white,fontSize: 24 ,fontWeight: FontWeight.bold ,),),
                        Text('رقم المتطوع ${HomeTabCubit.get(context).data!.id}' ,maxLines: 1,textAlign: TextAlign.center,  style: const TextStyle(color: Colors.indigo,fontSize: 30 ,fontWeight: FontWeight.bold ,),),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin:const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                        height: 140,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding:const EdgeInsets.all(16),
                                margin:const EdgeInsets.only(left: 8 ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const[
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2,
                                      offset: Offset(0, 0), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const Text('عدد الساعات التطوعية' ,maxLines: 2,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigoAccent,fontSize: 18 ,fontWeight: FontWeight.normal ,),),
                                    Text(HomeTabCubit.get(context).data!.hours.toString() ,maxLines: 1,textAlign: TextAlign.center,  style: const TextStyle(color: Colors.indigo,fontSize: 34 ,fontWeight: FontWeight.bold ,),),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding:const EdgeInsets.all(16),
                                margin:const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow:const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2,
                                      offset: Offset(0, 0), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const Text('عدد الفعاليات التطوعية' ,maxLines: 2,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigoAccent,fontSize: 18 ,fontWeight: FontWeight.normal ,),),
                                    Text(HomeTabCubit.get(context).data!.eventsCount.toString() ,maxLines: 1,textAlign: TextAlign.center,  style: const TextStyle(color: Colors.indigo,fontSize: 34 ,fontWeight: FontWeight.bold ,),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                        height: 140,
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding:const EdgeInsets.all(16),
                                  margin:const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow:const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2,
                                        offset: Offset(0, 0), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                          width: double.infinity,
                                          child: Text('الفريق التطوعي' ,maxLines: 2,textAlign: TextAlign.right,  style: TextStyle(color: Colors.indigoAccent,fontSize: 18 ,fontWeight: FontWeight.normal ,),)),
                                      Text(HomeTabCubit.get(context).data!.teamName??HomeTabCubit.get(context).data!.sectionName!,maxLines: 1,textAlign: TextAlign.center,  style: const TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
          );
        },
      ),
    );
  }
}
