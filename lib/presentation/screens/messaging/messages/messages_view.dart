import 'package:adonis_web_test/presentation/screens/messaging/messages/message_bubbles.dart';
import 'package:adonis_web_test/states/messaging/messages/messages_stream_provider.dart';
import 'package:adonis_web_test/states/messaging/selected_chat_room/selected_chat_room_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final messagesStream = watch(messagesStreamProvider);
    return messagesStream.when(
        data: (messageList) {
          return (messageList.isEmpty || messageList == null)
              ? Center(
                  child: Text('No messages'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return MessageBubble(message: messageList[index]);
                  });
        },
        loading: () => const Center(
              child: const CircularProgressIndicator(),
            ),
        error: (err, stack) => Center(
              child: Text(
                err.toString(),
              ),
            ));
  }
}
