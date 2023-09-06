import 'package:flutter/material.dart';
import 'package:projeto_final/create_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tasks"),
          backgroundColor: Colors.green,
        ),
        body: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Dismissible(
                      key: Key(task.id.toString()),
                      onDismissed: (direction) {
                        setState(() {
                          tasks.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${task.name} removido!')),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16.0),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 100, 8),
                          borderRadius: BorderRadius.circular(19.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: CheckboxListTile(
                          activeColor: Colors.green,
                          value: task.isCompleted,
                          onChanged: (value) {
                            setState(() {
                              task.isCompleted = value!;
                            });
                          },
                          title: Text(
                            task.name,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
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
          onPressed: () async {
            final createdTask = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CreateTask(tasks: tasks.map((t) => t.name).toList()),
              ),
            );
            if (createdTask != null) {
              setState(() {
                tasks.add(Task(
                    id: tasks.length + 1,
                    name: createdTask,
                    isCompleted: false));
              });
            }
          },
          child: const Icon(
            Icons.add,
          ),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}

class Task {
  final int id;
  final String name;
  bool isCompleted;

  Task({
    required this.id,
    required this.name,
    this.isCompleted = false,
  });
}
