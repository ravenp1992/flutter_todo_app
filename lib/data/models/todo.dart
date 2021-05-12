class Todo {
  String title;
  bool completed;
  int id;

  Todo.fromJson(Map jsonData)
      : id = jsonData["id"] as int,
        title = jsonData["title"],
        completed = jsonData["completed"] == "true";
}
