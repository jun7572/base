import 'package:base/test/route.dart';
import 'package:base/test/test_page.dart';
import 'package:base/test/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  var provider = MultiProvider(providers:[
    ChangeNotifierProvider(create: (_)=>User(),),
  ],child:MyApp(),);
  runApp(provider);
  defineRoutes();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
//    Navigator.push(context, new MaterialPageRoute(builder: (_)=>TestPage("aaa")));
  //可行
//    router.navigateTo(context, "/test/嘎嘎嘎嘎嘎");
    String s="/test?id="+ Uri.encodeComponent("发达s");
            s+="&iid=111";
    router.navigateTo(context, s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            GestureDetector(
              onTap: (){

              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
