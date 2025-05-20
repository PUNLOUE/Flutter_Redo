// lib/screens/participant_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item_model.dart';
import '../providers/item_provider.dart';
import 'add_participant_screen.dart';

class ParticipantListScreen extends StatelessWidget {
  const ParticipantListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
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
