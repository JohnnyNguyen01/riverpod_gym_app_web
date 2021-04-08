import 'package:adonis_web_test/domain/databases/databases.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:adonis_web_test/states/auth/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRoomListStreamProvider =
    StreamProvider.autoDispose<List<ChatRoom>>((ref) async* {
  final coachInfo = ref.watch(userStateProvider);
  final allChatRoomsStream =
      ref.read(databaseProvider).getChatRoomsStream(coachUID: coachInfo.uid);

  await for (final chatRoom in allChatRoomsStream) {
    yield chatRoom;
  }
});
