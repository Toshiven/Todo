import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
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

  void deleteItem(int i) {
    setState(() {
      items.removeAt(i);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Todo List',
            ),
            //TODO: Turn into custom stateless button
            TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.6),
                hintText: "Tasks",
                hintStyle: TextStyle(
                    color: Colors.grey[400], fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            //TODO: Turn into custom stateless button
            ElevatedButton(onPressed: addItem, child: const Text('add task')),
            Flexible(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                // return ListTile(
                //  leading: Checkbox(
                //  value: checked[index],
                // title: Text(_items[index]),
                // onChanged: (value) =>
                //    check(index: index, value: value ?? false),
                // ),
                // title: Text(items[index]),
                // trailing: IconButton(
                //  icon: const Icon(Icons.delete, color: Colors.red),
                //  onPressed: () => deleteItem(index),
                //),
                //     );
                return CustomItem(
                    value: checked[index],
                    onChange: (value) =>
                        check(index: index, value: value ?? false),
                    delete: () => deleteItem(index),
                    title: items[index]);
              },
            ))
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Checkbox(
//         value: value,
//         // title: Text(_items[index]),
//         onChanged: (value) => onChange,
//       ),
//       title: Text(title),
//       trailing: IconButton(
//         icon: const Icon(Icons.delete, color: Colors.red),
//         onPressed: () => delete,
//       ),
//     );
//   }
// }

