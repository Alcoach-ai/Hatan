import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatan/bloc/dialog_out_cubit.dart';
import 'package:hatan/local/cache_helper.dart';
import 'package:hatan/models/effectiveness.dart';
import 'package:hatan/models/user.dart';
import 'package:hatan/widget/show_toast.dart';


import 'button_hatan.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final Function yesOnPressed;
  final Function noOnPressed;
  final User? volunteer;
  final Effectiveness? effectiveness;

  const ConfirmationDialog({Key? key, required this.title, required this.yesOnPressed, required this.noOnPressed, this.effectiveness, this.volunteer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: BlocProvider(
        create: (context) => DialogOutCubit(),
        child: BlocConsumer<DialogOutCubit, DialogOutState>(
          listener: (context, state) {
            if(state is ExitDown){
              yesOnPressed();
            }
            if(state is ExitError){
              showToast(text: 'عذرا لا يمكن إتمام العملية', color: Colors.red);
            }


            // TODO: implement listener
          },
          builder: (context, state) {
            return  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonHatan(
                  fontColor: Colors.black,
                  color: (state is ExitLoading)
                      ? Colors.grey.withOpacity(0.5)
                      : Colors.redAccent,
                  onTapped: () {
                    if (state is! ExitLoading) {

                      if(volunteer != null){
                        DialogOutCubit.get(context).removeVolunteer(context,volunteer!);
                        return;
                      }

                      //if admin remove events else exit from events
                      if (CacheHelper.getData(key: 'type') == 1) {
                        DialogOutCubit.get(context).removeEvent(context, effectiveness!);
                      } else{
                        DialogOutCubit.get(context).exit(context, effectiveness!);
                      }
                    }
                  },
                  width: 100,
                  height: 35,
                  text: 'نعم',
                ),
                const SizedBox(width: 16,),
                ButtonHatan(
                  fontColor: Colors.black,
                  color: Colors.white,
                  onTapped: () {
                    Navigator.pop(context);
                  },
                  width: 100,
                  height: 35,
                  text: 'لا',
                ),
              ],
            );
          },
        ),
      ),
      backgroundColor: Colors.white70,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
      ),

    );
  }
}