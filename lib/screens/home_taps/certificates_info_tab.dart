
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/certificates_info_cubit.dart';
import '../../models/effectiveness.dart';
import '../../widget/button_hatan.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;


class CertificatesInfoTap extends StatelessWidget {
  final Effectiveness effectiveness;
  final TabController tabController;
  final String imagesURI = 'https://cloudeves.com/hatan/public/';

  const CertificatesInfoTap({Key? key,required this.effectiveness, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    return BlocProvider(
      create: (context) => CertificatesInfoCubit()..getCertificatesInfo(effectiveness.id),
      child: BlocConsumer<CertificatesInfoCubit, CertificatesInfoState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is CertificatesInfoLoading){
            return const Center(
              child:CircularProgressIndicator() ,
            );
          }

          if(state is CertificatesInfoError) {
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
                        CertificatesInfoCubit.get(context).getCertificatesInfo(effectiveness.id);
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

          return Padding(
            padding: const EdgeInsets.only(top: 16.0 ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    height: height/3,
                    child: Image.network(imagesURI+CertificatesInfoCubit.get(context).image,
                        loadingBuilder:
                            (context, child, loadingProgress) =>
                            (loadingProgress!=null)?Container(width: width, color: Colors.grey.withOpacity(0.5) ):child ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: ButtonHatan(
                      text: 'طباعة',
                      width: 100,
                      onTapped: ()async{
                        final url = Uri.parse(imagesURI+CertificatesInfoCubit.get(context).image);
                        final response = await http.get(url);
                        final appDir = await path_provider.getApplicationDocumentsDirectory();
                        await File('${appDir.path}/CertificatesImage.png').writeAsBytes(response.bodyBytes);
                        print('${appDir.path}/CertificatesImage.png');
                        await Share.shareFiles(['${appDir.path}/CertificatesImage.png'], text: 'شهادة التطوع');

                      },
                      height: 35,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
