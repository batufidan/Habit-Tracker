import 'package:flutter/material.dart';
import 'package:habit_tracker/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task_model.dart';

class TaskEditor extends StatefulWidget {
  TaskEditor({this.task, super.key});

  Task? task;

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _taskTitle = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!);
    TextEditingController _taskNote = TextEditingController(
        text: widget.task == null ? null : widget.task!.note!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.task == null ? "Add a new Task" : "Update your Task",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Task's Title",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: _taskNote,
              decoration: InputDecoration(
                  fillColor: Colors.blue.shade100.withAlpha(75),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Your Task'),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Your Task's Note",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 25,
              controller: _taskTitle,
              decoration: InputDecoration(
                  fillColor: Colors.blue.shade100.withAlpha(75),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Write some Notes'),
            ),
            Expanded(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 60,
                child: RawMaterialButton(
                  onPressed: () async {
                    var newTask = Task(
                      title: _taskTitle.text,
                      note: _taskNote.text,
                      creation_date: DateTime.now(),
                      done: false,
                    );
                    Box<Task> taskbox = Hive.box<Task>("tasks");
                    if (widget.task != null) {
                      widget.task!.title = newTask.title;
                      widget.task!.note = newTask.note;

                      widget.task!.save();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      await taskbox.add(newTask);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                  fillColor: Colors.blueAccent.shade700,
                  child: Text(
                    widget.task == null ? "Add new Task" : "Update Task",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
