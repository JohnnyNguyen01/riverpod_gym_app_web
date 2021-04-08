import 'package:adonis_web_test/domain/databases/firebase_firestore_service.dart';
import 'package:adonis_web_test/states/auth/user_state.dart';
import 'package:adonis_web_test/states/messaging/chat_room_list/chat_room_list_stream.dart';
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
    print(userState.uid);
    final chatList =
        read(databaseProvider).getChatRoomsStream(coachUID: userState.uid);
    final result = await chatList.first;
    print(result);
  }
}
