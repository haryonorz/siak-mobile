part of 'all_situation_class_cubit.dart';

abstract class AllSituationClassState extends Equatable {
  const AllSituationClassState();

  @override
  List<Object?> get props => [];
}

class AllSituationClassEmpty extends AllSituationClassState {}

class AllSituationClassLoading extends AllSituationClassState {}

class AllSituationClassError extends AllSituationClassState {
  final String message;

  const AllSituationClassError(this.message);

  @override
  List<Object?> get props => [message];
}

class AllSituationClassHasData extends AllSituationClassState {
  final List<Absensi> absensi;

  const AllSituationClassHasData(this.absensi);

  @override
  List<Object?> get props => [absensi];
}
