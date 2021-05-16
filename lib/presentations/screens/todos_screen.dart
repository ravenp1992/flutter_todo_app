import 'package:app_todo/cubit/todos_cubit.dart';
import 'package:app_todo/data/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        centerTitle: false,
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (!(state is TodosLoaded)) {
            return Center(child: CircularProgressIndicator());
          }

          final todos = (state as TodosLoaded).todos;

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, idx) {
              return _todoItem(context, todos[idx]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add_todo");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomAppBar(),
    );
  }

  Widget _todoItem(BuildContext context, Todo todo) {
    return Dismissible(
      key: Key('${todo.id}'),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          enabled: !todo.completed,
          onTap: () =>
              Navigator.of(context).pushNamed("/edit_todo", arguments: todo),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.completed ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: todo.completed
              ? Icon(
                  Icons.check,
                  color: todo.completed ? Colors.green : Colors.grey,
                )
              : null,
        ),
      ),
      background: Container(
        color: Colors.green,
      ),
      confirmDismiss: (_) async {
        BlocProvider.of<TodosCubit>(context).updateTodoCompletion(todo);
        return false;
      },
    );
  }

  Widget _bottomAppBar() {
    return BottomAppBar(
      // color: Colors.blue[400],
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.settings,
              // color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              // color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
