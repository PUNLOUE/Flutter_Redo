 import 'package:flutter/material.dart';
import '../widgets/race_navigation_bar.dart';
import 'participant_list_screen.dart';
import 'add_participant_screen.dart';
// import 'race_start_screen.dart';
// import 'race_result_screen.dart';

class ParticipantManagementScreen extends StatefulWidget {
  const ParticipantManagementScreen({Key? key}) : super(key: key);

  @override
  State<ParticipantManagementScreen> createState() => _ParticipantManagementScreenState();
}

class _ParticipantManagementScreenState extends State<ParticipantManagementScreen> {
  int _selectedNavIndex = 0;
  int _selectedSegmentIndex = 0;

  void _onNavSelected(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  void _onParticipantAdded() {
    setState(() {
      _selectedSegmentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Race'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Place navigation bar below AppBar
          RaceNavigationBar(
            selectedIndex: _selectedNavIndex,
            onDestinationSelected: _onNavSelected,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: _selectedNavIndex == 0
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedSegmentIndex = 0;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: _selectedSegmentIndex == 0
                                              ? const Color(0xFF5E5CE6)
                                              : Colors.transparent,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Participant List',
                                        style: TextStyle(
                                          color: _selectedSegmentIndex == 0
                                              ? const Color(0xFF5E5CE6)
                                              : Colors.black,
                                          fontWeight: _selectedSegmentIndex == 0
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedSegmentIndex = 1;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: _selectedSegmentIndex == 1
                                              ? const Color(0xFF5E5CE6)
                                              : Colors.transparent,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Add Participant',
                                        style: TextStyle(
                                          color: _selectedSegmentIndex == 1
                                              ? const Color(0xFF5E5CE6)
                                              : Colors.black,
                                          fontWeight: _selectedSegmentIndex == 1
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: _selectedSegmentIndex == 0
                              ? const ParticipantListScreen()
                              : AddParticipantScreen(onSubmit: _onParticipantAdded),
                        ),
                      ],
                    )
                  // Uncomment and implement these screens as needed
                  // : _selectedNavIndex == 1
                  //     ? RaceStartScreen()
                  //     : RaceResultScreen(),
                  : const Center(child: Text('Other screens go here')),
            ),
          ),
        ],
      ),
    );
  }
}