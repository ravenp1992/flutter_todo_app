import 'package:app_todo/cubit/edit_todo_cubit.dart';
import 'package:app_todo/data/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;
  final TextEditingController _titleController = TextEditingController();

  EditTodoScreen({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _titleController.text = todo.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Toto'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final answer = await _deleteDialog(context);
              if (answer) {
                BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo: todo);
              }
            },
          ),
        ],
      ),
      body: BlocListener<EditTodoCubit, EditTodoState>(
        listener: (context, state) {
          if (state is EditTodoFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is EditTodoSuccess) {
            Navigator.of(context).pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _body(context),
        ),
      ),
    );
  }

  Future<bool> _deleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Delete todo: ${todo.title}'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _body(context) {
    return Column(
      children: [
        TextField(
          autocorrect: true,
          autofocus: true,
          controller: _titleController,
        ),
        SizedBox(
          height: 15.0,
        ),
        _updateButton(context),
      ],
    );
  }

  Widget _updateButton(context) {
    return BlocBuilder<EditTodoCubit, EditTodoState>(
      builder: (context, state) {
        if (state is EditTodoInProgress) {
          return CircularProgressIndicator();
        }
        return Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<EditTodoCubit>(context)
                  .editTodo(todo: todo, title: _titleController.text);
            },
            child: Text('Update Todo'),
          ),
        );
      },
    );
  }

  // Widget _form(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(12.0),
  //     child: Column(
  //       children: [
  //         TextField(
  //           autofocus: true,
  //           controller: _titleController,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
