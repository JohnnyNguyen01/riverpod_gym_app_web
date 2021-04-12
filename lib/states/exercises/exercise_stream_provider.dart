import 'package:adonis_web_test/domain/databases/databases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exerciseListStreamProvider = StreamProvider.autoDispose((ref) async* {
  final exerciseListStream =
      ref.read(databaseProvider).getExerciseListAsStream();

  await for (final exercise in exerciseListStream) {
    yield exercise;
  }
});
