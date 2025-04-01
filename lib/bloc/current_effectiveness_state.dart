part of 'current_effectiveness_cubit.dart';

abstract class CurrentEffectivenessState {}

class CurrentEffectivenessInitial extends CurrentEffectivenessState {}

class CurrentEffectivenessLoading extends CurrentEffectivenessState {}
class CurrentEffectivenessError extends CurrentEffectivenessState {}
class CurrentEffectivenessDown extends CurrentEffectivenessState {}

class CurrentEffectivenessEmpty extends CurrentEffectivenessState {}


class JoinToEffectivenessLoading extends CurrentEffectivenessState {}
class JoinToEffectivenessError extends CurrentEffectivenessState {}
class JoinToEffectivenessDown extends CurrentEffectivenessState {}

class AlreadyRegistered extends CurrentEffectivenessState {}