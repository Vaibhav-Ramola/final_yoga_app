import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_project/Providers/data_provider.dart';
import 'package:yoga_project/models/landmark.dart';
import 'package:yoga_project/widgets/paint_stickman.dart';

class MultipleSkeletons extends StatefulWidget {
  const MultipleSkeletons({Key? key}) : super(key: key);

  @override
  State<MultipleSkeletons> createState() => _MultipleSkeletonsState();
}

class _MultipleSkeletonsState extends State<MultipleSkeletons> {
  List<Landmark> landmarks = [];
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          // color: Colors.amber,
          // boxShadow: boxShadow,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 16,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: constraints.minHeight / constraints.minWidth,
            ),
            itemBuilder: (ctx, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  color: Colors.grey[300],
                  child: StreamBuilder(
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
                            stream:
                                Provider.of<DataProvider>(context).getLandmarks(
                              snapshot,
                              index,
                            ),
                            builder: (context, snapshot_0) {
                              return CustomPaint(
                                painter: PaintStickMan(
                                  landmarks: snapshot_0.data ?? [],
                                ),
                                child: Container(),
                              );
                            });
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    stream: Provider.of<DataProvider>(context).channel.stream,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
