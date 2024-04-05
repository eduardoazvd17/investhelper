// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateGoalModel {
  final String userId;
  final String description;
  final DateTime creationDate;

  CreateGoalModel({
    required this.userId,
    required this.description,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'description': description,
      'creationDate': creationDate.millisecondsSinceEpoch,
    };
  }

  factory CreateGoalModel.fromMap(Map<String, dynamic> map) {
    return CreateGoalModel(
      userId: map['userId'] as String,
      description: map['description'] as String,
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateGoalModel.fromJson(String source) =>
      CreateGoalModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
