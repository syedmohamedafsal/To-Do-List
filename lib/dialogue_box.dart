import 'package:flutter/material.dart';
import './Mybutton.dart';

class DialogueBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogueBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[300],
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: "Add A New Task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button to save the task
                Mybutton(text: "Save", onpressed: onSave),

                const SizedBox(
                  width: 10,
                ),
                //cancel button to cancel the task
                Mybutton(text: "Cancel", onpressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
