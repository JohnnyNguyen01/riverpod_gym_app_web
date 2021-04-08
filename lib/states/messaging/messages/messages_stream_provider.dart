import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:adonis_web_test/states/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messagesStreamProvider = StreamProvider<List<Message>>((ref) async* {
  var selectedRoomState = ref.read(selectedChatRoomStateProvider);

  Stream messageStream = ref.read(databaseProvider).getChatRoomMessagesStream(
      coachUID: selectedRoomState.coachID,
      clientUID: selectedRoomState.clientID);

  void setMessageStream() {
    selectedRoomState = ref.read(selectedChatRoomStateProvider);
    messageStream = ref.read(databaseProvider).getChatRoomMessagesStream(
        coachUID: selectedRoomState.coachID,
        clientUID: selectedRoomState.clientID);
  }

  await for (var message in messageStream) {
    yield message;
  }
});
