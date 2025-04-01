part of 'add_effectiveness_cubit.dart';

abstract class AddEffectivenessState {}

class AddEffectivenessInitial extends AddEffectivenessState {}
class AddEffectivenessUpdate extends AddEffectivenessState {}

class AddEffectivenessLoading extends AddEffectivenessState {}
class AddEffectivenessError extends AddEffectivenessState {}
class AddEffectivenessSuccess extends AddEffectivenessState {}
