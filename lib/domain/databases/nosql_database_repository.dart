import 'package:adonis_web_test/domain/models/models.dart';
import 'package:meta/meta.dart';

abstract class NoSqlDatabaseRepository {
  Future<void> addNewUser(UserModel user);
  Future<Coach> getCoach({@required String coachUid});
  Future<void> uploadUserWorkoutValues(
      {@required WorkoutUserValuesModel model, @required String uid});
  Stream<List<Message>> getChatRoomStream(
      {@required String coachUID, @required clientUID});
  Future<void> addMessageToChatRoom(
      {@required String coachUID,
      @required String clientUID,
      @required Message message});
  Future<List<MessageContact>> getChatRooms({String uid});
  Future<void> updateChatRoomDoc({@required MessageContact roomInfo});
  Future<String> setUserName(String uid, String newName);
  Future<UserModel> getUser(String uid);
  Future<Workout> getUserWorkout(String uid, DateTime dateTime);
}
