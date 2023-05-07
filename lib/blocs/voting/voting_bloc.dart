import 'package:eurovision_app/blocs/voting/voting_state.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/repository/voting_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VotingBloc extends Cubit<VotingState> {
  VotingBloc() : super(VotingReady()) {
    ApplicationCore().authBloc.stream.listen((event) {
      emit(VotingReady());
      ApplicationCore().countriesBloc.updateCountriesState();
    });
  }

  void castVote(int countryId, int points) async {
    emit(VotingLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      bool res = await VotingRepository.castVote(countryId, points);
      if (res) {
        ApplicationCore().authBloc.refresnUserData();
        emit(VotingReady());
      } else {
        emit(VotingReady(message: "Došlo je do greške!"));
      }
    } catch (e) {
      emit(VotingReady(message: "Došlo je do greške!"));
    }
  }
}
