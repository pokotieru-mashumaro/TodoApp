import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_app/component/todo_item.dart';
import 'package:todo_app/constant/colors.dart';
import 'package:todo_app/model/todo.dart';

class Content extends HookWidget {
  final String title;

  Content({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final todoList = useState(Todo.sampleList());
    final _foundTodo = useState<List<Todo>>([]);
    final _todoController = useTextEditingController();
    final _isSearch = useState<bool>(false);

    void _handleTodoChange(Todo todo) {
      final updatedTodo = Todo(
        id: todo.id,
        text: todo.text,
        isDone: !todo.isDone,
      );
      _foundTodo.value = _foundTodo.value
          .map((item) => item == todo ? updatedTodo : item)
          .toList();
    }

    void _deleteTodoItem(String id) {
      todoList.value.removeWhere((item) => item.id == id);
      _foundTodo.value = [...todoList.value]; //これかかないと再描画されないっぽい
    }

    void _addTodoItem(String todoText) {
      todoList.value.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: todoText,
      ));
      _foundTodo.value = [...todoList.value]; //これかかないと再描画されないっぽい

      _todoController.clear();
    }

    void _runFilter(String enteredKeyword) {
      List<Todo> results = [];
      if (enteredKeyword.isEmpty) {
        results = todoList.value;
      } else {
        results = todoList.value
            .where((item) =>
                item.text!.toLowerCase().contains(enteredKeyword.toLowerCase()))
            .toList();
      }

      _foundTodo.value = results;

      if (enteredKeyword.isEmpty) {
        _isSearch.value = false;
      } else {
        _isSearch.value = true;
      }
    }

    useEffect(
      () {
        _foundTodo.value = todoList.value;
        debugPrint("データ入力");
        return null;
      },
      const [],
    );

    Widget searchBox() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "検索",
            hintStyle: TextStyle(color: tdGray),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 70),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          _isSearch.value ? "検索結果" : "すべてのTodo",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (Todo todo in _foundTodo.value.reversed)
                        Dismissible(
                          key: Key(todo.id!),
                          resizeDuration: Duration(milliseconds: 10),
                          behavior: HitTestBehavior.translucent,
                          onDismissed: (direction) {
                            _deleteTodoItem(todo.id!);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$todo を削除しました')));
                          },
                          child: TodoItem(
                            todo: todo,
                            onTodoChange: _handleTodoChange,
                            onDeleteItem: _deleteTodoItem,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  margin: EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: "Todoを追加する", border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _addTodoItem(_todoController.text);
                  },
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 40),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/images/avater.png"),
            ),
          )
        ],
      ),
    );
  }
}
