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
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Participants',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: participants.isEmpty
                  ? const Center(child: Text('No participants yet'))
                  : ListView.builder(
                      itemCount: participants.length,
                      itemBuilder: (context, index) {
                        final participant = participants[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Text(
                                  '${participant.bib} - ${participant.name}, ${participant.age}',
                                  style: const TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue, size: 20),
                                      onPressed: () {
                                        _editParticipant(
                                            context, index, participant);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red, size: 20),
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

  void _editParticipant(
      BuildContext context, int index, Participant participant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddParticipantScreen(
          participant: participant,
          participantIndex: index,
          onSubmit: () {
            Navigator.pop(context); // Return to the list after editing
          },
        ),
      ),
    );
  }

  void _deleteParticipant(BuildContext context, int index) {
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