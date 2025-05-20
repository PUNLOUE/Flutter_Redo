import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../repositories/item_repository.dart';

class ParticipantProvider with ChangeNotifier {
  final ParticipantRepository _repository = ParticipantRepository();
  List<Participant> _participants = [];

  ParticipantProvider() {
    // Initialize with sample data from repository
    _loadParticipants();
  }

  List<Participant> get participants => _participants;

  Future<void> _loadParticipants() async {
    _participants = await _repository.getParticipants();
    notifyListeners();
  }

  Future<void> addParticipant(Participant participant) async {
    await _repository.addParticipant(participant);
    await _loadParticipants();
  }

  Future<void> updateParticipant(int index, Participant participant) async {
    await _repository.updateParticipant(index, participant);
    await _loadParticipants();
  }

  Future<void> deleteParticipant(int index) async {
    await _repository.deleteParticipant(index);
    await _loadParticipants();
  }
}