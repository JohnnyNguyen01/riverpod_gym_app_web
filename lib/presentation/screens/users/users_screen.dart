import 'package:adonis_web_test/presentation/screens/users/user_view/user_view.dart';
import 'package:adonis_web_test/presentation/screens/users/users_list/users_list.dart';
import 'package:adonis_web_test/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersScreen extends ConsumerWidget {
  static const String routeName = '/users';
  static Route route() => PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => UsersScreen(),
      transitionDuration: const Duration(seconds: 0));

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      body: Row(
        children: [
          NavigationBar(),
          UsersList(),
          const SizedBox(width: 15),
          UserView(),
        ],
      ),
    );
  }
}
