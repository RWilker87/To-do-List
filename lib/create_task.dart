import 'package:flutter/material.dart';

class CreateTask extends StatefulWidget {
  final List<String> tasks;

  const CreateTask({Key? key, required this.tasks}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController _taskController = TextEditingController();
  String createdTask = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Create Task"),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    hintText: 'Enter task name',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final enteredText = _taskController.text;
                  if (enteredText.isNotEmpty) {
                    setState(() {
                      createdTask = enteredText;
                    });
                    Navigator.pop(context, createdTask);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Empty Task'),
                          content: const Text('Please enter a task name.'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text("Create Task"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
