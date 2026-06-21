class TaskModel {
  String taskname;
  String taskDesc;
  bool isCompleted;

  TaskModel({
    required this.taskname,
    required this.taskDesc,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "taskname": taskname,
      "taskDesc": taskDesc,
      "isCompleted": isCompleted,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskname: map["taskname"] ?? "",
      taskDesc: map["taskDesc"] ?? "",
      isCompleted: map["isCompleted"] ?? false,
    );
  }
}