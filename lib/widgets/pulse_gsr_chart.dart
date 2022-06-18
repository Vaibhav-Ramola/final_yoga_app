import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:yoga_project/models/gsr_pulse_model.dart';

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
          ),
        ),
      ),
    );
  }
}
