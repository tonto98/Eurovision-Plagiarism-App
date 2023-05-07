abstract class VotingState {}

class VotingReady extends VotingState {
  final String? message;
  VotingReady({this.message});
}

class VotingLoading extends VotingState {}
