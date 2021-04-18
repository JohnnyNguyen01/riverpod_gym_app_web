import 'dart:convert';

import 'package:adonis_web_test/domain/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

///This will be used mainly for the workout program state, where a coach
///will create a new workout for a client.abstract

class WorkoutProgram extends Equatable {
  final String programName;
  final int numberOfWeeks;
  final int sessionsPerWeek;
  final List<Workout> workoutsList;

  WorkoutProgram(
      {@required this.programName,
      @required this.numberOfWeeks,
      @required this.sessionsPerWeek,
      @required this.workoutsList});

  WorkoutProgram.init()
      : this.programName = '',
        this.numberOfWeeks = 0,
        this.sessionsPerWeek = 0,
        this.workoutsList = [];

  WorkoutProgram copyWith(
      {String programName,
      int numberOfWeeks,
      int sessionsPerWeek,
      List<Workout> workouts}) {
    return WorkoutProgram(
        programName: programName ?? this.programName,
        numberOfWeeks: numberOfWeeks ?? this.numberOfWeeks,
        sessionsPerWeek: sessionsPerWeek ?? this.sessionsPerWeek,
        workoutsList: workouts ?? this.workoutsList);
  }

  Map<String, dynamic> toMap() {
    return {
      'programName': this.programName,
      'numberOfWeeks': this.numberOfWeeks,
      'sessionsPerWeek': this.sessionsPerWeek,
      'workouts': this.workoutsList
    };
  }

  factory WorkoutProgram.fromDocSnapshot(Map<String, dynamic> map) {
    return WorkoutProgram(
        programName: map['programName'],
        numberOfWeeks: map['numberOfWeeks'],
        sessionsPerWeek: map['sessionsPerWeek'],
        workoutsList: map['workouts']);
  }

  String toJson() => json.encode(toMap());

  factory WorkoutProgram.fromJson(String source) =>
      WorkoutProgram.fromDocSnapshot(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [programName, numberOfWeeks, sessionsPerWeek];
}
