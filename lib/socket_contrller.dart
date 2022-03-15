import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

/**
 *Developed by Suneel kumar 11-03-2022
 */

class SocketIoController extends GetxService {
  IO.Socket? socket;
  var  currentState=SocketState.none.obs;
  List<String> ?cookie;
  connectSocket() {
    /*socket ??= io('http://localhost:3000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()  // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build()
    );*/





    if(socket==null){
      socket = IO.io('ws://13.232.96.186:3002', <String, dynamic>{
        'transports': ['websocket'],
        'forceNew': false,
        'path': '/socket.io',
        'Authorization': 'bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MjE5Y2UwYjZmMGNkMDliZTYwYzJjYjAiLCJpYXQiOjE2NDcyNjQ1NjAsImV4cCI6MTY0OTg1NjU2MCwidHlwZSI6ImFjY2VzcyJ9.7LtieEV-mLpi0k9h8zPF5HnNhp8iBVwlUpuSwPwsfUE',
        'autoConnect': false,
        'secure': false,
      });

     /* socket = IO.io('http://localhost:3000/', <String, dynamic>{
        'transports': ['websocket'],
        'forceNew': true,
        'Authorization': '',
        'autoConnect': false,
      });*/
    }else if(!socket!.connected){
      socket = IO.io('ws://13.232.96.186:3002', <String, dynamic>{
        'transports': ['websocket'],
        'forceNew': true,
        'path': '/socket.io',
        'request-header-processer': (requestHeader) {
          print("get request header " + requestHeader.toString());
          if (cookie != null) {
            requestHeader.add('cookie', cookie);
            print("set cookie success");
          }else{
            print("set cookie faield");
          }
        },
        'response-header-processer': (responseHeader) {
          print("get response header " + responseHeader.toString());
          if ( responseHeader['set-cookie'] != null) {
            cookie = responseHeader['set-cookie'];
            print("receive cookie success");
          } else {
            print("receive cookie failed");
          }
        },

        'Authorization': 'bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MjE5Y2UwYjZmMGNkMDliZTYwYzJjYjAiLCJpYXQiOjE2NDcyNjQ1NjAsImV4cCI6MTY0OTg1NjU2MCwidHlwZSI6ImFjY2VzcyJ9.7LtieEV-mLpi0k9h8zPF5HnNhp8iBVwlUpuSwPwsfUE',
        'autoConnect': false,
        'secure': false,
      });
   /*   socket = IO.io('http://localhost:3000/', <String, dynamic>{
        'transports': ['websocket'],
        'forceNew': true,
        'Authorization': '',
        'autoConnect': false,
      });*/
    }
    if (!socket!.connected) {
      socket!.connect();
    }

    socket!.onConnect((data) {
      print('connected=>$data');
      currentState.value=SocketState.connected;

    });

    socket!.onDisconnect((data) {
      print('disconected=>$data');
      currentState.value=SocketState.disconnected;
    });

    socket!.onConnectError((data) {
      print('disconected=>$data');
    });
  }

  sendData() {
    if (socket != null) {
      if (socket!.connected) {
        socket!.emit('event', '');
      }
    }
  }

  disconnect() {
    if (socket != null) {
      if (socket!.connected) {
        socket!.disconnect();
      }
    }
  }

  bool get isSocketConnected=>currentState.value==SocketState.connected;


}

enum SocketState{
  none,
  connected,
  disconnected
}