import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo/providers/todo_provider.dart';
import 'package:todo/models/item.dart';


class Add extends StatefulWidget{
  const Add({super.key});
    
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  String title = '';
  bool check = false;
  @override 
  Widget build(BuildContext context){

    int length = context.watch<ItemProvider>().items.length;
    return Scaffold(
      appBar: AppBar(
        title:
          const Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: ((value) {
                title = value;
              }),
            ),
            CheckboxListTile(
              title: const Text("Completed?"),
              contentPadding: EdgeInsets.zero,
              value: check, 
              onChanged:(value){
                setState(() {
                  check = !check;
                });
                
              }
            ),
            ElevatedButton(
              onPressed: (){
                var item = Item(
                  title:title,
                  index: length,
                  completed: check,
                );
                context.read<ItemProvider>().addItem(item);
                Navigator.pop(context);
              }, 
              child: const Text("Add"),
            )
          ],
        ),
      )
    );
  }
}