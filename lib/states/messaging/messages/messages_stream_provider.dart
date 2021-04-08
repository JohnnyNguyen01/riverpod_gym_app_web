import 'package:adonis_web_test/domain/domain.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:adonis_web_test/states/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

// final messagesStreamProvider = StreamProvider<List<Message>>((ref) async* {
//   var selectedRoomState = ref.read(messageStreamProvider);

//   await for (var message in selectedRoomState) {
//     yield message;
//   }
// });

// final messageStreamProvider =
//     StateNotifierProvider<MessageStream, Stream<List<Message>>>((ref) {
//   final databaseRepo = ref.read(databaseProvider);
//   return MessageStream(read: ref.read, databaseRepo: databaseRepo);
// });

// class MessageStream extends StateNotifier<Stream<List<Message>>> {
//   final Reader read;
//   final NoSqlDatabaseRepository databaseRepo;
//   MessageStream({@required this.read, @required this.databaseRepo})
//       : super(null) {
//     _initState();
//   }

//   Stream<List<Message>> _initState() {
//     Stream<List<Message>> initStream() async* {}
//     return initStream();
//   }

//   void setMessageStream(
//       {@required String clientUID, @required String coachUID}) {
//     state = databaseRepo.getChatRoomMessagesStream(
//         coachUID: coachUID, clientUID: clientUID);
//   }
// }
