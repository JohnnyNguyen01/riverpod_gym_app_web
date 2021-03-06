import 'dart:developer';

import 'package:adonis_web_test/domain/databases/nosql_database_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adonis_web_test/config/config.dart';
import 'package:riverpod/riverpod.dart';

import '../models/models.dart';

final databaseProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(read: ref.read);
});

class FirestoreService implements NoSqlDatabaseRepository {
  final Reader read;
  FirebaseFirestore _firestore;

  FirestoreService({this.read}) {
    _firestore = _firestore ?? FirebaseFirestore.instance;
  }

  ///Add a new user to the users collection in firestore.
  ///Creates an new doc using their uid
  @override
  Future<void> addNewUser(UserModel user) async {
    CollectionReference users = _firestore.collection('users');
    try {
      await users.doc(user.uid).set({
        'email': user.email,
        'username': user.userName,
        'uid': user.uid,
        'image_url': user.profileImageURL
      });
    } catch (e) {
      throw Failure(error: "error", message: e.toString());
    }
  }

  ///Retrieves a `Coach` object from firestore via a specified `uid`
  @override
  Future<Coach> getCoach({@required String coachUid}) async {
    CollectionReference coachesCollection =
        _firestore.collection(Paths.coaches);

    try {
      final coachSnapshot = await coachesCollection.doc(coachUid).get();
      return Coach.fromDatabase(coachSnapshot.data());
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: "", message: e.toString());
    }
  }

  ///Adds a new doc to `user_entries` in firestore using a user's `uid`. This will
  ///contain a collection of all their entered workout data.
  @override
  Future<void> uploadUserWorkoutValues(
      {@required WorkoutUserValuesModel model, @required String uid}) async {
    CollectionReference userEntries = _firestore.collection(Paths.userEntries);
    try {
      await userEntries
          .doc(uid)
          .collection(Paths.userWorkoutDates)
          .doc(DateTime.now().toString())
          .set({
        'workoutNote': model.workoutNote,
        'completedAt': model.completedAt,
        'startedAt': model.startedAt,
        'workoutCompletionTime': model.workoutCompletionTime,
        'filledOutExercises': model.filledOutExercisesForFirestore()
      });
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: "Generic", message: e.toString());
    }
  }

  // Returns a stream of a specific chat room between a coach and client.
  @override
  Stream<List<Message>> getChatRoomMessagesStream(
      {@required String coachUID, @required clientUID}) {
    final streamSnapshot = _firestore
        .collection(Paths.chatRooms)
        .doc('$coachUID\_$clientUID')
        .collection(Paths.messages)
        .orderBy('sentAt', descending: true)
        .snapshots()
        .asBroadcastStream();

    Stream<List<Message>> messageStream = streamSnapshot.map((event) {
      List<Message> messages = [];
      var allMessages = event.docs;
      for (var doc in allMessages) {
        messages.add(Message.fromDocSnapshot(doc.data()));
      }
      return messages;
    });
    return messageStream.asBroadcastStream();
  }

  // Add messages to chat room between a specific coach and client
  @override
  Future<void> addMessageToChatRoom(
      {@required String coachUID,
      @required String clientUID,
      @required Message message}) async {
    final chatRoomDoc =
        _firestore.collection(Paths.chatRooms).doc('$coachUID\_$clientUID');
    final messagesCollection = chatRoomDoc.collection(Paths.messages);
    messagesCollection.add(message.toMap());
  }

  ///Retrieves a list of all of this client's chatrooms as a `MessageConact` list
  ///via their uid.
  @override
  Future<List<ChatRoom>> getChatRooms({String uid}) async {
    final chatRooms = _firestore
        .collection(Paths.chatRooms)
        .where('clientID', isEqualTo: uid)
        .get();
    try {
      List<ChatRoom> chatList = [];
      final snapshotList = await chatRooms;
      for (var snapshot in snapshotList.docs) {
        chatList.add(ChatRoom.fromDocumentSnapshot(snapshot.data()));
      }
      return chatList;
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: "Error", message: e.toString());
    }
  }

  ///update a specific chat room with the latest details;
  ///`roomInfo` - must be the latest updated messageRoom state.
  @override
  Future<void> updateChatRoomDoc({@required ChatRoom roomInfo}) async {
    try {
      final roomCollection =
          _firestore.collection(Paths.chatRooms).doc(roomInfo.chatRoomID);
      roomCollection.update(roomInfo.toMap());
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: 'Error', message: e.toString());
    }
  }

  ///Set the username for a selected user indicated via their uid.
  @override
  Future<String> setUserName(String uid, String newName) async {
    CollectionReference users = _firestore.collection(Paths.users);
    try {
      await users.doc(uid).update({'username': newName});
      return "Success";
    } on FirebaseException catch (e) {
      log(e.message);
      return e.message;
    }
  }

  ///Retrieve a user's details as a [UserModel] object from firestore.
  @override
  Future<UserModel> getUser(String uid) async {
    CollectionReference users = _firestore.collection('users');
    final userSnapshot = await users.doc(uid).get().catchError((e) {
      print(e);
      return null;
    });
    UserModel user = UserModel.fromDocumentSnapshot(userSnapshot.data());
    return user;
  }

  ///Returns the Workout for the specified uid and timestamp.
  ///todo: Check if there's a more efficient way of doing this
  @override
  Future<Workout> getUserWorkout(String uid, DateTime dateTime) async {
    Workout workout = Workout.empty();
    CollectionReference workoutPlan = _firestore.collection("workout_plan");

    //get latest workout snapshot for specified uid
    final workoutDocRef = await workoutPlan
        .where("clientID", isEqualTo: uid)
        .orderBy("createdAt", descending: false)
        .limit(1)
        .get();

    //get workout document
    final workoutDoc = workoutDocRef.docs[0];

    //get into day's collection
    final workoutDays = workoutDoc.reference.collection("days");
    //snapshot containing list of all workout "days" documents
    final snapshot = await workoutDays.get();
    //loop through each doc and check for a matching DateTime
    snapshot.docs.forEach((doc) {
      var docSnapshot = doc.data();
      List dates = docSnapshot["dates"];
      dates.forEach((timestamp) {
        DateTime docDate = DateTime.parse(timestamp.toDate().toString());
        if (docDate == dateTime) {
          workout = Workout.fromWorkoutPlan(docSnapshot);
        }
      });
    });

    return workout;
  }

  ///Returns a stream that contains a list of all the chat rooms
  @override
  Stream<List<ChatRoom>> getChatRoomsStream({String coachUID}) {
    final chatRoomsStreamSnapshot = _firestore
        .collection(Paths.chatRooms)
        // .orderBy('sentAt')
        .where('coachID', isEqualTo: coachUID)
        .snapshots()
        .asBroadcastStream();

    final chatRoomListStream = chatRoomsStreamSnapshot.map((snapshot) {
      List<ChatRoom> chatRoomsList = [];
      var allChatRoomsDocs = snapshot.docs;
      for (var chatRoomDoc in allChatRoomsDocs) {
        chatRoomsList.add(ChatRoom.fromDocumentSnapshot(chatRoomDoc.data()));
      }
      return chatRoomsList;
    });
    return chatRoomListStream.asBroadcastStream();
  }

  ///Retrieves a stream of all the exercises within the database, to be used
  ///for list generation within UI.
  @override
  Stream<List<ExerciseForDatatable>> getExerciseListAsStream() {
    try {
      // Stream<List<ExerciseForDatatable>> exerciseList = Stream.empty();
      final exerciseListStream = _firestore
          .collection(Paths.exercises)
          .orderBy('exerciseName')
          .snapshots()
          .asBroadcastStream();

      Stream<List<ExerciseForDatatable>> exerciseStreamList =
          exerciseListStream.map((snapshot) {
        List<ExerciseForDatatable> tableList = [];
        var docList = snapshot.docs;
        docList.forEach((document) {
          final docData = document.data();
          tableList.add(ExerciseForDatatable(
              documentID: document.id,
              exerciseName: docData['exerciseName'],
              exerciseURL: docData['exerciseURL']));
        });
        return tableList;
      });
      return exerciseStreamList;
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: 'Error', message: e.toString());
    }
  }

  @override
  Future<void> deleteExercise({@required ExerciseForDatatable exercise}) async {
    try {
      await _firestore
          .collection(Paths.exercises)
          .doc(exercise.documentID)
          .delete();
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: "Error", message: e.toString());
    }
  }

  @override
  Future<void> addNewExercise({@required ExerciseForDatatable exercise}) async {
    try {
      await _firestore
          .collection(Paths.exercises)
          .doc()
          .set(exercise.newExerciseMap());
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: "Error", message: e.toString());
    }
  }

  @override
  Future<void> editExercise({@required ExerciseForDatatable exercise}) async {
    try {
      await _firestore
          .collection(Paths.exercises)
          .doc(exercise.documentID)
          .set(exercise.newExerciseMap());
    } on PlatformException catch (e) {
      throw Failure(error: e.code, message: e.message);
    } catch (e) {
      throw Failure(error: "Error", message: e.toString());
    }
  }

  @override
  Stream<List<UserModel>> getUsersAsStream() {
    final userStreamSnapshot =
        _firestore.collection(Paths.users).snapshots().asBroadcastStream();
    Stream<List<UserModel>> userModelStream =
        userStreamSnapshot.map((snapshot) {
      List<UserModel> userModelList = [];
      final docList = snapshot.docs;
      docList.forEach((doc) {
        userModelList.add(UserModel.fromDocumentSnapshot(doc.data()));
      });
      return userModelList;
    });
    return userModelStream;
  }
}
