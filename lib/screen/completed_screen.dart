import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class CompletedScrean extends StatefulWidget {
  const CompletedScrean({super.key});

  @override
  State<CompletedScrean> createState() => _CompletedScreanState();
}

class _CompletedScreanState extends State<CompletedScrean> {
  List<TaskModel> completedTasks = [];

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
        completedTasks =
            allTasks.where((task) => task.isCompleted).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text("Completed Tasks"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: completedTasks.isEmpty
            ? const Center(
          child: Text("No completed tasks",
              style: TextStyle(color: Colors.grey)),
        )
            : ListView.builder(
          itemCount: completedTasks.length,
          itemBuilder: (context, index) {
            final task = completedTasks[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.check_box,
                  color: Color(0xff15B86C),
                ),
                title: Text(
                  task.taskname,
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .color,
                    decoration: TextDecoration.lineThrough,
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