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
}
