// import 'package:race_app/models/participant.dart';
// import 'package:race_app/services/participant_service.dart';

import '../models/item_model.dart';
import '../services/json_service.dart';

class ParticipantRepository {
  final ParticipantService _service = ParticipantService();

  Future<List<Participant>> getParticipants() async {
    // Currently using mock data from service
    return await _service.fetchParticipants();
  }

  Future<void> addParticipant(Participant participant) async {
    await _service.addParticipant(participant);
  }

  Future<void> updateParticipant(int index, Participant participant) async {
    await _service.updateParticipant(index, participant);
  }

  Future<void> deleteParticipant(int index) async {
    await _service.deleteParticipant(index);
  }
}