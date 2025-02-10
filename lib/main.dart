import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/service/task.dart';
import 'package:todo_app/widgets/add_button.dart';
import 'package:todo_app/widgets/delete_button.dart';
import 'package:todo_app/widgets/input_text_field.dart';
import 'package:todo_app/widgets/list_item.dart';
import 'models/task.dart';

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
    //fetches the todo task todo list from Isar and populates items and checked
    final tasks = await isar.tasks.where().findAll();

    setState(() {
      //the items in the todo app
      items = tasks.map((tasks) => tasks.title).toList();
      //saves the the checked items so it does not go unchecked after reload
      checked = tasks.map((tasks) => tasks.completed).toList();
    });
  }

  void check({required int index, bool value = false}) {
    setState(() {
      checked[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D336B),
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 160,
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFF2D336B)),
                child: Row(
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
                          child: AddButton(
                              onPressed: () => TaskService.addItem(
                                  controller: controller,
                                  items: items,
                                  checked: checked,
                                  onAdd: () {
                                    setState(() {
                                      items.add(controller.text);
                                      checked.add(false);
                                    });
                                  })),
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: DeleteButton(
                              onPressed: () => TaskService.deleteItem(
                                checked: checked,
                                items: items,
                                onDelete: () {
                                  setState(() {
                                    items.removeWhere(
                                        (item) => checked[items.indexOf(item)]);
                                    checked.removeWhere((value) => value);
                                  });
                                },
                              ),
                            )))
                  ],
                ),
              )),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  border: Border.all(
                    color: Colors.grey,
                  )),
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return CustomItem(
                        value: checked[index],
                        onChange: (value) => check(index: index, value: value),
                        title: items[index],
                        onUpdate: (newTitle) => TaskService.editItem(
                          index: index,
                          title: items[index],
                          newTitle: newTitle,
                          onComplete: (value) {
                            setState(() {
                              items[index] = value;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
