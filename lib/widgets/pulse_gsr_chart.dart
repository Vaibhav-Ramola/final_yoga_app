import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yoga_project/Providers/data_provider.dart';
import 'package:yoga_project/models/gsr_pulse_model.dart';
import 'dart:convert';

class PulseGsrChart extends StatefulWidget {
  const PulseGsrChart({Key? key}) : super(key: key);

  @override
  State<PulseGsrChart> createState() => _PulseGsrChartState();
}

class _PulseGsrChartState extends State<PulseGsrChart> {
  List<GsrPulse> dataList = [];
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
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
          width: MediaQuery.of(context).size.height * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: SafeArea(
            child: StreamBuilder(
              stream: Provider.of<DataProvider>(context).stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                dataList = [];
                Map<String, dynamic> response = json
                    .decode(snapshot.data.toString()) as Map<String, dynamic>;
                List<dynamic> gsr = response["0"]["gsr"];
                List<dynamic> pulse = response["0"]["pulse"];
                List<dynamic> time = response["0"]["time"];
                for (final triple in IterableZip([gsr, pulse, time])) {
                  dataList.add(
                    GsrPulse(
                      gsr: double.parse(triple[0].toString()),
                      pulse: double.parse(triple[1].toString()),
                      time: double.parse(triple[2].toString()),
                    ),
                  );
                }
                return SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    isVisible: false,
                    title: AxisTitle(text: "Time"),
                  ),
                  axes: <ChartAxis>[
                    NumericAxis(
                      opposedPosition: true,
                      name: 'Pulse',
                    ),
                    NumericAxis(
                      opposedPosition: false,
                      name: 'GSR',
                    )
                  ],
                  title: ChartTitle(
                    // alignment: Alignment.center,
                    text: "GSR-Pulse Chart",
                  ),
                  primaryYAxis: CategoryAxis(
                    isVisible: false,
                  ),
                  tooltipBehavior: _tooltipBehavior,
                  zoomPanBehavior: _zoomPanBehavior,
                  series: <ChartSeries<GsrPulse, String>>[
                    FastLineSeries(
                      animationDuration: 0,
                      dataSource: dataList,
                      xValueMapper: (GsrPulse data, _) => data.time.toString(),
                      yValueMapper: (GsrPulse data, _) => data.gsr,
                      yAxisName: "GSR",
                    ),
                    FastLineSeries(
                      animationDuration: 0,
                      dataSource: dataList,
                      xValueMapper: (GsrPulse data, _) => data.time.toString(),
                      yValueMapper: (GsrPulse data, _) => data.pulse,
                      yAxisName: "Pulse",
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
