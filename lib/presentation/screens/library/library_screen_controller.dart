import 'package:adonis_web_test/domain/databases/databases.dart';
import 'package:adonis_web_test/presentation/screens/library/create_program_dialog/create_program_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final libraryScreenControllerProvider =
    Provider<LibraryScreenController>((ref) {
  final NoSqlDatabaseRepository databaseRep = ref.read(databaseProvider);

  return LibraryScreenController(read: ref.read, databaseRepo: databaseRep);
});

class LibraryScreenController {
  final Reader read;
  final NoSqlDatabaseRepository databaseRepo;

  LibraryScreenController(
      {@required Reader read, @required NoSqlDatabaseRepository databaseRepo})
      : this.read = read,
        this.databaseRepo = databaseRepo;

  void handleCreateNewBtn({@required BuildContext context}) {
    //show dialog to create new program
    showDialog(context: context, builder: (_) => CreateProgramDialog());
    //Validate form input

    // Store values in state
  }
}
