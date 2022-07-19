import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(title: "flutter todo", home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskListsPage();
  }
}

class IncompleteTasksPage extends StatefulWidget {
  const IncompleteTasksPage({super.key, required this.tasks});

  final tasks;

  @override
  State<IncompleteTasksPage> createState() => _IncompleteTasksPageState();
}

class _IncompleteTasksPageState extends State<IncompleteTasksPage> {
  final _tasks = <String>[]; // TODO: Currently obsolete because of widget.tasks
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
        child: _tasks.isEmpty && widget.tasks.isEmpty
            ? const Text("You have completed all your tasks!")
            : ListView(padding: const EdgeInsets.all(16.0), children: [
                for (int i = 0; i < widget.tasks.length * 2; i++)
                  (i % 2 != 0)
                      ? Divider()
                      : ListTile(
                          title: Text(
                            widget.tasks[i ~/ 2],
                            style: _biggerFont,
                          ),
                          trailing: const Icon(
                            Icons.check,
                            color: Colors.green,
                            semanticLabel: 'Task done',
                          ),
                          onTap: () {
                            setState(() {
                              _completedTasks.add(widget.tasks[i ~/ 2]);
                              widget.tasks.remove(widget.tasks[i ~/ 2]);
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
                          widget.tasks.add(text);
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

class TaskListsPage extends StatefulWidget {
  const TaskListsPage({super.key});

  @override
  State<TaskListsPage> createState() => _TaskListsPageState();
}

class _TaskListsPageState extends State<TaskListsPage> {
  final _taskLists = {};

  final TextEditingController taskListAddController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks ToDo'),
      ),
      body: Center(
        child: _taskLists.isEmpty
            ? const Text("Press the button to create a new task list!")
            : ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  for (final key in _taskLists.keys)
                    ListTile(
                        title: Text(key),
                        trailing: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          semanticLabel: 'delete the list',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  IncompleteTasksPage(tasks: _taskLists[key]),
                            ),
                          );
                        } //TODO: Create task page functionality,
                        )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Expanded(
                  child: SimpleDialog(
                    title: const Text("Add TaskList"),
                    children: <Widget>[
                      TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Task List name'),
                          controller: taskListAddController),
                      SimpleDialogOption(
                        onPressed: () {
                          setState(() {
                            final text = taskListAddController.text;
                            _taskLists[text] = <String>[];
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("Enter"),
                      ),
                    ],
                  ),
                );
              });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.list),
      ),
    );
  }
}
