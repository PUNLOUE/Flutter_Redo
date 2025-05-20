 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item_model.dart';
import '../providers/item_provider.dart';

class RaceStartScreen extends StatefulWidget {
  const RaceStartScreen({Key? key}) : super(key: key);

  @override
  State<RaceStartScreen> createState() => _RaceStartScreenState();
}

class _RaceStartScreenState extends State<RaceStartScreen> {
  bool isStarted = false;
  int selectedSegment = 0; // Default: 'Swim' selected
  int? selectedBibIndex; // To track the selected BIB index
  final Duration mockMainTime = const Duration(seconds: 0); // Mock main timer
  final Map<String, Duration> participantTimes = {}; // Track finish times
  final Map<String, Duration> participantStartTimes = {
    // Mock start times (optional, can be removed if not needed)
    '104': const Duration(seconds: 0),
  }; // Track start times for active participants

  @override
  void initState() {
    super.initState();
  }

  void selectParticipant(String bib, int index) {
    setState(() {
      selectedBibIndex = index;
    });
  }

  void untrackParticipant() {
    setState(() {
      selectedBibIndex = null;
    });
  }

  void finishParticipant(String bib) {
    if (isStarted && selectedBibIndex != null) {
      setState(() {
        final startTime = participantStartTimes[bib] ?? const Duration(seconds: 0);
        participantTimes[bib] = const Duration(seconds: 1); // Mock finish time
        participantStartTimes.remove(bib); // Clear start time
        selectedBibIndex = null; // Deselect after finishing
      });
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    final participants = participantProvider.participants;
    final List<String> segments = ['Swim', 'Run', 'Cycle'];

    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isStarted = !isStarted;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5E5CE6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                isStarted ? '00:00:00' : 'Start', // Static mock time
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // Segment Tabs
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(segments.length, (index) {
              final isSelected = index == selectedSegment;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSegment = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected
                              ? const Color(0xFF5E5CE6)
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        segments[index],
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF5E5CE6)
                              : Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        // Status Label
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              isStarted && selectedBibIndex != null
                  ? 'In Progress'
                  : (isStarted ? 'Started' : 'Not Start'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ),
        ),
        // Participant Grid
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 1.0,
              ),
              itemCount: participants.length,
              itemBuilder: (context, index) {
                final participant = participants[index];
                final isSelected = selectedBibIndex == index;
                final hasFinished = participantTimes.containsKey(participant.bib);
                final startTime = participantStartTimes[participant.bib] ?? const Duration(seconds: 0);
                final elapsedTime = isSelected ? const Duration(seconds: 1) : const Duration(seconds: 0); // Mock elapsed time

                return GestureDetector(
                  onTap: hasFinished
                      ? null
                      : () => selectParticipant(participant.bib, index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF5E5CE6)
                          : (hasFinished ? Colors.grey.shade300 : Colors.white),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BID ${participant.bib}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: isSelected || hasFinished
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        if (isSelected && isStarted)
                          Text(
                            formatDuration(elapsedTime), // Mock "00:00:01"
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.yellow,
                            ),
                          ),
                        if (hasFinished)
                          Text(
                            formatDuration(participantTimes[participant.bib]!),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Action Buttons (Untrack and Finish)
        if (selectedBibIndex != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Action',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: untrackParticipant,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF5E5CE6),
                          side: const BorderSide(color: Color(0xFF5E5CE6)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(0, 50),
                        ),
                        child: const Text('Untrack'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final bib = participants[selectedBibIndex!].bib;
                          finishParticipant(bib);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5E5CE6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(0, 50),
                        ),
                        child: const Text('Finish'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}