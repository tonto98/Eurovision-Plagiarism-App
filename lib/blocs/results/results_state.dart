import 'package:eurovision_app/models/results.dart';

abstract class ResultsState {}

class ResultsSuccess extends ResultsState {
  final Results results;
  ResultsSuccess({required this.results});
}

class ResultsLoading extends ResultsState {}
