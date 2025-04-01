import 'package:flutter/material.dart';
import 'package:hatan/local/cache_helper.dart';
import 'package:hatan/screens/auth/start_screen.dart';
import 'package:hatan/widget/button_hatan.dart';
class SorryScreen extends StatelessWidget {
  const SorryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                    height: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:const [
                        Text('يعتذر منك فريق هتان لا يوجد حاليا مكان شاغر بالقسم' ,textAlign: TextAlign.center, maxLines: 2,style: TextStyle(color: Colors.indigo,fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        Text('سيتم التواصل معك عبر البريد الالكتروني عند إتاحة مكان' ,maxLines: 2,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 18 ,fontWeight: FontWeight.bold ,),),
                      ],
                    ),
                  ),

                  Container(
                    height: 138,
                    padding: const EdgeInsets.only(bottom: 16),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16  ,vertical: 8),
                      child: ButtonHatan(text: 'حسناً', height: 32, width: 100,
                        onTapped: (){
                          CacheHelper.clearData();
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (_) {
                                return const StartScreen();
                              }), (route) => false);                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
