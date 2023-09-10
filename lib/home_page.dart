import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample/database/database.dart';
import 'package:sample/dialogue_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //hive reference
  final _mybox = Hive.box('mybox');
  TodoDataBase db = TodoDataBase();

  final _controller = TextEditingController();

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  //check box changed
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.upadeteDataBase();
  }
  //save new task

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.upadeteDataBase();
  }

  //create a new task
  void createANewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogueBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.upadeteDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: const Text('To Do'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createANewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoList(
            taskname: db.toDoList[index][0],
            taskcompleted: db.toDoList[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final String taskname;
  final bool taskcompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  TodoList({
    super.key,
    required this.taskname,
    required this.taskcompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade400,
              borderRadius: BorderRadius.circular(20),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              //checkbox
              Checkbox(
                value: taskcompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),

              //text
              Text(
                taskname,
                style: TextStyle(
                  decoration: taskcompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
