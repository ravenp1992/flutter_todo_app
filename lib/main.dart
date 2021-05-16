import 'package:app_todo/presentations/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp(
    router: AppRouter(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key key, this.router}) : super(key: key);

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: router.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
