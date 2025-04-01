
import 'package:flutter/material.dart';
import 'package:hatan/models/validators.dart';

class TextFieldHatan extends StatelessWidget {
  final String title;
  final double width;
  final double? height;
  final TextInputType inputType;
  final EdgeInsetsGeometry? padding;
  final TextEditingController controller;
  final Function? onTapped;
  final int? maxLines;
  final Function? validator;
  final AutovalidateMode? autoValidateMode;
  final bool? readOnly;
  final bool? passwordVisible;
  final Function? onPassHide;

  const TextFieldHatan({
    Key? key,
    required this.title,
    required this.width,
    required this.inputType,
    this.padding,
    required this.controller,
    this.onTapped,
    this.maxLines, this.height,
    this.validator,
    this.autoValidateMode,
    this.readOnly,
    this.passwordVisible,
    this.onPassHide,
  }): super(key: key);


  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: padding??const EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            width: width,
              alignment: Alignment.centerRight,
              child:  Text(title , maxLines: 1,style: const TextStyle(color: Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold),)
          ),
          Container(
            height:height?? 50,
            width: width,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  offset: Offset(0, 0), // Shadow position
                ),
              ],
            ),
            child:InkWell(
              onTap: (){
                if(onTapped != null){
                  onTapped!();
                }
              },
              child: Row(
                children: [
                  inputType==TextInputType.datetime?const SizedBox(height: 30,width: 40, child:  Icon(Icons.date_range_rounded,size: 30,)):Container(),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        obscureText:passwordVisible??false,
                        showCursor: true,
                        readOnly:readOnly?? false,

                        onTap: (){
                          if(onTapped != null){
                            onTapped!();
                          }
                        },

                        autovalidateMode: autoValidateMode,
                        validator: (input){
                          if(validator != null){
                             validator!(input);
                          }

                          return null;
                        },
                        maxLines: maxLines??999,
                        controller: controller,

                        cursorColor: Colors.black,
                        keyboardType: inputType,
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          suffixIcon:(passwordVisible!=null)? IconButton(
                            icon: Icon(
                              !(passwordVisible!) ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed:()=>onPassHide!(),
                          ):const SizedBox(height: 0,width: 0,),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            //errorBorder: InputBorder.,
                            disabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                            //hintText: "Hint here"
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
