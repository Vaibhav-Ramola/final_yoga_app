import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yoga_project/Providers/data_provider.dart';
import 'package:yoga_project/models/emg_model.dart';

class EMGChart extends StatefulWidget {
  const EMGChart({Key? key}) : super(key: key);

  @override
  State<EMGChart> createState() => _EMGChartState();
}

class _EMGChartState extends State<EMGChart> {
  List<Emg> dataList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.5,
        child: LayoutBuilder(builder: (context, constraints) {
          return GridView.builder(
              itemCount: 16,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio:
                    (constraints.minHeight - 32) / (constraints.minWidth - 32),
                crossAxisCount: 1,
              ),
              itemBuilder: (context, index) {
                return Card(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: SafeArea(
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
                          Map<String, dynamic> response =
                              json.decode(snapshot.data.toString());
                          List<dynamic> data = response["2"]["${index + 1}"];
                          List<dynamic> time = response["2"]["time"];
                          dataList = [];
                          for (final pair in IterableZip([data, time])) {
                            dataList.add(
                              Emg(
                                value: double.parse(pair[0].toString()),
                                time: double.parse(pair[1].toString()),
                              ),
                            );
                          }
                          return SfCartesianChart(
                            title: ChartTitle(text: "EMG Channel ${index + 1}"),
                            primaryXAxis: CategoryAxis(
                              isVisible: false,
                              title: AxisTitle(
                                text: "Time",
                              ),
                            ),
                            primaryYAxis: NumericAxis(
                              minimum: -5000,
                              maximum: 5000,
                              name: "EMG_${index + 1}",
                            ),
                            series: <ChartSeries<Emg, String>>[
                              FastLineSeries(
                                animationDuration: 0,
                                yAxisName: "Emg_${index + 1}",
                                dataSource: dataList,
                                xValueMapper: (Emg emg, _) =>
                                    emg.time.toString(),
                                yValueMapper: (Emg emg, _) => emg.value,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}
