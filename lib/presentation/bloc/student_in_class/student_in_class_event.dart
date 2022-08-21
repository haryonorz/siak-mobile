part of 'student_in_class_bloc.dart';

abstract class StudentInClassEvent extends Equatable {
  const StudentInClassEvent();

  @override
  List<Object> get props => [];
}

class OnFetchData extends StudentInClassEvent {
  final String idAgenda;

  const OnFetchData(this.idAgenda);

  @override
  List<Object> get props => [idAgenda];
}

class OnQueryChanged extends StudentInClassEvent {
  final String query;
  final String idAgenda;

  const OnQueryChanged(
    this.idAgenda,
    this.query,
  );

  @override
  List<Object> get props => [query, idAgenda];
}
