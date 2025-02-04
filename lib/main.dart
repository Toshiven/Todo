import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/widgets/add_button.dart';
import 'package:todo_app/widgets/input_text_field.dart';
import 'package:todo_app/widgets/list_item.dart';
import 'user.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open([UserSchema], directory: dir.path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoApp(title: 'Todo Page'),
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
  //TODO: Transfer to initState
  final TextEditingController controller = TextEditingController();
  final List<String> items = [];
  final List<bool> checked = [];

  void addItem() {
    if (controller.text.isNotEmpty) {
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

  void deleteItem({required int index}) {
    setState(() {
      items.removeAt(index);
      checked.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Todo List',
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: InputTextField(controller: controller),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: AddButton(onPressed: addItem),
                      ))
                ],
              ),
              Row(children: [
                Flexible(
                    child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    //TODO: fix checkbox
                    return CustomItem(
                        value: checked[index],
                        onChange: (value) => check(index: index, value: value),
                        delete: () => deleteItem(index: index),
                        title: items[index]);
                  },
                ))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
