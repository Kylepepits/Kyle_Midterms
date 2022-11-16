import 'package:flutter/material.dart';
import 'ToDoList.dart';
import 'dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // lsit for to do tasks

  List toDoList = [
    ["Jogging", false],
    ["Walk", true],
    ["Run", false],
  ];
  //text controller
  final _controller = TextEditingController();

  // checkbox is clicked

  void checkChanged(bool? value, index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //to add a task
  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
    });
  }

  // new task
  void newTask() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialogs(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('TO DO APP'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newTask,
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoList(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkChanged(value, index),
            deleteToDo: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
