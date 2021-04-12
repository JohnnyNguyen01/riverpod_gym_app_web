import 'package:adonis_web_test/config/config.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:adonis_web_test/states/states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final usersStream = watch(usersStreamProvider);
    return usersStream.when(
        data: (usersList) {
          final screenSize = MediaQuery.of(context).size;
          return Material(
            elevation: 2,
            child: Container(
              width: screenSize.width / 6,
              child: Column(
                children: [
                  Text(
                    'Users',
                    style: kPageHeading,
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: usersList.length,
                      itemBuilder: (context, index) =>
                          _buildUserTile(user: usersList[index], watch: watch)),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(
              child: const CircularProgressIndicator(),
            ),
        error: (err, stck) => Center(child: Text(err.toString())));
  }

  Widget _buildUserTile(
      {@required UserModel user, @required ScopedReader watch}) {
    final clientController = watch(selectedClientStateProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.profileImageURL),
          ),
          title: Text(user.userName),
          subtitle: Text(user.uid),
          onTap: () => clientController.setUser(newUser: user),
        ),
        Container(
          color: Colors.grey,
          height: 1,
          width: 10,
        )
      ],
    );
  }
}
