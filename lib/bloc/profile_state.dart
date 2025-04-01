part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}
class ProfileError extends ProfileState {}
class ProfileDown extends ProfileState {}


class UpdateIsNotAcceptableData extends ProfileState {}
class EmailAlreadyExist extends ProfileState {}
class PasswordIsNotValid extends ProfileState {}
class PhoneIsNotValid extends ProfileState {}
class EmailIsNotValid extends ProfileState {}

class UpdateProfileError extends ProfileState {}

