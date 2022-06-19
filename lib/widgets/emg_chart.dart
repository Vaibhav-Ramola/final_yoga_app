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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(
                            name: "EMG_${index + 1}",
                          ),
                          series: <ChartSeries<Emg, String>>[
                            FastLineSeries(
                              animationDuration: 0,
                              yAxisName: "Emg_${index + 1}",
                              dataSource: dataList,
                              xValueMapper: (Emg emg, _) => emg.time.toString(),
                              yValueMapper: (Emg emg, _) => emg.value,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
