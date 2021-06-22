import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool visible = false;
  bool alphaVisible = false;
  int _counter = 0;
  Color color = Colors.white;
  Color textColor = Colors.black;
  double alpha = 0;
  String input = "";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      color = changeColor();
      textColor = changeColor();
    });
  }

  Color changeColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  void showSnackBar() {
    String text = "Counter is $_counter";
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 1000),
    ));
  }

  void showImage() {
    setState(() {
      visible = !visible;
    });
  }

  void showImageWithAnimation() {
    setState(() {
      alphaVisible = !alphaVisible;
      alpha = !alphaVisible ? 0 : 1;
    });
  }

  void _decrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter--;
    });
  }

  Future<void> _showDialog(String name) {
    String text = 'the king of Flutter';
    String message = "";
    String title = "";

    if (name == 'mahmoud') {
      title = 'WROOOOOOOONG';
      message = "mahmoud is not $text";
    } else {
      title = "That is correct";
      message = "jalal is $text!!! hahaha";
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text(title),
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void checkCompletion() {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Who is the king of Flutter?",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontFamily: "Georgia",
                  fontWeight: FontWeight.w100),
            ),
            Center(
              widthFactor: 1,
              child: TextField(
                controller: TextEditingController(),
                focusNode: FocusNode(),
                style: TextStyle(
                    backgroundColor: Colors.yellow,
                    color: Colors.deepPurple,
                    fontSize: 32,
                    fontFamily: "Georgia",
                    fontWeight: FontWeight.w200),
                cursorColor: Colors.green,
                onEditingComplete: checkCompletion,
                onChanged: (String value) async {
                  if (value == 'mahmoud') {
                    _showDialog('mahmoud');
                    return;
                  }
                  if (value != 'jalal') {
                    return;
                  }
                  await _showDialog('jalal');
                },
              ),
            ),
            Visibility(
              visible: visible,
              child: Image.asset(
                'assets/images/image.jpg',
                width: 200,
                height: 200,
              ),
            ),
            GestureDetector(
              onLongPress: showImageWithAnimation,
              onTap: showImage,
              child: Text(
                'You have pushed the button this many times:',
                style: TextStyle(color: textColor),
              ),
            ),
            GestureDetector(
              onTap: showSnackBar,
              child: Text(
                '$_counter',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(inherit: true, color: color), // TextStyle
              ),
            ),
            AnimatedOpacity(
              opacity: alpha,
              duration: Duration(milliseconds: 2000),
              child: Visibility(
                //visible: alphaVisible,
                child: Image.asset(
                  'assets/images/image.jpg',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        //foregroundColor: color,
        backgroundColor: textColor,
        child: GestureDetector(
          child: Icon(
            Icons.add,
            size: 24,
            color: color,
          ),
          onLongPress: _decrementCounter,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
