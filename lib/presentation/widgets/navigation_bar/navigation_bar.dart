import 'package:adonis_web_test/presentation/widgets/navigation_bar/navigation_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _selectedIndex = watch(navigatioBarControllerProvider);
    return Consumer(
      builder: (context, watch, child) {
        final _pageController = watch(navigatioBarControllerProvider.notifier);

        return NavigationRail(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            _pageController.handleChange(index: index, context: context);
          },
          labelType: NavigationRailLabelType.selected,
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: Text('Dashboard'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.people),
              label: Text('users'),
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
      },
    );
  }
}
