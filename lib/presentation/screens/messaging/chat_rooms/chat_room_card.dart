import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatRoomCard extends StatelessWidget {
  final String profileImageURL;
  final String latestMessage;
  final String participantName;
  final Function onTap;

  const ChatRoomCard(
      {@required this.profileImageURL,
      @required this.latestMessage,
      @required this.participantName,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(profileImageURL),
      ),
      title: Text(
        participantName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(latestMessage),
      onTap: onTap,
    );
  }
}
