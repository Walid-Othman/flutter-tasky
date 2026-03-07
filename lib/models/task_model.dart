class TaskModel {
  //Constractor
  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.ispriorty,
    this.isComplet = false,
    this.taskId,
  });
  //varibales
  String taskName;
  String taskDescription;
  bool ispriorty;
  bool isComplet;
  int? taskId;

  //Factory

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['id'],
      taskName: json["title"] ?? "",
      taskDescription: json["description"] ?? "",
      ispriorty:json['is_high_priority'] == 1 || json['is_high_priority'] == true,
      isComplet: json['is_done'] == 1 || json['is_done'] == true,
    );
  }

  //To Map
  Map<String, dynamic> toMap() {
    return {
      if (taskId != null) "id": taskId,
      "title": taskName,
      "description": taskDescription,
      "is_high_priority": ispriorty ? 1 : 0,
      "is_done": isComplet ? 1 : 0,
    };
  }
}
