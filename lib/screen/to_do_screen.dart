import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class ToDoScrean extends StatefulWidget {
  const ToDoScrean({super.key});

  @override
  State<ToDoScrean> createState() => _ToDoScreanState();
}

class _ToDoScreanState extends State<ToDoScrean> {
  List<TaskModel> todoTasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("tasks");

    if (data != null) {
      List decoded = jsonDecode(data);

      List<TaskModel> allTasks =
      decoded.map((e) => TaskModel.fromMap(e)).toList();

      setState(() {
        todoTasks =
            allTasks.where((task) => !task.isCompleted).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text("To Do Tasks"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: todoTasks.isEmpty
            ? const Center(
          child: Text("No tasks yet",
              style: TextStyle(color: Colors.grey)),
        )
            : ListView.builder(
          itemCount: todoTasks.length,
          itemBuilder: (context, index) {
            final task = todoTasks[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.grey,
                ),
                title: Text(
                  task.taskname,
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .color,
                  ),
                ),
                subtitle: Text(
                  task.taskDesc,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}