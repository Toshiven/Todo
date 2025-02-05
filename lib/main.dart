import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/widgets/add_button.dart';
import 'package:todo_app/widgets/delete_button.dart';
import 'package:todo_app/widgets/input_text_field.dart';
import 'package:todo_app/widgets/list_item.dart';
import 'task.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open([TaskSchema], directory: dir.path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      home: const TodoApp(title: 'TODO LIST'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key, required this.title});

  final String title;

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  late TextEditingController controller;
  late List<String> items;
  late List<bool> checked;

  @override
  void initState() {
    controller = TextEditingController();
    items = [];
    checked = [];
    loadTasks();
    super.initState();
  }

  void loadTasks() async {
    final tasks = await isar.tasks.where().findAll();

    setState(() {
      items = tasks.map((tasks) => tasks.title).toList();
      checked = tasks.map((tasks) => tasks.completed).toList();
    });
  }

  void addItem() async {
    if (controller.text.isNotEmpty) {
      final newTask = Task(title: controller.text, completed: false);

      await isar.writeTxn(() async {
        await isar.tasks.put(newTask);
      });
      setState(() {
        items.add(controller.text);
        checked.add(false);
        controller.clear();
      });
    }
  }

  void check({required int index, bool value = false}) {
    setState(() {
      checked[index] = value;
    });
  }

  void deleteItem() async {
    await isar.writeTxn(() async {
      for (int i = checked.length - 1; i >= 0; i--) {
        if (checked[i]) {
          final task = await isar.tasks
              .where()
              .filter()
              .titleEqualTo(items[i])
              .findFirst();

          if (task != null) {
            await isar.tasks.delete(task.id);
          }
        }
      }
    });
    setState(() {
      items = List.from(items
          .asMap()
          .entries
          .where((entry) => !checked[entry.key])
          .map((entry) => entry.value));
      checked = List.from(checked.where((value) => !value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: InputTextField(controller: controller),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: AddButton(onPressed: addItem),
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: DeleteButton(
                          onPressed: deleteItem,
                        ),
                      ))
                ],
              ),
              Row(children: [
                Flexible(
                    child: Container(
                        margin: EdgeInsets.all(32.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return CustomItem(
                                value: checked[index],
                                onChange: (value) =>
                                    check(index: index, value: value),
                                title: items[index]);
                          },
                        )))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
