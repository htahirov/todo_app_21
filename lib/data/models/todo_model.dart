class TodoModel {
  TodoModel({
    required this.title,
    required this.description,
    this.isChecked = false,
  });

  String title;
  String description;
  bool isChecked;

  static final List<TodoModel> todos = [];
}
