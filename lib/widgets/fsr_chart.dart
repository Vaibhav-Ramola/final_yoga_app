import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yoga_project/Providers/data_provider.dart';
import 'package:yoga_project/models/fsr_model.dart';
import 'dart:convert';

class FSRChart extends StatefulWidget {
  const FSRChart({Key? key}) : super(key: key);

  @override
  State<FSRChart> createState() => _FSRChartState();
}

class _FSRChartState extends State<FSRChart> {
  List<Fsr> dataList = [];
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
    );
    _tooltipBehavior = TooltipBehavior(
      enable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        child: SizedBox(
          // width: MediaQuery.of(context).size.height * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: SafeArea(
            child: StreamBuilder(
                stream: Provider.of<DataProvider>(context).stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> response = json
                        .decode(snapshot.data.toString()) as Map<String, dynamic>;
                    dataList = [];
                    List<dynamic> data = response["1"]["fsr"];
                    List<dynamic> time = response["1"]["time"];
                    for (final pair in IterableZip([data, time])) {
                      dataList.add(
                        Fsr(
                          fsr: double.parse(
                            pair[0].toString(),
                          ),
                          time: double.parse(
                            pair[1].toString(),
                          ),
                        ),
                      );
                    }
                    return SfCartesianChart(
                      title: ChartTitle(
                        // alignment: Alignment.center,
                        text: "FSR Chart",
                      ),
                      primaryYAxis: CategoryAxis(
                        isVisible: false,
                      ),
                      primaryXAxis: CategoryAxis(),
                      axes: [
                        NumericAxis(
                          isVisible: true,
                          name: "fsr",
                        ),
                      ],
                      tooltipBehavior: _tooltipBehavior,
                      zoomPanBehavior: _zoomPanBehavior,
                      series: <ChartSeries<Fsr, String>>[
                        FastLineSeries(
                          animationDuration: 0,
                          dataSource: dataList,
                          xValueMapper: (Fsr data, _) => data.time.toString(),
                          yValueMapper: (Fsr data, _) => data.fsr,
                          yAxisName: "fsr",
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
