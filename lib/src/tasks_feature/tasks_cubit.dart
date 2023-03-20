import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/src/tasks_feature/task_item_model.dart';

class TaskCubit extends Cubit<List<TaskItemModel>> {
  TaskCubit()
      : super([
          TaskItemModel(name: 'Compras semanales', createdDate: DateTime.now()),
          TaskItemModel(name: 'Limpieza semanal', createdDate: DateTime.now()),
          TaskItemModel(
              name: 'Salir con mi novia', createdDate: DateTime.now()),
          TaskItemModel(name: 'Estudiar', createdDate: DateTime.now()),
          TaskItemModel(name: 'Ir a la oficina', createdDate: DateTime.now())
        ]);

  void addTask(TaskItemModel item) {
    emit([...state, item]);
  }

  void editTask(TaskItemModel item, TaskItemModel newItem) {
    final index = state.indexOf(item);
    state[index] = newItem;
    emit([...state]);
  }

  void deleteTask(TaskItemModel item) {
    final newState = state.where((element) => element != item);
    emit([...newState]);
  }
}
