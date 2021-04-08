import 'package:adonis_web_test/domain/databases/firebase_firestore_service.dart';
import 'package:adonis_web_test/states/auth/user_state.dart';
import 'package:adonis_web_test/states/messaging/chat_room_list/chat_room_list_stream.dart';
import 'package:adonis_web_test/states/messaging/messages/messages_stream_provider.dart';
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
    final selectedRoom = read(selectedChatRoomStateProvider);
    print(selectedRoom);
    final chatRoomStream = read(messagesStreamProvider);
    print(chatRoomStream.data.value.first);
  }
}
