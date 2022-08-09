part of 'all_request_join_cubit.dart';

abstract class AllRequestJoinState extends Equatable {
  const AllRequestJoinState();

  @override
  List<Object?> get props => [];
}

class AllRequestJoinEmpty extends AllRequestJoinState {}

class AllRequestJoinLoading extends AllRequestJoinState {}

class AllRequestJoinError extends AllRequestJoinState {
  final String message;

  const AllRequestJoinError(this.message);

  @override
  List<Object?> get props => [message];
}

class AllRequestJoinHasData extends AllRequestJoinState {
  final List<Absensi> absensi;

  const AllRequestJoinHasData(this.absensi);

  @override
  List<Object?> get props => [absensi];
}
