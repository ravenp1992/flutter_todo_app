import 'package:app_todo/cubit/todos_cubit.dart';
import 'package:app_todo/data/repositories/todo_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit({this.repository, this.todosCubit}) : super(AddTodoInitial());

  final TodoRepository repository;
  final TodosCubit todosCubit;

  void addTodo({String title}) async {
    if (title.isEmpty) {
      emit(AddTodoFailed(message: 'Todo title is required'));
      return;
    }

    emit(AddingTodo());

    final todo = await repository.addTodo(title: title);

    todosCubit.addTodo(todo: todo);

    emit(TodoAdded());
  }
}
