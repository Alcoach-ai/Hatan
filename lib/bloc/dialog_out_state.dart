part of 'dialog_out_cubit.dart';

abstract class DialogOutState {}

class DialogOutInitial extends DialogOutState {}

class ExitError extends DialogOutState {}
class ExitLoading extends DialogOutState {}
class ExitDown extends DialogOutState {}