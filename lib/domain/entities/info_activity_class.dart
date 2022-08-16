import 'package:equatable/equatable.dart';
import 'package:siak_mobile/domain/entities/activity_class.dart';

class InfoActivityClass extends Equatable {
  final List<ActivityClass> activityList;
  final String inputDuration;

  const InfoActivityClass({
    required this.activityList,
    required this.inputDuration,
  });

  @override
  List<Object> get props => [activityList, inputDuration];
}
