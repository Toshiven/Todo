import 'package:isar/isar.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/task.dart';

class TaskService {
  static editItem(
      {required int index,
      required String newTitle,
      required String title,
      required Function(String value) onComplete}) async {
    final task =
        await isar.tasks.where().filter().titleEqualTo(title).findFirst();
    if (task == null) {
      return;
    }
    task.title = newTitle;
    await isar.writeTxn(() async {
      await isar.tasks.put(task);
    });
    onComplete(newTitle);
  }
}
