import 'package:adonis_web_test/domain/databases/databases.dart';
import 'package:adonis_web_test/domain/models/workout_program_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

final workoutProgramStateProvider =
    StateNotifierProvider<WorkoutProgramState, WorkoutProgram>((ref) {
  final databaseImplementation = ref.watch(databaseProvider);

  return WorkoutProgramState(
      read: ref.read, databaseRepo: databaseImplementation);
});

class WorkoutProgramState extends StateNotifier<WorkoutProgram> {
  final Reader read;
  final NoSqlDatabaseRepository databaseRepo;

  WorkoutProgramState({@required this.read, @required this.databaseRepo})
      : super(WorkoutProgram.init());

  void addInitialCreationDetails(
      {@required String programName,
      @required int numOfWeeks,
      @required int numOfSessions}) {
    state = state.copyWith(
        programName: programName,
        numberOfWeeks: numOfWeeks,
        sessionsPerWeek: numOfSessions);
  }
}
