import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:race_app/providers/participant_provider.dart';
// import 'package:race_app/screens/participant_list_screen.dart';

import 'providers/item_provider.dart';
import 'screens/participant_list_screen.dart';

void main() {
  runApp(const RaceApp());
}

class RaceApp extends StatelessWidget {
  const RaceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ParticipantProvider()),
      ],
      child: MaterialApp(
        title: 'Race App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF5E5CE6),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF5E5CE6),
            secondary: const Color(0xFF5E5CE6),
          ),
        ),
        home: const ParticipantListScreen(),
      ),
    );
  }
}