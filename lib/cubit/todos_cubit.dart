import 'package:app_todo/data/models/todo.dart';
import 'package:app_todo/data/repositories/todo_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit({this.repository}) : super(TodosInitial());

  final TodoRepository repository;

  void fetchTodos() async {
    final todos = await repository.fetchTodos();

    emit(TodosLoaded(todos: todos));
  }

  void updateTodoCompletion(Todo todo) async {
    final updated = await repository.updateTodoCompletion(
        completed: !todo.completed, todoId: todo.id);

    if (updated) {
      todo.completed = !todo.completed;

      final currentState = state as TodosLoaded;

      emit(TodosLoaded(todos: currentState.todos));
    }
  }

  void addTodo({Todo todo}) {
    final currentState = state as TodosLoaded;
    final todoList = currentState.todos;

    todoList.add(todo);

    emit(TodosLoaded(todos: todoList));
  }

  void updateTodoTitle({Todo todo}) {
    final currentState = state as TodosLoaded;
    emit(TodosLoaded(todos: currentState.todos));
  }

  void deleteTodo({Todo todo}) {
    final currentState = state as TodosLoaded;

    final updatedTodo =
        currentState.todos.where((element) => element.id != todo.id).toList();

    emit(TodosLoaded(todos: updatedTodo));
  }
}
