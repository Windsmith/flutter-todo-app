import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: "flutter todo", home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const IncompleteTasksPage();
  }
}

class IncompleteTasksPage extends StatefulWidget {
  const IncompleteTasksPage({super.key});

  @override
  State<IncompleteTasksPage> createState() => _IncompleteTasksPageState();
}

class _IncompleteTasksPageState extends State<IncompleteTasksPage> {
  final _tasks = <String>[];
  final _completedTasks = <String>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  final taskAddTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks ToDo'),
      ),
      body: Center(
        child: _tasks.isEmpty
            ? const Text("You have completed all your tasks!")
            : ListView(padding: const EdgeInsets.all(16.0), children: [
                for (int i = 0; i < _tasks.length * 2; i++)
                  (i % 2 != 0)
                      ? Divider()
                      : ListTile(
                          title: Text(
                            _tasks[i ~/ 2],
                            style: _biggerFont,
                          ),
                          trailing: const Icon(
                            Icons.check,
                            color: Colors.green,
                            semanticLabel: 'Task done',
                          ),
                          onTap: () {
                            setState(() {
                              _completedTasks.add(_tasks[i ~/ 2]);
                              _tasks.remove(_tasks[i ~/ 2]);
                            });
                          },
                        )
              ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Expanded(
                child: SimpleDialog(
                  title: const Text("Add Task"),
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Enter Task'),
                      controller: taskAddTextController,
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        setState(() {
                          final text = taskAddTextController.text;
                          _tasks.add(text);
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Enter"),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
