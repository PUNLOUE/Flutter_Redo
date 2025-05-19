// lib/models/participant.dart
class Participant {
  String bib;
  String name;
  int age;

  Participant({required this.bib, required this.name, required this.age});

  // Convert Participant to Map
  Map<String, dynamic> toMap() {
    return {
      'bib': bib,
      'name': name,
      'age': age,
    };
  }

  // Create Participant from Map
  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      bib: map['bib'],
      name: map['name'],
      age: map['age'],
    );
  }
}