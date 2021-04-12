import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ExerciseForDatatable extends Equatable {
  final String exerciseName;
  final String exerciseURL;
  final String documentID;

  ExerciseForDatatable(
      {@required this.exerciseName,
      @required this.exerciseURL,
      @required this.documentID});

  ExerciseForDatatable.initState()
      : this.exerciseName = '',
        this.exerciseURL = '',
        this.documentID = '';

  ExerciseForDatatable.fromDocSnapshot(
      {@required Map<String, dynamic> snapshot})
      : this.exerciseName = snapshot['exerciseName'],
        this.exerciseURL = snapshot['exerciseURL'],
        this.documentID = snapshot['docID'];

  //used to create an exercise object for a new exercise document in the `exercises`
  //collection in firestore.
  Map<String, dynamic> newExerciseMap() {
    return {'exerciseName': this.exerciseName, 'exerciseURL': this.exerciseURL};
  }

  ExerciseForDatatable copyWith(
      {String exerciseName, String exerciseURL, String documentID}) {
    return ExerciseForDatatable(
        exerciseName: exerciseName ?? this.exerciseName,
        exerciseURL: exerciseURL ?? this.exerciseName,
        documentID: documentID ?? this.documentID);
  }

  @override
  List<Object> get props => [exerciseName, exerciseURL];
}
