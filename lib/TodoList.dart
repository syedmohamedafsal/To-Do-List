import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  final String taskname;
  final bool taskcompleted;
  Function(bool?)? onChanged;
  TodoList(
      {super.key,
      required this.taskname,
      required this.taskcompleted,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
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
    );
  }
}
