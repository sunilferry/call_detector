
import 'package:call_detect/FintCtrl.dart';
import 'package:call_detect/socket_contrller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
void main() {
/*

  var io = Server();
  io.on('connection', (client) {
    final headers = client.handshake['headers'];
    headers.forEach((k, v) => print('$k => $v'));

    print('connection default namespace');
    client.on('toServer', (data) {
      print('data from default => $data');
      client.emit('fromServer', '$data');
    });
  });
  io.listen(3000);*/
  runApp(const MyApp());
}


class InitialBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(SocketIoController());
  }

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _callbackDispatcher() {
    const MethodChannel _backgroundChannel = MethodChannel('com.example.call_detectback');
    _backgroundChannel.setMethodCallHandler((MethodCall call) async {
      print(' from flutter ${call.arguments}');

    });

  }
  @override
  void initState() {
    _callbackDispatcher();
    super.initState();
    FindCtrl.socketIo.connectSocket();


 /*   _socket = IO.io('http://13.232.96.186:3002/', <String, dynamic>{'transports': ['websocket'], 'forceNew': true,
      'Authorization':'bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MjE5Y2UwYjZmMGNkMDliZTYwYzJjYjAiLCJpYXQiOjE2NDY5NzcxNDcsImV4cCI6MTY0OTU2OTE0NywidHlwZSI6ImFjY2VzcyJ9.-cYQuGP1CyNbLkcbFTFeWl51gvOyBaiG7hAoeTiYrhg'});
    _socket.connect();
    _socket.on("connect", (_) {
      print('Connected');

    });
    _socket.on("fromServer", (_) {
      print('fromServer $_');
    });
    _socket.on("connect_error", (data) => print('connect_error: $data'));
    _socket.on("reconnect", (data) => print('reconnect: $data'));
    _socket.on("reconnect_failed", (data) => print('reconnect_failed: $data'));
    _socket.on("reconnect_error", (data) => print('reconnect_error: v'));*/

  }

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
            const Text(
              'You have pushed the button this many times:',
            ),
            Obx(
              ()=> Text(

                '${FindCtrl.socketIo.isSocketConnected}',
                style: Theme.of(context).textTheme.headline4,
                key: ValueKey('statev${FindCtrl.socketIo. currentState.value}'),
              ),
            ),
            ElevatedButton(onPressed: (){
              FindCtrl.socketIo.disconnect();
            }, child: Text('Disconnect')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          FindCtrl.socketIo.connectSocket();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
