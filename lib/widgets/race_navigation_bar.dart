import 'package:flutter/material.dart';

class RaceNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const RaceNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const <Widget>[
        NavigationDestination(icon: Icon(Icons.group), label: 'Participant'),
        NavigationDestination(icon: Icon(Icons.play_arrow), label: 'Start'),
        NavigationDestination(icon: Icon(Icons.emoji_events), label: 'Result'),
      ],
    );
  }
}