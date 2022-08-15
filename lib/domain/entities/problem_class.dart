import 'package:equatable/equatable.dart';

class ProblemClass extends Equatable {
  const ProblemClass({
    required this.idProblem,
    required this.description,
    this.selected = false,
  });

  final String idProblem;
  final String description;
  final bool selected;

  ProblemClass copywith(
      {String? idProblem, String? description, bool? selected}) {
    return ProblemClass(
      idProblem: idProblem ?? this.idProblem,
      description: description ?? this.description,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [
        idProblem,
        description,
        selected,
      ];
}
