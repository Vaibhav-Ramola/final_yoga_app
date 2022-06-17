import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yoga_project/models/fsr_model.dart';

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
      child: SizedBox(
        width: MediaQuery.of(context).size.height * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        child: SafeArea(
          child: SfCartesianChart(
            title: ChartTitle(
              // alignment: Alignment.center,
              text: "FSR Chart",
            ),
            primaryXAxis: CategoryAxis(),
            tooltipBehavior: _tooltipBehavior,
            zoomPanBehavior: _zoomPanBehavior,
            series: <ChartSeries<Fsr, String>>[
              FastLineSeries(
                dataSource: dataList,
                xValueMapper: (Fsr data, _) => data.time.toString(),
                yValueMapper: (Fsr data, _) => data.fsr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
