import 'package:adonis_web_test/config/style_constants.dart';
import 'package:adonis_web_test/presentation/screens/library/library_screen_controller.dart';
import 'package:adonis_web_test/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryScreen extends StatelessWidget {
  static const routeName = '/library';
  static Route route() => PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => LibraryScreen(),
        transitionDuration: const Duration(seconds: 0),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationBar(),
          MainLibraryView(),
        ],
      ),
    );
  }
}

class MainLibraryView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _responsiveWidth = MediaQuery.of(context).size.width - 95;
    final _screenController = watch(libraryScreenControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          elevation: 2,
          color: Colors.white,
          child: Container(
            width: _responsiveWidth,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Text(
                "Library",
                style: kPageHeading,
              ),
            ),
          ),
        ),
        Container(
          width: _responsiveWidth,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Programs',
                style: kPageHeading,
              ),
              ElevatedButton(
                child: Text('Create New'),
                onPressed: () =>
                    _screenController.handleCreateNewBtn(context: context),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.blue)),
              )
            ],
          ),
        ),
        Container(
          width: _responsiveWidth,
          child: DataTable(
              headingRowColor: MaterialStateProperty.resolveWith<Color>(
                  (states) => Colors.grey),
              columns: [
                DataColumn(label: Text('Title', style: kTableHeading)),
                DataColumn(label: Text('Description', style: kTableHeading)),
                DataColumn(label: Text('Created By', style: kTableHeading)),
                DataColumn(label: Text('Actions', style: kTableHeading))
              ],
              rows: []),
        ),
      ],
    );
  }
}
