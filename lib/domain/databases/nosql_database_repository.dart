import 'package:adonis_web_test/domain/models/models.dart';
import 'package:meta/meta.dart';

abstract class NoSqlDatabaseRepository {
  Future<void> addNewUser(UserModel user);
  Future<Coach> getCoach({@required String coachUid});
  Future<void> uploadUserWorkoutValues(
      {@required WorkoutUserValuesModel model, @required String uid});
  Stream<List<Message>> getChatRoomMessagesStream(
      {@required String coachUID, @required clientUID});
  Future<void> addMessageToChatRoom(
      {@required String coachUID,
      @required String clientUID,
      @required Message message});
  Future<List<ChatRoom>> getChatRooms({String uid});
  Stream<List<ChatRoom>> getChatRoomsStream({@required String coachUID});
  Future<void> updateChatRoomDoc({@required ChatRoom roomInfo});
  Future<String> setUserName(String uid, String newName);
  Future<UserModel> getUser(String uid);
  Future<Workout> getUserWorkout(String uid, DateTime dateTime);
  Stream<List<ExerciseForDatatable>> getExerciseListAsStream();
  Future<void> deleteExercise({@required ExerciseForDatatable exercise});
  Future<void> addNewExercise();
}
