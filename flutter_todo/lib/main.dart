import 'package:flutter/material.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ad0rable Todo List',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: TodoList()
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  final List<String> _todoItems = [];

  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
    if(task.length > 0){
      setState(() {
        _todoItems.add(task);
      });
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      title: const Text('Todo List')
    ),
    body: _buildTodoList(),
    floatingActionButton: FloatingActionButton(
      onPressed: _pushAddTodoScreen, // pressing this button now opens the new screen
      tooltip: 'Add task',
      child: const Icon(Icons.add)
    ),
    );
  }
  void _pushAddTodoScreen() {
  // Push this page onto the stack
  Navigator.of(context).push(
    // MaterialPageRoute will automatically animate the screen entry, as well
    // as adding a back button to close it
    MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add a new task')
          ),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: const InputDecoration(
              hintText: 'Enter something to do...',
              contentPadding: EdgeInsets.all(16.0)
            ),
            )
          );
        }
      )
    );
  }

  

  void _removeTodoItem(int index) {
  setState(() => _todoItems.removeAt(index));
}

// Show an alert dialog asking the user to confirm that the task is done
void _promptRemoveTodoItem(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Mark "${_todoItems[index]}" as done?'),
        actions: <Widget>[
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('MARK AS DONE'),
            onPressed: () {
              _removeTodoItem(index);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


Widget _buildTodoList() {
  return ListView.builder(
    itemBuilder: (context, index) {
      if(index < _todoItems.length) {
        return _buildTodoItem(_todoItems[index], index);
      }
    },
  );
}

Widget _buildTodoItem(String todoText, int index) {
  return ListTile(
    title: Text(todoText),
    onTap: () => _promptRemoveTodoItem(index)
  );
}
}