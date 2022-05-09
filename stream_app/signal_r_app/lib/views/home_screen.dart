import 'package:flutter/material.dart';
import 'package:signal_r_app/views/resize_container.dart';
import 'package:signalr_client/signalr_client.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({Key? key}) : super(key: key);

  @override
  _HomeSceenState createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  late HubConnection hubConnection;
  final URL_BASE = "http://10.0.2.2:5000/movehub";
  late Offset pos;
  double height = 100.0;
  double width = 100.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pos = Offset(0.0, 0.0);
    _hubConnection();
  }

  _hubConnection() async {
    hubConnection = HubConnectionBuilder().withUrl(URL_BASE).build();
    await hubConnection.start();
    hubConnection.onclose((error) {
      print("connection close");
    });
    hubConnection.on('ReceiverPosition', (arguments) => _handlePosition(arguments));
    hubConnection.on('ReceiverSize', (arguments) => _handleSize(arguments));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResizebleWidget(
        position: pos,
        height: height,
        width: width,
        child: Container(
          decoration: BoxDecoration(color: Colors.green),
          height: height,
          width: width,
        ),
        changePosition: (a, b) => _changePosition(a, b),
        onChangeAllSize: (a, b) => _changeSize(a, b),
        onChangeHeightSize: (a) => _changeHeight(a),
        onChangeWidthSize: (a) => _changeWidth(a),
      ),
    );
  }

  _handlePosition(List<Object> arguments) {
    if (hubConnection.state == HubConnectionState.Connected) {
      print('ReceiverViewFromSever');
      setState(() {
        pos = Offset(arguments[0] as double, arguments[1] as double);
      });
    }
  }

  _changePosition(double a, double b) async {
    if (hubConnection.state == HubConnectionState.Connected) {
      print('MoveViewFromSever');
      await hubConnection.invoke('MoveViewFromSever', args: [a, b]);
    }
  }

  _changeSize(double height, double width) async {
    if (hubConnection.state == HubConnectionState.Connected) {
      print("");
      await hubConnection.invoke("ChangeSizeFromSever", args: [height, width]);
    }
  }

  _changeHeight(double height) async {
    if (hubConnection.state == HubConnectionState.Connected) {
      print("");
      await hubConnection.invoke("ChangeSizeFromSever", args: [height, width]);
    }
  }

  _changeWidth(double width) async {
    if (hubConnection.state == HubConnectionState.Connected) {
      print("");
      await hubConnection.invoke("ChangeSizeFromSever", args: [height, width]);
    }
  }

  _handleSize(List<Object> arguments) {
    if (hubConnection.state == HubConnectionState.Connected) {
      print('ReceiverViewFromSever');
      setState(() {
        height = arguments[0] as double;
        width = arguments[1] as double;
      });
    }
  }
}
