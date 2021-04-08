import 'package:adonis_web_test/presentation/screens/messaging/chat_rooms/chat_room_card.dart';
import 'package:adonis_web_test/presentation/screens/messaging/messaging_screen_controller.dart';
import 'package:adonis_web_test/presentation/widgets/widgets.dart';
import 'package:adonis_web_test/states/messaging/chat_room_list/chat_room_list_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRooms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: screenSize.width / 6,
        child: Scaffold(
          body: Material(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildHeading(),
                  const SizedBox(height: 30),
                  _buildChatRoomsListView()
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Chats.',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 26,
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.search))
      ],
    );
  }

  Widget _buildChatRoomsListView() {
    return Consumer(
      builder: (context, watch, child) {
        final chatRoomsStream = watch(chatRoomListStreamProvider);
        final messagingScrenController =
            watch(messagingScreenControllerProvider);
        return chatRoomsStream.when(
          data: (chatRoomList) {
            return chatRoomList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: chatRoomList.length,
                    itemBuilder: (context, index) {
                      final chatRoom = chatRoomList[index];
                      return ChatRoomCard(
                        profileImageURL: chatRoom.clientImageURL,
                        latestMessage: chatRoom.latestMessage,
                        participantName: chatRoom.client,
                        onTap: () => messagingScrenController
                            .handleChatRoomClick(chatRoom: chatRoom),
                      );
                    })
                : Text('No chats yet');
          },
          loading: () => const Center(
            child: const CircularProgressIndicator(),
          ),
          error: (err, stack) => Text(
            err.toString(),
          ),
        );
      },
    );
  }
}
