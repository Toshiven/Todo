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
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

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
        centerTitle: true,
        backgroundColor: const Color(0xFF1e1e2e),
        foregroundColor: const Color(0xFFcdd6f4),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 160,
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFF1e1e2e)),
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(minWidth: 350.0),
                        width: MediaQuery.of(context).size.width * 1.0,
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
                            ))),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: Text("Logout"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
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
                  color: const Color(0xFF313244),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  border: Border.all(
                    color: const Color(0xFF313244),
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

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF1e1e2e),
        foregroundColor: const Color(0xFFcdd6f4),
        title: Text("LOGIN"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Login"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TodoApp()),
            );
          },
        ),
      ),
      backgroundColor: const Color(0xFF1e1e2e),
    );
  }
}
