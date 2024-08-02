import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = ["item 1", "item 2","item 3"];  
  //list for storing data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learning app"),
      
      ),
      body: Column(children: [
        Expanded(child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context,index){
           return LongPressDraggable<String>(
                data: items[index],
                dragAnchorStrategy: pointerDragAnchorStrategy,
                feedback: Material(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.blueAccent,
                    child: Text(
                      items[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                child: ListTile(
                  title: Text(items[index]),
                ),
              );
            },
          ),
        ),
        DragTarget<String>(
          builder: (context, candidateData, rejectedData) {
            return Container(
              height: 100,
              color: candidateData.isEmpty ? Colors.grey : Colors.red,
              child: Center(
                child: Text(
                  "Drag here to delete",
                  style: TextStyle(
                    color: candidateData.isEmpty ? Colors.black : Colors.white,
                  ),
                ),
              ),
            );
          },
          onAccept: (data) {
            setState(() {
              items.remove(data);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("$data deleted")),
            );
          },
        ),
      ],
            ));
  }
}