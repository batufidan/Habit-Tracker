import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/models/task_model.dart';
import 'package:habit_tracker/widgets/my_list_tile.dart';
import 'package:hive_flutter/adapters.dart';

import 'screens/task_editor.dart';

late Box box;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("tasks");
  box.add(Task(
      title: 'this is the first Task',
      note: 'this is the first task made with the app',
      creation_date: DateTime.now()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'My Habit App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>('tasks').listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Task",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  formatDate(DateTime.now(), [d, ",", M, "", yyyy]),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18,
                  ),
                ),
                Divider(
                  height: 40,
                  thickness: 1,
                ),
                Expanded(child: ListView.builder(itemBuilder: (context, index) {
                  Task currentTask = box.getAt(index)!;
                  return MyListTile(currentTask, index);
                }))
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TaskEditor()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
