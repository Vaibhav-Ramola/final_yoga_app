import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DataProvider with ChangeNotifier {
  // late Map<String, dynamic> incommingData;
  late WebSocketChannel channel;
  dynamic _stream;
  bool _analyzer = false;
  void connectWebsocket() {
    channel = WebSocketChannel.connect(Uri.parse("ws://192.168.0.116:7892/"));
    _stream = channel.stream.asBroadcastStream();
  }

  Stream<dynamic> get stream => _stream;
  bool get analyzer => _analyzer;
  void toggleAnalyzer() {
    _analyzer = !_analyzer;
    notifyListeners();
  }
}
