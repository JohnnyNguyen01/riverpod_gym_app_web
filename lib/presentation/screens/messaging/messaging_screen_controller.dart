import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/states/messaging/messages/message_state.dart';
import 'package:adonis_web_test/states/messaging/messages/messages_stream_provider.dart';
import 'package:adonis_web_test/states/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final messagingScreenControllerProvider =
    Provider<MessagingScreenController>((ref) {
  return MessagingScreenController(read: ref.read);
});

class MessagingScreenController {
  final Reader read;

  MessagingScreenController({@required this.read});

  void handleLeadingAppbarBtn({@required BuildContext context}) =>
      Navigator.of(context).pop();

  void handleChatRoomClick({@required ChatRoom chatRoom}) {
    final selectedChatRoom = read(selectedChatRoomStateProvider.notifier);
    final selectedRoomState = read(selectedChatRoomStateProvider);
    selectedChatRoom.setChatRoom(chatRoom: chatRoom);
    read(messageStreamStateProvider.notifier).setMessageStream(
        clientUID: selectedRoomState.clientID,
        coachUID: selectedRoomState.coachID);
  }
}
