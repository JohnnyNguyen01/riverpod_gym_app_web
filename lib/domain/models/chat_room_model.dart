import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ChatRoom extends Equatable {
  final String clientID;
  final String client;
  final String clientImageURL;
  final String latestMessage;
  final String coach;
  final Timestamp sentAt;
  final String sentBy;
  final String coachImageURL;
  final String coachID;
  final String chatRoomID;

  ChatRoom(
      {@required this.latestMessage,
      @required this.coach,
      @required this.coachID,
      @required this.sentAt,
      @required this.coachImageURL,
      @required this.sentBy,
      @required this.clientID,
      @required this.clientImageURL,
      @required this.client,
      @required this.chatRoomID});

  ChatRoom.init()
      : this.client = '',
        this.clientID = '',
        this.coach = '',
        this.coachID = '',
        this.clientImageURL = '',
        this.coachImageURL = '',
        this.latestMessage = '',
        this.sentAt = null,
        this.chatRoomID = '',
        this.sentBy = '';

  ChatRoom.fromDocumentSnapshot(Map<String, dynamic> snapshot)
      : this.latestMessage = snapshot['latestMessage'],
        this.coach = snapshot['coach'],
        this.coachID = snapshot['coachID'],
        this.sentAt = snapshot['sentAt'],
        this.coachImageURL = snapshot['coachImageURL'],
        this.clientID = snapshot['clientID'],
        this.clientImageURL = snapshot['clientImageURL'],
        this.client = snapshot['client'],
        this.chatRoomID = snapshot['chatRoomID'],
        this.sentBy = snapshot['sentBy'];

  Map<String, dynamic> toMap() {
    return {
      'latestMessage': this.latestMessage,
      'coach': this.coach,
      'coachID': this.coachID,
      'sentAt': this.sentAt,
      'clientImageURL': this.clientImageURL,
      'coachImageURL': this.coachImageURL,
      'clientID': this.clientID,
      'client': this.client,
      'chatRoomID': this.chatRoomID,
      'sentBy': this.sentBy
    };
  }

  ChatRoom copyWith(
      {String latestMessage,
      String coach,
      String coachID,
      Timestamp sentAt,
      String coachImageURL,
      String clientID,
      String client,
      String chatRoomID,
      String clientImageURL,
      String sentBy}) {
    return ChatRoom(
        latestMessage: latestMessage ?? this.latestMessage,
        coach: coach ?? this.coach,
        coachID: coachID ?? this.coachID,
        sentAt: sentAt ?? this.sentAt,
        coachImageURL: coachImageURL ?? this.coachImageURL,
        client: client ?? this.client,
        clientID: clientID ?? this.clientID,
        clientImageURL: clientImageURL ?? this.clientImageURL,
        chatRoomID: chatRoomID ?? this.chatRoomID,
        sentBy: sentBy ?? this.sentBy);
  }

  @override
  List<Object> get props => [
        latestMessage,
        coach,
        coachID,
        sentAt,
        coachImageURL,
        clientImageURL,
        client,
        clientID,
        chatRoomID,
        sentBy
      ];
}
