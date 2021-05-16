import 'dart:convert';

import 'package:http/http.dart' as http;

class TodoService {
  final baseApiUrl = 'http://10.0.2.2:3000'; // android
  // final baseApiUrl = 'http://localhost:3000'; // ios

  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse('$baseApiUrl/todos'));
      // print(response.body);
      return jsonDecode(response.body) as List;
    } catch (e) {
      print(e);
      throw Exception('Unable to fetch todos');
    }
  }

  Future<bool> updateTodoCompletion(
      {Map<String, String> payload, int todoId}) async {
    print('data: ' + jsonEncode(payload));
    // print(payload);
    try {
      await http.patch(
        Uri.parse('$baseApiUrl/todos/$todoId'),
        body: payload,
      );

      return true;
    } catch (e) {
      throw Exception('Unable to update todo');
    }
  }

  Future<Map> addTodo({Map<String, String> payload}) async {
    try {
      final response =
          await http.post(Uri.parse('$baseApiUrl/todos'), body: payload);

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Unable to add todo');
    }
  }

  Future<Map> updateTodoTitle({Map<String, String> payload, int todoId}) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseApiUrl/todos/$todoId'),
        body: payload,
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Unable to update todo');
    }
  }

  Future<bool> deleteTodo({int todoId}) async {
    try {
      await http.delete(Uri.parse('$baseApiUrl/todos/$todoId'));
      return true;
    } catch (e) {
      throw Exception('Unable to update todo');
    }
  }
}
