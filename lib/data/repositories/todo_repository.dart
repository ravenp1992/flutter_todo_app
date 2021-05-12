import 'package:app_todo/data/models/todo.dart';
import 'package:app_todo/data/services/todo_service.dart';

class TodoRepository {
  TodoRepository({this.service});

  final TodoService service;

  Future<List<Todo>> fetchTodos() async {
    // simulate slow network
    await Future.delayed(Duration(seconds: 2));

    final todosRaw = await service.fetchTodos();
    return todosRaw.map((e) => Todo.fromJson(e)).toList();
  }

  Future<bool> updateTodoCompletion({completed: bool, todoId: int}) async {
    final payload = {'completed': completed.toString()};
    return await service.updateTodoCompletion(payload: payload, todoId: todoId);
  }

  Future<Todo> addTodo({String title}) async {
    // simulate slow network
    await Future.delayed(Duration(seconds: 2));

    final payload = {"title": title, "completed": "false"};
    final todoMap = await service.addTodo(payload: payload);
    return Todo.fromJson(todoMap);
  }

  Future<Todo> updateTodoTitle({String title, int todoId}) async {
    // simulate slow network
    await Future.delayed(Duration(seconds: 2));

    final payload = {'title': title};
    final todoMap =
        await service.updateTodoTitle(payload: payload, todoId: todoId);
    return Todo.fromJson(todoMap);
  }

  Future<bool> deleteTodo({int id}) async {
    // simulate slow network
    return await service.deleteTodo(todoId: id);
  }
}
