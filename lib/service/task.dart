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
    if (task == null) return;
    task.title = newTitle;
    await isar.writeTxn(() async {
      await isar.tasks.put(task);
    });
    onComplete(newTitle);
  }

  static addItem(
      {required controller,
      required List<String> items,
      required List<bool> checked,
      required Function() onAdd}) async {
    if (controller.text.isNotEmpty) {
      final newTask = Task(title: controller.text, completed: false);

      await isar.writeTxn(() async {
        await isar.tasks.put(newTask);
      });
      onAdd();
      controller.clear();
    }
  }

  static deleteItem(
      {required List<bool> checked,
      required List<String> items,
      required Function() onDelete}) async {
    await isar.writeTxn(() async {
      for (int i = checked.length - 1; i >= 0; i--) {
        if (checked[i]) {
          final task = await isar.tasks
              .where()
              .filter()
              .titleEqualTo(items[i])
              .findFirst();

          if (task == null) return;
          await isar.tasks.delete(task.id);
          items.removeAt(i);
          checked.removeAt(i);
        }
      }
    });

    onDelete();
  }

  static Future<void> toggleCheck(String title, bool isChecked) async {
    final task =
        await isar.tasks.where().filter().titleEqualTo(title).findFirst();
    if (task == null) return;
    task.completed = isChecked;
    await isar.writeTxn(() async {
      await isar.tasks.put(task);
    });
  }
}
