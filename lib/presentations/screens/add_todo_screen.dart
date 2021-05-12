import 'package:app_todo/cubit/add_todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is TodoAdded) {
            Navigator.of(context).pop();
          } else if (state is AddTodoFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: _form(context),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _titleController,
          decoration: InputDecoration(hintText: 'Enter Todo'),
        ),
        SizedBox(
          height: 15.0,
        ),
        _addButton(context),
      ],
    );
  }

  Widget _addButton(BuildContext context) {
    return BlocBuilder<AddTodoCubit, AddTodoState>(
      builder: (context, state) {
        if (state is AddingTodo) {
          return CircularProgressIndicator();
        }

        return Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              final title = _titleController.text;

              BlocProvider.of<AddTodoCubit>(context).addTodo(title: title);
            },
            child: Text('Add Todo'),
          ),
        );
      },
    );
  }
}
