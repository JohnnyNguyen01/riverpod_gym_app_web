import 'package:adonis_web_test/config/config.dart';
import 'package:adonis_web_test/domain/models/models.dart';
import 'package:adonis_web_test/states/states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserView extends ConsumerWidget {
  @override
  Widget build(BuildContext contex, ScopedReader watch) {
    final selectedClient = watch(selectedClientStateProvider);
    return selectedClient != UserModel.initValue()
        ? _BuildUserProfile(client: selectedClient)
        : Text("No, it is initValue");
  }
}

class _BuildUserProfile extends StatelessWidget {
  final UserModel client;

  _BuildUserProfile({@required this.client});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "User profile",
          style: kPageHeading,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 15),
        _buildCard()
      ],
    );
  }

  Card _buildCard() {
    return Card(
      elevation: 3,
      child: Container(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage:
                    CachedNetworkImageProvider(client.profileImageURL),
              ),
              const SizedBox(height: 15),
              Text(client.userName,
                  style: kPageHeading.copyWith(color: Color(0xFF3D5578))),
              const SizedBox(height: 8),
              Text(
                client.email,
                style: const TextStyle(color: Color(0xFF8EA1B2), fontSize: 16),
              ),
              const SizedBox(height: 15),
              Container(
                height: 2,
                color: Color(0xFF8EA1B2),
                // width: double.infinity,
              ),
              const SizedBox(height: 15),
              Text(
                'User Goals',
                textAlign: TextAlign.left,
                style: kTableHeading.copyWith(
                  color: Color(0xFF8EA1B2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
