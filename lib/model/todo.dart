class Todo {
  String? id;
  String? text;
  bool isDone;

  Todo({
    required this.id,
    required this.text,
    this.isDone = false,
  });

  static List<Todo> sampleList() {
    return [
      Todo(id: "01", text: "布団ちゃん", isDone: true),
      Todo(id: "02", text: "松本", isDone: true),
      Todo(id: "03", text: "匡生"),
      Todo(id: "04", text: "バカワキガ"),
      Todo(id: "05", text: "アゴマンゲ"),
      Todo(id: "06", text: "22377"),
      Todo(id: "07", text: "平等院ラクシュミ"),
    ];
  }
}
