part of 'add_todo_cubit.dart';

@immutable
abstract class AddTodoState {}

class AddTodoInitial extends AddTodoState {}

class AddTodoFailed extends AddTodoState {
  AddTodoFailed({this.message});

  final String message;
}

class AddingTodo extends AddTodoState {}

class TodoAdded extends AddTodoState {}
