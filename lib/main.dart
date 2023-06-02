import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Androidのステータスバーのカラーを非表示にする
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => const HomePage(
              title: "TodoApp",
            ),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
