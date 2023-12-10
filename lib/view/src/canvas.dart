import 'package:flutter/material.dart';

class CanvasPage extends StatefulWidget {
final  List listedProducts;
  const CanvasPage({super.key,required this.listedProducts});

  @override
  State<CanvasPage> createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  // List<Offset> imagePositions = List.generate(6, (index) => Offset(0, 0));
  List<dynamic> imagePositions = List.generate(6, (index) => Offset(0, 0));
  final double canvasWidth = 300.0;
  final double canvasHeight = 400.0;
  List<String> items = [];


  addImage(){
    widget.listedProducts.forEach((element) {
      items.add(widget.listedProducts[element].thumbnail);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Move Images in Canvas'),
      ),
      body:
      // GridView.builder(
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 3,
      //   ),
      //   itemCount: items.length,
      //   itemBuilder: (context, index) {
      //     return Draggable<String>(
      //       data: items[index],
      //       child: GridTile(
      //         child: Container(
      //           color: Colors.blue,
      //           child: Center(
      //             child: Text(items[index]),
      //           ),
      //         ),
      //       ),
      //       feedback: Material(
      //         elevation: 4.0,
      //         child: Container(
      //           color: Colors.blue.withOpacity(0.5),
      //           child: Center(
      //             child: Text(items[index]),
      //           ),
      //         ),
      //       ),
      //       childWhenDragging: Container(),
      //     );
      //   },
      // ),
      ListView.builder(
          itemCount: widget.listedProducts.length,
          itemBuilder: (context,index){
        return Container(
          height: 100,
          width: 100,
          child: Image.network(widget.listedProducts[index].thumbnail),
        );
      }),
    );  }
}
