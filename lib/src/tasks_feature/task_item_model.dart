import 'package:equatable/equatable.dart';

class TaskItemModel extends Equatable {
  final String name;
  final DateTime createdDate;
  const TaskItemModel({required this.name, required this.createdDate});

  @override
  List<Object> get props => [name, createdDate];
}
