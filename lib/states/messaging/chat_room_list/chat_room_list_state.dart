import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final chatRoomListStateProvider =
    StateNotifierProvider<ChatRoomListState, List<ChatRoom>>((ref) =>
        ChatRoomListState(
            read: ref.read, noSqlDBRepo: ref.read(databaseProvider)));

class ChatRoomListState extends StateNotifier<List<ChatRoom>> {
  final Reader read;
  final NoSqlDatabaseRepository noSqlDBRepo;

  ChatRoomListState({@required this.read, @required this.noSqlDBRepo})
      : super([]);

  void getMessagingContactsList({@required String uid}) async {
    try {
      List<ChatRoom> latestChatRooms =
          await read(databaseProvider).getChatRooms(uid: uid);
      state = latestChatRooms;
    } on Failure catch (e) {
      ErrorToast(message: e.message).showToast();
    }
  }
}
