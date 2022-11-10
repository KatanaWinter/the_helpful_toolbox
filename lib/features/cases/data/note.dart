import 'package:the_helpful_toolbox/features/cases/data/case.dart';

class Note {
  int id;
  Case noteCase;
  String text;
  String creator;
  DateTime? createdAt;

  Note({
    this.id = 1,
    required this.noteCase,
    this.text = "",
    this.creator = "",
  });
}
