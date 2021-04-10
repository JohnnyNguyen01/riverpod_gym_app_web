import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final selectedChatRoomStateProvider =
    StateNotifierProvider<SelectedChatRoom, ChatRoom>((ref) {
  final databaseProv = ref.read(databaseProvider);
  return SelectedChatRoom(read: ref.read, databaseRepo: databaseProv);
});

class SelectedChatRoom extends StateNotifier<ChatRoom> {
  final Reader read;
  final NoSqlDatabaseRepository databaseRepo;
  SelectedChatRoom({@required this.read, @required this.databaseRepo})
      : super(ChatRoom.init());

  void setChatRoom({@required ChatRoom chatRoom}) async {
    state = chatRoom;
  }

  void setLatestMessage(
      {@required String message,
      @required String sentBy,
      @required DateTime sentAt}) {
    final currentState = state;
    final newState = currentState.copyWith(
        latestMessage: message,
        sentAt: Timestamp.fromDate(sentAt),
        sentBy: sentBy);
    state = newState;
  }
}
