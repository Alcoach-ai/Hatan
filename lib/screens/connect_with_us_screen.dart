
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/connect_with_us_cubit.dart';
import 'package:hatan/bloc/profile_cubit.dart';
import 'package:hatan/widget/show_toast.dart';


import '../models/user.dart';
import '../widget/button_hatan.dart';
import '../widget/filed_view.dart';
import '../widget/show_dialog.dart';

class ConnectWithUsScreen extends StatelessWidget {
  const ConnectWithUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
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
            title:  const Text('تواصل مع الإدارة' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

          ),
          backgroundColor:  const Color(0xFFA0dbf1),
          body: BlocProvider(
            create: (context) => ConnectWithUsCubit(),
            child: BlocConsumer<ConnectWithUsCubit, ConnectWithUsState>(
              listener: (context, state) {
                if(state is ConnectWithUsDown){
                  showToast(text: 'تم إرسال الرسالة بنجاح', color: Colors.green);
                }else if (state is ConnectWithUsError){
                  showToast(text: 'حدث خطأ ما الرجاء إعادة المحاولة', color: Colors.redAccent);

                }
                // TODO: implement listener
              },
              builder: (context, state) {

                return SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    child: Container(

                      margin:const EdgeInsets.symmetric(horizontal: 32,vertical: 32),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('كيف نقدر نساعدك؟' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.black,fontSize: 24 ,fontWeight: FontWeight.bold ,),),
                          Container(
                            height: 300,
                            width: double.infinity,
                            padding:const EdgeInsets.all(16),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: ConnectWithUsCubit.get(context).messageForm,
                                      cursorColor: Colors.black,
                                      textAlign: TextAlign.right,
                                      maxLines: 99,
                                      style: const TextStyle(fontSize: 18),
                                      decoration: const InputDecoration(
                                        hintText: 'أدخل النص هنا',
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                        //hintText: "Hint here"
                                      ),
                                    ),
                                  ),
                                ),
                                ButtonHatan(
                                  text: 'ارسال',
                                  width: 100,
                                  color:(ConnectWithUsCubit.get(context).isLoading)?Colors.grey.withOpacity(0.5): null ,
                                  onTapped: (){
                                    if(!ConnectWithUsCubit.get(context).isLoading ){
                                      ConnectWithUsCubit.get(context).sendData();
                                    }
                                  },
                                  height: 35,
                                ),
                              ],
                            ),

                          ),
                        ],
                      ),
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
