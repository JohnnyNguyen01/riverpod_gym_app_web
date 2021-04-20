import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SelectedWeekSessionModel extends Equatable {
  final int week;
  final int sessionNumber;

  SelectedWeekSessionModel({@required this.week, @required this.sessionNumber});

  SelectedWeekSessionModel.init()
      : this.week = 0,
        this.sessionNumber = 0;

  SelectedWeekSessionModel copyWith({int week, int sessionNumber}) {
    return SelectedWeekSessionModel(
        week: week ?? this.week,
        sessionNumber: sessionNumber ?? this.sessionNumber);
  }

  @override
  List<Object> get props => [week, sessionNumber];

  @override
  bool get stringify => true;
}
