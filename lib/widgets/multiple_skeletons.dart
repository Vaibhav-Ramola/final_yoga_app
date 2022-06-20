import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_project/Providers/data_provider.dart';
import 'package:yoga_project/models/landmark.dart';
import 'package:yoga_project/widgets/paint_stickman.dart';
import 'dart:convert';

class MultipleSkeletons extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  const MultipleSkeletons({Key? key}) : super(key: key);

  @override
  State<MultipleSkeletons> createState() => _MultipleSkeletonsState();
}

class _MultipleSkeletonsState extends State<MultipleSkeletons> {


  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.width * 1.33,
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
                  stream: Provider.of<DataProvider>(
                    context,
                    listen: false,
                  ).stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<Landmark> landmarks = [];
                    Map<String, dynamic>? data =
                        json.decode(snapshot.data.toString())
                            as Map<String, dynamic>;
                    data = data["5"]["data"]["$index"];
                    if (data == null) {
                      return const Center(
                        child: Text("Participant not available,"),
                      );
                    }
                    List<dynamic> x = data["X"][0];
                    List<dynamic> y = data["Y"][0];
                    for (final pair in IterableZip([x, y])) {
                      landmarks.add(
                        Landmark(
                          x: double.parse(pair[0].toString()),
                          y: double.parse(pair[1].toString()),
                          time: null,
                        ),
                      );
                    }
                    return CustomPaint(
                      painter: PaintStickMan(
                        landmarks: landmarks,
                      ),
                      child: Container(),
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
