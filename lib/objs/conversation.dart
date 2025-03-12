// ignore_for_file: non_constant_identifier_names

class Conversation {
  DateTime created_at;
  String question;
  String answer;

  Conversation({
    required this.created_at,
    required this.question,
    required this.answer,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    created_at: DateTime.parse(json["created_at"]),
    question: json["question"],
    answer: json["answer"],
  );
  Map<String, dynamic> toJson() => {
    "created_at": created_at.toIso8601String(),
    "question": question,
    "answer": answer,
  };
}
