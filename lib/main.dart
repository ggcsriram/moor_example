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
          home: MainPage()),
      create: (BuildContext context) => StudentsDatabase().studentsDao,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    print('hello');
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StudentsDao dataProvider;
  TextEditingController nameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('qwerty');
    dataProvider = Provider.of<StudentsDao>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('moor_example'),
      ),
      body: StreamBuilder<List<Student>>(
          stream: dataProvider.getStudents(),
          builder: (context, snapshot) {
            List<Student> students = snapshot.data ?? List();
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(students[index].name.toString()),
                  leading: Text(students[index].id.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dataProvider.deleteStudent(students[index]);
                    },
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: TextField(
                controller: nameTextController,
              ),
              actions: [
                FlatButton(
                  child: Text('Add'),
                  onPressed: () async {
                    await dataProvider.addStudent(Student(
                        name: nameTextController.text.toString(), id: null));
                    nameTextController.text = '';
                    Navigator.pop(context);
                  },
                )
              ]);
        });
  }
}
