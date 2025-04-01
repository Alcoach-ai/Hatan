import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/certificates_cubit.dart';
import 'package:hatan/screens/home_screen.dart';

import '../../widget/button_home.dart';

class CertificatesTap extends StatelessWidget {
  final TabController tabController;
  const CertificatesTap({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        CertificatesCubit cubit = CertificatesCubit();
        cubit.getCertificates();
        return cubit;
      },
      child: BlocConsumer<CertificatesCubit, CertificatesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is CertificatesLoading){
            return const Center(
              child:CircularProgressIndicator() ,
            );
          }

          if(state is CertificatesError) {
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
                        CertificatesCubit.get(context).getCertificates();
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

          if(state is CertificatesEmpty){
            return const Center(
              child: Text(
                'لا يوجد شهادات',
                style: TextStyle(
                    color:  Colors.black,fontSize: 18, fontFamily: 'Tajawal'
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children:CertificatesCubit.get(context).certificates.map<Widget>((e){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 8),
                    child: ButtonHome( title: e.certificateName! , onTapped:(){
                      selectedEffectiveness = e;
                      tabController.animateTo(6);
                    }),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
