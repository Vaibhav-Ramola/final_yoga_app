import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:yoga_project/Providers/data_provider.dart';
import 'package:yoga_project/models/landmark.dart';
import 'package:yoga_project/widgets/paint_stickman.dart';

class MultipleSkeletons extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  const MultipleSkeletons({Key? key}) : super(key: key);

  @override
  State<MultipleSkeletons> createState() => _MultipleSkeletonsState();
}

class _MultipleSkeletonsState extends State<MultipleSkeletons> {
  late WebSocketChannel channel;
  late Stream<dynamic> stream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel = WebSocketChannel.connect(Uri.parse("ws://192.168.0.116:7892/"));
    stream = channel.stream.asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.width * 1.2,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio:
                  (constraints.minHeight - 16) / (constraints.minWidth - 16),
            ),
            itemBuilder: (ctx, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  // color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: StreamBuilder(
                  stream: stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return const Center(
                        child: Text("Connection cancelled"),
                      );
                    }
                    if (snapshot.hasData) {
                      
                      return StreamBuilder<List<Landmark>>(
                          stream: Provider.of<DataProvider>(
                            context,
                            listen: false,
                          ).getLandmarks(
                            snapshot.data,
                            index,
                          ),
                          builder: (context, snapshot_0) {
                            if (snapshot_0.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: Text(
                                  "Wait a moment",
                                ),
                              );
                            }
                            if (snapshot_0.hasData) {
                              return CustomPaint(
                                painter: PaintStickMan(
                                  landmarks: snapshot_0.data!,
                                ),
                                child: Container(),
                              );
                            }
                            return Text("Nope");
                          });
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
