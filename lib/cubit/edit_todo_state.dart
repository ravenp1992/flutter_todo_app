part of 'edit_todo_cubit.dart';

@immutable
abstract class EditTodoState {}

class EditTodoInitial extends EditTodoState {}

class EditTodoFailed extends EditTodoState {
  EditTodoFailed({this.message});

  final String message;
}

class EditTodoInProgress extends EditTodoState {}

class EditTodoSuccess extends EditTodoState {}
