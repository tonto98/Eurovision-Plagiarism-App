import 'package:eurovision_app/models/results.dart';
import 'package:eurovision_app/repository/results_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'results_state.dart';

class ResultsBloc extends Cubit<ResultsState> {
  ResultsBloc() : super(ResultsLoading()) {
    getResults();
  }

  Results? results;

  void getResults() async {
    emit(ResultsLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      results = await ResultsRepository.getResults();
      if (results != null) {
        emit(ResultsSuccess(results: results!));
      } else {
        throw Exception();
      }
    } catch (e) {
      emit(ResultsLoading());
    }
  }
}
