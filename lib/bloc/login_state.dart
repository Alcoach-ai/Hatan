part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}
class LoginError extends LoginState {}
class PassHide extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginUserIsNull extends LoginState {}
class LoginIsNotAcceptableData extends LoginState {}
