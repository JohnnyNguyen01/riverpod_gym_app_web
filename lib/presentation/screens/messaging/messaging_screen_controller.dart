import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/presentation/widgets/widgets.dart';
import 'package:adonis_web_test/states/messaging/messages/message_state.dart';
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

  void handleSendNewMsgBtn({@required TextEditingController inputController}) {
    final roomDetails = read(selectedChatRoomStateProvider);
    final userDetails = read(userStateProvider);
    try {
      read(databaseProvider).addMessageToChatRoom(
        coachUID: roomDetails.coachID,
        clientUID: roomDetails.clientID,
        message: Message(
            message: inputController.text,
            profileImageURL: userDetails.profileImageURL,
            senderUID: userDetails.uid,
            sentAt: DateTime.now(),
            sentBy: userDetails.userName),
      );
      read(selectedChatRoomStateProvider.notifier).setLatestMessage(
        message: inputController.text,
        sentBy: userDetails.userName,
        sentAt: DateTime.now(),
      );
      final newRoomInfo = read(selectedChatRoomStateProvider);
      read(databaseProvider).updateChatRoomDoc(roomInfo: newRoomInfo);
      inputController.text = '';
    } on Failure catch (e) {
      ErrorToast(message: e.message).showToast();
    }
  }
}
