import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import 'AddTaskScreen.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({super.key});

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  String name = "User";
  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    name = prefs.getString("name") ?? "User";

    final data = prefs.getString("tasks");
    if (data != null) {
      final decoded = jsonDecode(data) as List;
      tasks = decoded.map((e) => TaskModel.fromMap(e)).toList();
    }

    setState(() {});
  }

  double get progress {
    if (tasks.isEmpty) return 0;
    final done = tasks.where((e) => e.isCompleted).length;
    return done / tasks.length;
  }

  Future<void> toggleTask(int index, bool value) async {
    final prefs = await SharedPreferences.getInstance();

    tasks[index].isCompleted = value;

    final updated = tasks.map((e) => e.toMap()).toList();
    await prefs.setString("tasks", jsonEncode(updated));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [
                Image.asset("assets/leading_element.png"),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello, $name",
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .color)),
                    const Text("One step closer",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: progress,
              color: const Color(0xff15B86C),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                  child: Text("No Tasks",
                      style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (_, i) {
                  final task = tasks[i];

                  return Card(
                    color: Theme.of(context).cardColor,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (v) =>
                            toggleTask(i, v ?? false),
                        activeColor: const Color(0xff15B86C),
                      ),
                      title: Text(
                        task.taskname,
                        style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: Text(
                        task.taskDesc,
                        style:
                        const TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff15B86C),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTaskScrean(),
            ),
          ).then((_) => loadData());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}