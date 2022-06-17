import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:yoga_project/models/landmark.dart';

class DataProvider with ChangeNotifier {
  late Map<String, dynamic> incommingData;
  late WebSocketChannel channel;
  void connectWebsocket() {
    channel = WebSocketChannel.connect(Uri.parse("ws://192.162.0.237:7891"));
  }

  Stream<List<Landmark>> getLandmarks(dynamic response, int index) {
    Map<String, dynamic> data = response as Map<String, dynamic>;
    data = data["5"]["data"]["$index"];
    List<List<dynamic>> X = data["X"];
    List<List<dynamic>> Y = data["Y"];
    return Stream.periodic(
      const Duration(milliseconds: 30),
      ((computationCount) {
        for (final pair in IterableZip([X, Y])) {
          List<Landmark> landmarks = [];
          var x = pair[0];
          var y = pair[1];
          for (final lm in IterableZip([x, y])) {
            landmarks.add(
              Landmark(
                x: lm[0],
                y: lm[1],
                time: null,
              ),
            );
          }
          return landmarks;
        }
        return [];
      }),
    );
  }

  List<Landmark> sendLandmarks(List<dynamic> data) {
    return [];
  }
}
