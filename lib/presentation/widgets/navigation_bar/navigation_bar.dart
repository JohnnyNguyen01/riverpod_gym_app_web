import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      labelType: NavigationRailLabelType.selected,
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: Text('Dashboard'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.bookmark_border),
          selectedIcon: Icon(Icons.book),
          label: Text('Exercises'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.message_outlined),
          selectedIcon: Icon(Icons.message),
          label: Text('Messages'),
        ),
      ],
    );
  }
}

// Container(
//       height: double.infinity,
//       width: 100,
//       color: Color(0xFF222328),
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           ListTile(
//             title: Column(
//               children: [
//                 Icon(
//                   Icons.supervisor_account,
//                   size: 30,
//                   color: Colors.white,
//                 ),
//                 Text(
//                   "ATHLETES",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 )
//               ],
//             ),
//             onTap: () {},
//             onLongPress: () {},
//           )
//         ],
//       ),
//     );