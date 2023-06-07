class Task {
  final String taskId;
  final String taskName;
  final String taskDescription;
  final String taskTime;
  final String status;
  final String image;

  Task({
    required this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.taskTime,
    required this.status,
    required this.image,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'],
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      taskTime: json['taskTime'],
      status: json['status'],
      image: json['image'],
    );
  }
}