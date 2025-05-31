import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];
  void _addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => NewItem()));
    if (newItem == null) return;
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
      ),
      body:
          _groceryItems.isEmpty
              ? Center(
                child: Text(
                  'No Groceries yet! Try Adding Some',
                  style: TextStyle(fontSize: 24),
                ),
              )
              : ListView.builder(
                itemCount: _groceryItems.length,
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Dismissible(
                        key: ValueKey(_groceryItems[index].id),
                        onDismissed: (direction) {
                          setState(() {
                            _groceryItems.removeAt(index);
                          });
                        },
                        child: ListTile(
                          leading: Container(
                            height: 24,
                            width: 24,
                            color: _groceryItems[index].category.color,
                          ),
                          title: Text(_groceryItems[index].name),
                          trailing: Text(
                            _groceryItems[index].quantity.toString(),
                          ),
                        ),
                      ),
                    ),
              ),
    );
  }
}
