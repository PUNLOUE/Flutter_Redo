// lib/screens/add_participant_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item_model.dart';
import '../providers/item_provider.dart';
// import 'package:race_app/models/participant.dart';
// import 'package:race_app/providers/participant_provider.dart';

class AddParticipantScreen extends StatefulWidget {
  final Participant? participant;
  final int? participantIndex;
  final VoidCallback onSubmit;

  const AddParticipantScreen({
    Key? key,
    this.participant,
    this.participantIndex,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AddParticipantScreen> createState() => _AddParticipantScreenState();
}

class _AddParticipantScreenState extends State<AddParticipantScreen> {
  late TextEditingController _bibController;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.participant != null;
    _bibController = TextEditingController(text: widget.participant?.bib ?? '');
    _nameController = TextEditingController(text: widget.participant?.name ?? '');
    _ageController = TextEditingController(
        text: widget.participant?.age.toString() ?? '');
  }

  @override
  void dispose() {
    _bibController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BIB',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          _buildTextField(_bibController, 'Enter BIB number'),
          
          const SizedBox(height: 24),
          const Text(
            'Name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          _buildTextField(_nameController, 'Enter name'),
          
          const SizedBox(height: 24),
          const Text(
            'Age',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          _buildTextField(_ageController, 'Enter age', keyboardType: TextInputType.number),
          
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _saveParticipant,
              child: Text(_isEditing ? 'Update' : 'Save'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF5E5CE6)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  void _saveParticipant() {
    // Validate inputs
    if (_bibController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final age = int.tryParse(_ageController.text);
    if (age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid age')),
      );
      return;
    }

    // Create new participant object
    final participant = Participant(
      bib: _bibController.text,
      name: _nameController.text,
      age: age,
    );

    final participantProvider = Provider.of<ParticipantProvider>(context, listen: false);
    
    if (_isEditing && widget.participantIndex != null) {
      // Update existing participant
      participantProvider.updateParticipant(widget.participantIndex!, participant);
    } else {
      // Add new participant
      participantProvider.addParticipant(participant);
    }

    // Call the callback to navigate back or refresh the list
    widget.onSubmit();
  }
}
