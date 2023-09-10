import 'package:flutter/material.dart';
import './home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';



void main() async {
  //initial the hive
  await Hive.initFlutter();
 
  //open the box
  var box = await Hive.openBox('mybox');

  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
    );
  }
}
