import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  late Id id = Isar.autoIncrement;

  late String title;
  late bool completed;

  Task({required this.title, required this.completed});
}
