import 'package:flutter/material.dart';

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
      children: [
        const Text(
          'Chats.',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 26,
          ),
        ),
        const SizedBox(width: 40),
        IconButton(onPressed: () {}, icon: Icon(Icons.search))
      ],
    );
  }

  Widget _buildChatRoomsListView() {}
}
