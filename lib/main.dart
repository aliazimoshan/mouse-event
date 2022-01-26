import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Scaffold(
        //appBar: AppBar(title: const Text(_title)),

        body: Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  double x = 0.0;
  double y = 0.0;
  double x1 = 0.0;
  double y1 = 0.0;
  bool menuHovered = false;
  String imageUrl =
      'https://images.unsplash.com/photo-1639669047277-32640a26bdf6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1587&q=80';

  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    pointerConverter() {
      double xTemp = x / screenWidth;
      double yTemp = y / screenHeight;
      double xTempPadding = xTemp - (1 - xTemp);
      double yTempPadding = yTemp - (1 - yTemp);
      setState(() {
        x1 = xTempPadding + (xTempPadding / 15);
        y1 = yTempPadding + (yTempPadding / 15);
      });
      if (-0.9 < xTempPadding &&
          xTempPadding < -0.8 &&
          -0.9 < yTempPadding &&
          yTempPadding < -0.8) {
        setState(() {
          menuHovered = true;
        });
      } else {
        setState(() {
          menuHovered = false;
        });
      }
    }

    pointerConverter();

    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        //color: Colors.black,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: Stack(
        children: [
          // ignore: prefer_const_constructors
          Align(
            alignment: const Alignment(-0.9, -0.9),
            child: const Icon(Icons.menu, size: 40, color: Colors.red),
          ),
          MouseRegion(
            onHover: _updateLocation,
            child: Align(
              alignment: Alignment(x1, y1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: menuHovered ? 60 : 40,
                height: menuHovered ? 60 : 40,
                decoration: BoxDecoration(
                  color: menuHovered
                      ? Colors.blueGrey.withOpacity(0.7)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: menuHovered ? Colors.transparent : Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
