part of 'chart_cubit.dart';

abstract class ChartState {}

class ChartInitial extends ChartState {}


class ChartLoading extends ChartState {}
class ChartError extends ChartState {}
class ChartDown extends ChartState {}
class ChartUpdate extends ChartState {}


class GetAllSectionsDown extends ChartState {}
class GetAllSectionsLoading extends ChartState {}
class GetAllSectionsError extends ChartState {}