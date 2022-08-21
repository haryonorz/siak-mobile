part of 'accept_request_join_cubit.dart';

abstract class AcceptRequestJoinState extends Equatable {
  const AcceptRequestJoinState();

  @override
  List<Object?> get props => [];
}

class AcceptRequestJoinInitial extends AcceptRequestJoinState {}

class AcceptRequestJoinLoading extends AcceptRequestJoinState {}

class AcceptRequestJoinError extends AcceptRequestJoinState {
  final String message;

  const AcceptRequestJoinError(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}

class AcceptRequestJoinSuccess extends AcceptRequestJoinState {}
