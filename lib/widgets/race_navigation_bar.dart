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
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ElevatedButton(
                onPressed: () => onDestinationSelected(0),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedIndex == 0
                      ? const Color.fromARGB(255, 88, 86, 214)
                      : const Color(0xFFEFF1F5),
                  foregroundColor: selectedIndex == 0
                      ? Colors.white
                      : const Color.fromARGB(255, 88, 86, 214),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  minimumSize: const Size(0, 60),
                ),
                child: const Icon(Icons.group, size: 30),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () => onDestinationSelected(1),
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedIndex == 1
                    ? const Color.fromARGB(255, 88, 86, 214)
                    : const Color(0xFFEFF1F5),
                foregroundColor: selectedIndex == 1
                    ? Colors.white
                    : const Color.fromARGB(255, 88, 86, 214),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                minimumSize: const Size(0, 60),
              ),
              child: const Icon(Icons.play_arrow, size: 30),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ElevatedButton(
                onPressed: () => onDestinationSelected(2),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedIndex == 2
                      ? const Color.fromARGB(255, 88, 86, 214)
                      : const Color(0xFFEFF1F5),
                  foregroundColor: selectedIndex == 2
                      ? Colors.white
                      : const Color.fromARGB(255, 88, 86, 214),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  minimumSize: const Size(0, 60),
                ),
                child: const Icon(Icons.emoji_events, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}