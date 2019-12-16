import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'moor/students_database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ), create: (BuildContext context) =>StudentsDatabase(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
     
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
      final dataProvider=Provider.of<StudentsDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<Student>>(
        stream: dataProvider.getStudents(),
        builder: (context, snapshot) {
          List<Student> students=snapshot.data??List();
          return ListView.builder(itemCount: students.length,
            itemBuilder: (BuildContext context, int index) {
return Text(students[index].id.toString());
            },);
            
            })
            ,
            floatingActionButton: FloatingActionButton(onPressed: () {
              dataProvider.addStudent(Student(name: 'sriram', id: null));
            },child: Icon(Icons.add),),
    );
  }
}
