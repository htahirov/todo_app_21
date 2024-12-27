class TodoModel {
  String id;
  String title;
  String description;
  bool isChecked;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    this.isChecked = false,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isChecked: json["isChecked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isChecked": isChecked,
      };
}
