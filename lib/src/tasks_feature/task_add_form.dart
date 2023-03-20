import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/src/tasks_feature/task_item_model.dart';
import 'package:task_list/src/tasks_feature/tasks_cubit.dart';

class TaskAddForm extends StatefulWidget {
  static const routeName = '/task-add';
  final TaskItemModel? taskToEdit;
  const TaskAddForm({super.key, this.taskToEdit});

  @override
  State<TaskAddForm> createState() => _TaskAddFormState();
}

class _TaskAddFormState extends State<TaskAddForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (newValue) => name = newValue ?? '',
                  decoration:
                      const InputDecoration(hintText: 'Enter name of task'),
                  initialValue: widget.taskToEdit?.name,
                ),
                if (widget.taskToEdit != null)
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                          'Created at: ${widget.taskToEdit!.createdDate.day}/${widget.taskToEdit!.createdDate.month}/${widget.taskToEdit!.createdDate.year} at ${widget.taskToEdit!.createdDate.hour}:${widget.taskToEdit!.createdDate.minute}')),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.save();
                        if (widget.taskToEdit != null) {
                          BlocProvider.of<TaskCubit>(context).editTask(
                              widget.taskToEdit!,
                              TaskItemModel(
                                  name: name,
                                  createdDate: widget.taskToEdit!.createdDate));
                        } else {
                          BlocProvider.of<TaskCubit>(context).addTask(
                              TaskItemModel(
                                  name: name, createdDate: DateTime.now()));
                        }

                        Navigator.pop(context);
                      },
                      child: const Text('Submit')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
