import 'package:flutter/material.dart';

class RaceResultScreen extends StatefulWidget {
  const RaceResultScreen({Key? key}) : super(key: key);

  @override
  State<RaceResultScreen> createState() => _RaceResultScreenState();
}

class _RaceResultScreenState extends State<RaceResultScreen> {
  int selectedSegment = 0;
  final List<String> segments = ['Final', 'Swim', 'Run', 'Cycle'];

  @override
  Widget build(BuildContext context) {
    // Example static data for UI
    final List<Map<String, String>> results = [
      {'rank': '1', 'bib': '104', 'name': 'Alice', 'time': '12:12'},
      {'rank': '2', 'bib': '106', 'name': 'Bob', 'time': '12:15'},
      {'rank': '3', 'bib': '12', 'name': 'Charlie', 'time': '12:20'},
    ];


    return Column(
      children: [
        // Segment Tabs (like RaceStartScreen)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
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
        // Result Label
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Result',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // Result Table
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              columnWidths: const {
                0: FlexColumnWidth(1), // Rank
                1: FlexColumnWidth(1), // Bib
                2: FlexColumnWidth(2), // Name
                3: FlexColumnWidth(1), // Time
              },
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Color(0xFF5E5CE6)),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Rank', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('BIB', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Time', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                ...results.map((row) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(row['rank']!, style: const TextStyle(color: Colors.black)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(row['bib']!, style: const TextStyle(color: Colors.black)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(row['name']!, style: const TextStyle(color: Colors.black)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(row['time']!, style: const TextStyle(color: Colors.black)),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}