import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:yoga_project/models/landmark.dart';
import 'dart:convert';

class DataProvider with ChangeNotifier {
  // late Map<String, dynamic> incommingData;
  // late WebSocketChannel channel;
  // void connectWebsocket() {
  //   channel = WebSocketChannel.connect(Uri.parse("ws://192.162.0.237:7891/"));
  // }

  // dynamic get stream {
  //   return channel.stream.asBroadcastStream();
  // }

  Stream<List<Landmark>>? getLandmarks(dynamic response, int index) {
    // var data_0 = json.encode("");
    Map<String, dynamic>? data = json.decode(response) as Map<String, dynamic>;
    data = data["5"]["data"]["$index"];
    // print("Data at $index = $data");
    if (data == null) {
      return null;
    }
    List<dynamic> X = data["X"];
    List<dynamic> Y = data["Y"];
    // print(X);
    return Stream.periodic(
      const Duration(microseconds: 1),
      ((computationCount) {
        for (final pair in IterableZip([X, Y])) {
          List<Landmark> landmarks = [];
          List<dynamic> x = pair[0];
          List<dynamic> y = pair[1];
          // print(x.length);
          // print(y.length);
          for (final lm in IterableZip([x, y])) {
            landmarks.add(
              Landmark(
                x: double.parse(lm[0].toString()),
                y: double.parse(lm[1].toString()),
                time: null,
              ),
            );
          }
          // print(landmarks);
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
