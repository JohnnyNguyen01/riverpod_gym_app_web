import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/states/states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MessageBubble extends ConsumerWidget {
  final Message message;
  MessageBubble({@required this.message});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final formattedDateString = DateFormat('hh:mm a').format(message.sentAt);

    final user = watch(userStateProvider);
    final textTheme = Theme.of(context).textTheme;
    final bool _fromUser = message.senderUID == user.uid;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment:
            _fromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                _fromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage:
                    CachedNetworkImageProvider(message.profileImageURL),
              ),
              const SizedBox(
                width: 8,
              ),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                  child: Text(
                    message.message,
                    style: textTheme.bodyText2.copyWith(
                        color: _fromUser ? Colors.white : Colors.black,
                        fontSize: 14),
                  ),
                ),
                color: _fromUser ? Color(0xFF1A233B) : Colors.white,
              )
            ],
          ),
          Text(
            'Sent At: $formattedDateString',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
