// lib/services/participant_service.dart
// import 'package:race_app/models/participant.dart';

import '../models/item_model.dart';

class ParticipantService {
  // Mock data - in a real app, this would interact with an API or local database
  final List<Participant> _participants = [
    Participant(bib: '104', name: 'Emak', age: 25),
    Participant(bib: '106', name: 'Leanghav', age: 30),
    Participant(bib: '12', name: 'Punloue', age: 45),
    Participant(bib: '14', name: 'Sok', age: 45),
    Participant(bib: '18', name: 'China', age: 45),
    Participant(bib: '20', name: 'Mina', age: 45),
  ];

  Future<List<Participant>> fetchParticipants() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _participants;
  }

  Future<void> addParticipant(Participant participant) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _participants.add(participant);
  }

  Future<void> updateParticipant(int index, Participant participant) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _participants[index] = participant;
  }

  Future<void> deleteParticipant(int index) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _participants.removeAt(index);
  }
}
