import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';

import 'add.dart';


class TodoList extends StatefulWidget{
  List <Widget> sections = [const All(), const Incomplete(), const Completed()];
  int index = 0;
  TodoList({super.key});
  

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  //late int index; 
  //@override 
  //void initState(){
    //super.initState();
    //index = widget.index;
  //}

  @override 
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children:[
            const Text("Todo"), 
            const Spacer(), 
            IconButton(
              icon:const Icon(Icons.add), 
              onPressed:(){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Add()
                  )
                );
              }
            )
          ]
        )
      ),
      body: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState((){
                      widget.index = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: ( widget.index == 0)?const Border(bottom: BorderSide(
                          color: Color(0xff000000),
                          style: BorderStyle.solid,
                        )
                      ):Border.all(style: BorderStyle.none),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(size.height * 0.015),
                      child: const Text(
                        "All",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ),
                ),
              ), 
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState((){
                      widget.index = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: 
                      (widget.index == 1)?
                      const Border(bottom: BorderSide(
                          color: Color(0xff000000),
                          style: BorderStyle.solid,
                        )
                      ): Border.all(style: BorderStyle.none),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(size.height * 0.015),
                      child: const Text(
                        "Incomplete",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState((){
                      widget.index = 2;
                    });
                  },
                  child:Container(
                    decoration: BoxDecoration(
                      border: 
                      (widget.index== 2)?
                      const Border(bottom: BorderSide(
                          color: Color(0xff000000),
                          style: BorderStyle.solid,
                        )
                      ):Border.all(style: BorderStyle.none),
                    ),
                    child:Padding(
                      padding: EdgeInsets.all(size.height * 0.015),
                      child: const Text(
                        "Complete",
                        textAlign: TextAlign.center,
                      ),
                    )
                  )
                ),
              )
            ],
          ),
          widget.sections[widget.index],
        ],
      )
    );
  }
}

class All extends StatelessWidget{
  const All({super.key});

  @override 
  Widget build(BuildContext context){
    int len = context.watch<ItemProvider>().items.length;
    return Expanded(
      child: (ListView.builder(
          itemCount: len, 
          itemBuilder: (_, int index) {
            var item = context.watch<ItemProvider>().items[index];
            return Row(
              children: [
                Checkbox(
                  value: item.completed, 
                  onChanged: (value){
                    context.read<ItemProvider>().selectItem(item);
                  }
                ),
                Text(item.title),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: (){
                    context.read<ItemProvider>().removeItem(item);
                  },
                )
              ],
            );
          }
        )
      ),
    );
 }
}

class Incomplete extends StatelessWidget{
  const Incomplete({super.key});

  @override 
  Widget build(BuildContext context){
    //int len = context.watch<ItemProvider>().uItems.length;
    var items = context.watch<ItemProvider>().uItems;
    return Expanded(
      child: (
        Column(children: [for (var item in items) Row(
              children: [
                Checkbox(
                  value: item.completed, 
                  onChanged: (value){
                    context.read<ItemProvider>().selectItem(item);
                  }
                ),
                Text(item.title),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: (){
                    context.read<ItemProvider>().removeItem(item);
                  },
                )
              ],
            ),
        ]
          )
          )
      );
  }
}


class Completed extends StatelessWidget{
  const Completed ({super.key});

  @override 
  Widget build(BuildContext context){
    //int len = context.watch<ItemProvider>().uItems.length;
    var items = context.watch<ItemProvider>().cItems;
    return Expanded(
      child: (
        Column(
          children: [for (var item in items) Row(
            children: [
              Checkbox(
                value: item.completed, 
                onChanged: (value){
                  context.read<ItemProvider>().selectItem(item);
                }
              ),
              Text(item.title),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: (){
                  context.read<ItemProvider>().removeItem(item);
                },
              )
            ],
          ),
        ])
      )
    );
  }
}