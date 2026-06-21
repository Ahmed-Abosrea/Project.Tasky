import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import 'package:projecttask1/wedget/custom_text_form_field.dart';

import '../widget/custom_text_form_field.dart';

class AddTaskScrean extends StatefulWidget {
  const AddTaskScrean({super.key});

  @override
  State<AddTaskScrean> createState() => _AddTaskScreanState();
}

class _AddTaskScreanState extends State<AddTaskScrean> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> saveTask() async {
    final prefs = await SharedPreferences.getInstance();

    final model = TaskModel(
      taskname: nameController.text,
      taskDesc: descController.text,
    );

    String? data = prefs.getString("tasks");
    List list = data != null ? jsonDecode(data) : [];

    list.add(model.toMap());

    await prefs.setString("tasks", jsonEncode(list));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text("New Task"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [

              CustomTextFormField(
                Controller: nameController,
                title: "Task Name",
                hint: "Enter task name",
                maxLines: 1,
                validator: (v) =>
                (v == null || v.isEmpty) ? "Enter name" : null,
              ),

              const SizedBox(height: 20),

              CustomTextFormField(
                Controller: descController,
                title: "Description",
                hint: "Enter description",
                maxLines: 5,
                validator: (v) =>
                (v == null || v.isEmpty) ? "Enter desc" : null,
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await saveTask();
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff15B86C),
                  ),
                  child: const Text("Add Task"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}