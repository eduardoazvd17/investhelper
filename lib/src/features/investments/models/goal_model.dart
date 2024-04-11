// ignore_for_file: public_member_api_docs, sort_constructors_first

class GoalModel {
  final String id;
  final String userId;
  final String description;
  final DateTime creationDate;

  GoalModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.creationDate,
  });

  GoalModel copyWith({
    String? description,
  }) {
    return GoalModel(
      id: id,
      userId: userId,
      description: description ?? this.description,
      creationDate: creationDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'description': description,
      'creationDate': creationDate.millisecondsSinceEpoch,
    };
  }

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      description: map['description'] as String,
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int),
    );
  }
}
