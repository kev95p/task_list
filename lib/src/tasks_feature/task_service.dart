import 'package:task_list/src/tasks_feature/task_item_model.dart';

class TaskService {
  static final List<TaskItemModel> taskData = [];

  Future<List<TaskItemModel>> getTasks() async {
    await Future.delayed(const Duration(seconds: 3));
    return taskData;
  }
}
