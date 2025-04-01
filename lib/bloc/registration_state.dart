part of 'registration_cubit.dart';

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationUpdate extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}
class RegistrationError extends RegistrationState {}
class RegistrationLoading extends RegistrationState {}


class RegistrationIsNotAcceptableData extends RegistrationState {}
class EmailAlreadyExist extends RegistrationState {}
class PasswordIsNotValid extends RegistrationState {}
class PhoneIsNotValid extends RegistrationState {}
class AgeIsNotValid extends RegistrationState {}
class IDIsNotValid extends RegistrationState {}

class SorryIDoNotHavePlaceEmpty extends RegistrationState {}
class SorryIDoNotHaveSectionEmpty extends RegistrationState {}


class ChooseSectionLoading extends RegistrationState {}
class ChooseSectionError extends RegistrationState {}
class ChooseSectionDown extends RegistrationState {}

class AddTeamError extends RegistrationState {}
class AddTeamDown extends RegistrationState {}
class PassHide extends RegistrationState {}


class GetAllSectionsDown extends RegistrationState {}
class GetAllSectionsLoading extends RegistrationState {}
class GetAllSectionsError extends RegistrationState {}


