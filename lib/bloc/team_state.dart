part of 'team_cubit.dart';

@immutable
abstract class TeamState {}

class TeamInitial extends TeamState {}

class TeamLoading extends TeamState {}
class TeamDown extends TeamState {}
class TeamError extends TeamState {}

class TeamEmpty extends TeamState {}
