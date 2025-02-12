import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/service/task.dart';
import 'package:todo_app/widgets/add_button.dart';
import 'package:todo_app/widgets/delete_button.dart';
import 'package:todo_app/widgets/input_text_field.dart';
import 'package:todo_app/widgets/list_item.dart';
import 'package:todo_app/widgets/margin.dart';

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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double margin = ResponsiveMargin.getMargin(constraints);

          return Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 160,
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xFF1e1e2e)),
                    padding: EdgeInsets.symmetric(horizontal: margin),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          width: constraints.maxWidth > 700
                              ? 600
                              : constraints.maxWidth * 0.9,
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: InputTextField(controller: controller),
                        ),
                        AddButton(
                          onPressed: () => TaskService.addItem(
                            controller: controller,
                            items: items,
                            checked: checked,
                            onAdd: () {
                              setState(
                                () {
                                  items.add(controller.text);
                                  checked.add(false);
                                },
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: checked.contains(true),
                          child: DeleteButton(
                            onPressed: () => TaskService.deleteItem(
                              checked: checked,
                              items: items,
                              onDelete: () {
                                setState(
                                  () {
                                    items.removeWhere(
                                        (item) => checked[items.indexOf(item)]);
                                    checked.removeWhere((value) => value);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
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
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: margin),
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
                            onChange: (value) =>
                                check(index: index, value: value),
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
          );
        },
      ),
    );
  }
}
