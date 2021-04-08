import 'package:adonis_web_test/states/auth/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final dashboardControllerProvider = Provider<DashboardController>((ref) {
  return DashboardController(read: ref.read);
});

class DashboardController {
  final Reader read;
  DashboardController({@required this.read});

  //todo: remove
  void testBtn() {
    final userState = read(userStateProvider);
    print(userState);
  }
}
