part of 'join_to_effectiveness_cubit.dart';

abstract class JoinToEffectivenessState {}

class JoinToEffectivenessInitial extends JoinToEffectivenessState {}

class JoinToEffectivenessLoading extends JoinToEffectivenessState {}
class JoinToEffectivenessError extends JoinToEffectivenessState {}
class JoinToEffectivenessSuccess extends JoinToEffectivenessState {}
