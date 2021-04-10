import 'package:adonis_web_test/states/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final dashboardControllerProvider = Provider<DashboardController>((ref) {
  return DashboardController(read: ref.read);
});

class DashboardController {
  final Reader read;
  DashboardController({@required this.read});

  //todo: remove
  void testBtn() async {
    final userState = read(userStateProvider);
    print(userState);
  }
}
