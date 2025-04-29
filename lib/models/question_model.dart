import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String id;
  final String title;
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
  });

  // Firestore verisini Question modeline dönüştürmek için fabrika yöntemi
  factory Question.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Question(
      id: doc.id,
      title: data['title'] as String,
      options: Map<String, bool>.from(data['options'] as Map),
    );
  }

  @override
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}
