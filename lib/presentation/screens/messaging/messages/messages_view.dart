import 'package:adonis_web_test/domain/databases/firebase_firestore_service.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:adonis_web_test/presentation/screens/messaging/messages/message_bubbles.dart';
import 'package:adonis_web_test/states/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesView extends StatefulWidget {
  final ChatRoom chatRoom;

  MessagesView({@required this.chatRoom});

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final roomInfo = watch(selectedChatRoomStateProvider);
      final databaseProv = watch(databaseProvider);
      return StreamBuilder(
        initialData: [],
        stream: databaseProv.getChatRoomMessagesStream(
            coachUID: roomInfo.coachID, clientUID: roomInfo.clientID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          } else if (snapshot.data == null) {
            return Text("");
          } else if (snapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return MessageBubble(message: snapshot.data[index]);
                  }),
            );
          } else
            return const Text('');
        },
      );
    });

    //  messagesStream.when(
    //     data: (messageList) {
    //       return (messageList.isEmpty || messageList == null)
    //           ? Center(
    //               child: Text('No messages'),
    //             )
    //           : ListView.builder(
    //               shrinkWrap: true,
    //               itemCount: messageList.length,
    //               itemBuilder: (context, index) {
    //                 return MessageBubble(message: messageList[index]);
    //               });
    //     },
    //     loading: () => const Center(
    //           child: const CircularProgressIndicator(),
    //         ),
    //     error: (err, stack) => Center(
    //           child: Text(
    //             err.toString(),
    //           ),
    //         ));
  }
}
