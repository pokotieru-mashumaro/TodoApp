import 'package:flutter/material.dart';
import 'package:todo_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData.from(
        colorScheme: const ColorScheme.dark(primary: Colors.green));
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
      darkTheme: darkTheme,
    );
  }
}
