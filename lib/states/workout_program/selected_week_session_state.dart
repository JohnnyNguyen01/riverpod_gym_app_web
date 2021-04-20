import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:meta/meta.dart';

final selectedWeekSessionStateProivder =
    StateNotifierProvider<SelectedWeekSessionState, SelectedWeekSessionModel>(
        (ref) => SelectedWeekSessionState(read: ref.read));

class SelectedWeekSessionState extends StateNotifier<SelectedWeekSessionModel> {
  final Reader read;
  SelectedWeekSessionState({@required this.read})
      : super(SelectedWeekSessionModel.init());

  void setSelectedWeekSession(
      {@required int week, @required int sessionNumber}) {
    state = state.copyWith(sessionNumber: sessionNumber, week: week);
  }
}
