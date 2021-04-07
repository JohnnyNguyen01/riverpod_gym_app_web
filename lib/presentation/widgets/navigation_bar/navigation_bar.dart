import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 100,
      color: Color(0xFF222328),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Column(
              children: [
                Icon(
                  Icons.supervisor_account,
                  size: 30,
                  color: Colors.white,
                ),
                Text(
                  "ATHLETES",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
            onTap: () {},
            onLongPress: () {},
          )
        ],
      ),
    );
  }
}
