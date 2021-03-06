import 'package:adonis_web_test/presentation/screens/messaging/chat_rooms/chat_rooms.dart';
import 'package:adonis_web_test/presentation/screens/messaging/messages/messages_view.dart';
import 'package:adonis_web_test/presentation/screens/messaging/messaging_screen_controller.dart';
import 'package:adonis_web_test/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagingScreen extends ConsumerWidget {
  static const String routeName = '/messaging-screen';

  static Route route() => PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => MessagingScreen(),
        transitionDuration: const Duration(seconds: 0),
      );

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      // appBar: _buildAppBar(context, watch),
      body: Row(
        children: [
          NavigationBar(),
          ChatRooms(),
          MessagesView(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, ScopedReader watch) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
        onPressed: () => watch(messagingScreenControllerProvider)
            .handleLeadingAppbarBtn(context: context),
      ),
      title: Text(
        'Messages 💻',
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
