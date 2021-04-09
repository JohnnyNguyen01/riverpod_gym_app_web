import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/states/messaging/messages/messages_stream_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final messageStreamStateProvider =
    StateNotifierProvider<MessageStreamState, Stream<List<Message>>>((ref) {
  final databaseRepo = ref.read(databaseProvider);
  return MessageStreamState(read: ref.read, databaseRepo: databaseRepo);
});

class MessageStreamState extends StateNotifier<Stream<List<Message>>> {
  final Reader read;
  final NoSqlDatabaseRepository databaseRepo;
  MessageStreamState({@required this.read, @required this.databaseRepo})
      : super(Stream.empty());

  void setMessageStream(
      {@required String clientUID, @required String coachUID}) {
    state = databaseRepo.getChatRoomMessagesStream(
        coachUID: coachUID, clientUID: clientUID);
  }
}
