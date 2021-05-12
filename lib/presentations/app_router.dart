import 'package:app_todo/cubit/add_todo_cubit.dart';
import 'package:app_todo/cubit/edit_todo_cubit.dart';
import 'package:app_todo/cubit/todos_cubit.dart';
import 'package:app_todo/data/models/todo.dart';
import 'package:app_todo/data/repositories/todo_repository.dart';
import 'package:app_todo/data/services/todo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/add_todo_screen.dart';
import 'screens/edit_todo_screen.dart';
import 'screens/todos_screen.dart';

class AppRouter {
  TodoRepository repository;
  TodosCubit todosCubit;

  AppRouter() {
    repository = TodoRepository(service: TodoService());
    todosCubit = TodosCubit(repository: repository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: todosCubit,
            child: TodosScreen(),
          ),
        );
      case "/edit_todo":
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => EditTodoCubit(
              repository: repository,
              todosCubit: todosCubit,
            ),
            child: EditTodoScreen(todo: todo),
          ),
        );
      case "/add_todo":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AddTodoCubit(
              repository: repository,
              todosCubit: todosCubit,
            ),
            child: AddTodoScreen(),
          ),
        );
      default:
        throw Exception('Undefinded Route');
    }
  }
}
