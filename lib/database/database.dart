import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  List toDoList = [];
//reference of box
  final mybox = Hive.box('mybox');

//when the application opened the screen display the list
  void createInitialData() {
    toDoList = [
      ["Complete todo app", false],
      ["Study Flutter", false],
    ];
  }

//loaf the data from database
  void loadData() {
    toDoList = mybox.get("TODOLIST");
  }

  void upadeteDataBase() {
    mybox.put("TODOLIST", toDoList);
  }
}
