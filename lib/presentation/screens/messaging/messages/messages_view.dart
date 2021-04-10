import 'package:adonis_web_test/domain/models/models.dart';
import 'package:adonis_web_test/presentation/screens/messaging/messages/input_row.dart';
import 'package:adonis_web_test/presentation/screens/messaging/messages/message_bubbles.dart';
import 'package:adonis_web_test/states/messaging/messages/message_state.dart';
import 'package:adonis_web_test/states/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesView extends StatefulWidget {
  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final roomInfo = watch(selectedChatRoomStateProvider);
      final currentMessageStream = watch(messageStreamStateProvider);
      if (roomInfo == ChatRoom.init()) {
        return Container();
      } else
        return StreamBuilder(
          initialData: [],
          stream: currentMessageStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: const CircularProgressIndicator(),
              );
            } else if (snapshot.data == null) {
              return Text("No chats");
            } else if (snapshot.hasData) {
              return Expanded(child: _buildMessageListView(snapshot: snapshot));
            } else
              return const Text('No Chats');
          },
        );
    });
  }

  Widget _buildMessageListView({@required AsyncSnapshot snapshot}) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              reverse: true,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: snapshot.data[index]);
              }),
        ),
        Consumer(
          builder: (context, watch, child) => BuildInputRow(watch: watch),
        ),
      ],
    );
  }
}
