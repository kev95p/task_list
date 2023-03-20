import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/src/tasks_feature/task_add_form.dart';
import 'package:task_list/src/tasks_feature/task_detail.dart';
import 'package:task_list/src/tasks_feature/task_item_model.dart';
import 'package:task_list/src/tasks_feature/tasks_cubit.dart';

class EditModeAppBar extends StatelessWidget {
  final Function callback;
  const EditModeAppBar({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Tap a task to edit'),
      actions: [
        IconButton(onPressed: () => callback(), icon: const Icon(Icons.close)),
      ],
    );
  }
}

class TaskListAppBar extends StatelessWidget {
  final Function callback;
  const TaskListAppBar({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Task List'),
      actions: [
        IconButton(onPressed: () => callback(), icon: const Icon(Icons.edit)),
        IconButton(
            onPressed: () {
              Navigator.restorablePushNamed(context, TaskAddForm.routeName);
            },
            icon: const Icon(Icons.add))
      ],
    );
  }
}

class TaskListView extends StatefulWidget {
  static const routeName = '/tasks';
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  var editMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: editMode
              ? EditModeAppBar(callback: () {
                  toogleEditMode();
                })
              : TaskListAppBar(callback: () {
                  toogleEditMode();
                })),
      body: BlocBuilder<TaskCubit, List<TaskItemModel>>(
          builder: (context, state) {
        return ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            final item = state[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(
                  'Created at: ${item.createdDate.day}/${item.createdDate.month}/${item.createdDate.year} at ${item.createdDate.hour}:${item.createdDate.minute}'),
              trailing: editMode
                  ? const Icon(Icons.edit)
                  : const Icon(Icons.chevron_right),
              onTap: () {
                //mostrar detalle
                if (editMode) {
                  Navigator.of(context)
                      .pushNamed(TaskAddForm.routeName, arguments: item);
                } else {
                  Navigator.of(context)
                      .pushNamed(TaskDetail.routeName, arguments: item);
                }
              },
              onLongPress: () => _dialogBuilder(context, item),
            );
          },
        );
      }),
    );
  }

  void toogleEditMode() {
    editMode = !editMode;
    setState(() {});
  }

  Future<void> _dialogBuilder(BuildContext ctx, TaskItemModel item) {
    return showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            //title: const Text('Are you sure to delete this task'),
            content: const Text('Are you sure to delete this task'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<TaskCubit>(context).deleteTask(item);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }
}
