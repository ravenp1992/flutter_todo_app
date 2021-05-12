import 'package:app_todo/cubit/todos_cubit.dart';
import 'package:app_todo/data/models/todo.dart';
import 'package:app_todo/data/repositories/todo_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  EditTodoCubit({this.repository, this.todosCubit}) : super(EditTodoInitial());

  TodoRepository repository;
  TodosCubit todosCubit;

  void editTodo({Todo todo, String title}) async {
    if (title.isEmpty) {
      emit(EditTodoFailed(message: 'Title must not be empty!'));
      return;
    }

    emit(EditTodoInProgress());
    final updatedTodo =
        await repository.updateTodoTitle(title: title, todoId: todo.id);

    todo.title = updatedTodo.title;

    todosCubit.updateTodoTitle(todo: todo);

    emit(EditTodoSuccess());
  }

  void deleteTodo({Todo todo}) async {
    final deleted = await repository.deleteTodo(id: todo.id);

    if (deleted) {
      todosCubit.deleteTodo(todo: todo);

      emit(EditTodoSuccess());
    }
  }
}
