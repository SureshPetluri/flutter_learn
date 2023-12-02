import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => 'Item $index');

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dismissible Example'),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              key: Key(item), // Unique key for each item
              confirmDismiss: (DismissDirection direction) async {
                // Show a confirmation dialog before dismissing
                final bool shouldDismiss = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog.adaptive(
                      title: const Text('Confirm Delete'),
                      content: Text('Are you sure you want to delete $item?'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(false); // Don't dismiss
                          },
                        ),
                        ElevatedButton(
                          child: const Text('Delete'),
                          onPressed: () {
                            Navigator.of(context).pop(true); // Dismiss
                          },
                        ),
                      ],
                    );
                  },
                );
                return shouldDismiss;
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                // Delete the item only if it was confirmed in the dialog
                if (direction == DismissDirection.endToStart) {
                  items.removeAt(index);
                  // Scaffold.of(context).ScaffoldState(
                  //   SnackBar(
                  //     content: Text('$item deleted'),
                  //   ),
                  // );
                }
              },
              child: ListTile(
                title: Text(item),
              ),
            );
          },
        ),
      ),
    );
  }
}
