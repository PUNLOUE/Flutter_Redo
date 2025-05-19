// lib/screens/participant_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item_model.dart';
import '../providers/item_provider.dart';
import 'add_participant_screen.dart';

class ParticipantListScreen extends StatefulWidget {
  const ParticipantListScreen({Key? key}) : super(key: key);

  @override
  State<ParticipantListScreen> createState() => _ParticipantListScreenState();
}

class _ParticipantListScreenState extends State<ParticipantListScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Race',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(
        // You may need to define labelBehavior and currentPageIndex as class variables
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: _selectedTabIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.group), label: 'Participart'),
          NavigationDestination(icon: Icon(Icons.play_arrow), label: 'Start'),
          NavigationDestination(icon: Icon(Icons.list), label: 'result'),
          
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.list),
          //   icon: Icon(Icons.list),
          //   label: 'Result',
          // ),
        ],
      ),
      body: Column(
        children: [
          // Tab bar
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                _buildTabButton(0, 'Participant list'),
                _buildTabButton(1, 'Add Participant'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Tab content
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildParticipantList()
                                    : _selectedTabIndex == 1
                    ? AddParticipantScreen(
                        onSubmit: () {
                          // Switch back to participant list tab after adding
                          setState(() {
                            _selectedTabIndex = 0;
                          });
                        },
                      )
                    : const Center(child: Text('Error: Invalid tab')),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String text) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? const Color(0xFF5E5CE6) : Colors.transparent,
                width: 2.0,
              ),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? const Color(0xFF5E5CE6) : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParticipantList() {
    return Consumer<ParticipantProvider>(
      builder: (context, participantProvider, child) {
        final participants = participantProvider.participants;
        
        return Column(
          children: [
            // Header
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'BIB',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5E5CE6),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5E5CE6),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Age',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5E5CE6),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 80), // Space for action buttons
                  ],
                ),
              ),
            ),
            
            // List of participants
            Expanded(
              child: participants.isEmpty
                  ? const Center(child: Text('No participants yet'))
                  : ListView.builder(
                      itemCount: participants.length,
                      itemBuilder: (context, index) {
                        final participant = participants[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(participant.bib),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(participant.name),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(participant.age.toString()),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                                      onPressed: () {
                                        _editParticipant(context, index, participant);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                      onPressed: () {
                                        _deleteParticipant(context, index);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  void _editParticipant(BuildContext context, int index, Participant participant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddParticipantScreen(
          participant: participant,
          participantIndex: index,
          onSubmit: () {
            // Return to the list screen
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _deleteParticipant(BuildContext context, int index) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Participant'),
        content: const Text('Are you sure you want to delete this participant?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ParticipantProvider>(context, listen: false)
                  .deleteParticipant(index);
              Navigator.pop(ctx);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
