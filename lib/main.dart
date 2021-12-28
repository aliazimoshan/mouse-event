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
  int _enterCounter = 0;
  int _exitCounter = 0;
  double x = 0.0;
  double y = 0.0;
  double x1 = 0.0;
  double y1 = 0.0;

  void _incrementEnter(PointerEvent details) {
    setState(() {
      _enterCounter++;
    });
  }

  void _incrementExit(PointerEvent details) {
    setState(() {
      _exitCounter++;
    });
  }

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
    print('screenWidth: $x1');
    print('screenHeight: $y1');

    pointerWidthConverter() {
      setState(() {
        double temp = x / screenWidth;
        x1 = temp - (1 - temp);
      });
    }

    pointerHeightConverter() {
      setState(() {
        double temp = y / screenHeight;
        y1 = temp - (1 - temp);
      });
    }

    pointerHeightConverter();
    pointerWidthConverter();

    return Container(
      width: screenWidth,
      height: screenHeight,
      color: Colors.red,
      child: MouseRegion(
        onEnter: _incrementEnter,
        onHover: _updateLocation,
        onExit: _incrementExit,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$_enterCounter Entries\n$_exitCounter Exits',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(x1, y1),
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
