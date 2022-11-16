import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habit_tracker/screens/task_editor.dart';

import '../models/task_model.dart';

class MyListTile extends StatefulWidget {
  MyListTile(this.task, this.index, {super.key});
  Task task;
  int index;

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.task.title!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskEditor(
                        task: widget.task,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black87,
            height: 20,
            thickness: 1,
          ),
          Text(
            widget.task.note!,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
