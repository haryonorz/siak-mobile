import 'package:equatable/equatable.dart';

class ActivityClass extends Equatable {
  const ActivityClass({
    required this.idActivity,
    required this.description,
    this.selected = false,
  });

  final String idActivity;
  final String description;
  final bool selected;

  ActivityClass copywith(
      {String? idActivity, String? description, bool? selected}) {
    return ActivityClass(
      idActivity: idActivity ?? this.idActivity,
      description: description ?? this.description,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [
        idActivity,
        description,
        selected,
      ];
}
