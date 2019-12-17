import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'students_database.g.dart';

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Students], daos: [StudentsDao])
class StudentsDatabase extends _$StudentsDatabase {
  StudentsDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Stream<List<Student>> getStudents() => select(students).watch();

  Future addStudent(Student student) => into(students).insert(student);
  Future deleteStudent(Student student) => delete(students).delete(student);
}

@UseDao(tables: [Students])
class StudentsDao extends DatabaseAccessor<StudentsDatabase>
    with _$StudentsDaoMixin {
  final StudentsDatabase sdb;
  StudentsDao(this.sdb) : super(sdb);

  Stream<List<Student>> getStudents() => select(students).watch();

  Future addStudent(Student student) => into(students).insert(student);
  Future deleteStudent(Student student) => delete(students).delete(student);
}
