import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_project/Providers/data_provider.dart';
import 'package:yoga_project/widgets/analyze_widget.dart';
import 'package:yoga_project/widgets/emg_chart.dart';
import 'package:yoga_project/widgets/fsr_chart.dart';
import 'package:yoga_project/widgets/multiple_skeletons.dart';
import 'package:yoga_project/widgets/pulse_gsr_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(
      context,
      listen: false,
    ).connectWebsocket();
  }

  final _scrollController = ScrollController();
  String? selectedItem = "FSR";
  List<String> sensorList = [
    "FSR",
    "Pulse-GSR",
    "EMG",
  ];
  bool _showFSR = false;
  bool _showGSR = false;
  bool _showEMG = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.transparent,
        title: const Text("Yoga demo app"),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const MultipleSkeletons(),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedItem,
                items: sensorList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  selectedItem = value;
                }),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      if (selectedItem == "FSR") {
                        setState(() {
                          _showFSR = true;
                          _showEMG = false;
                          _showGSR = false;
                        });
                      }
                      if (selectedItem == "Pulse-GSR") {
                        setState(() {
                          _showFSR = false;
                          _showEMG = false;
                          _showGSR = true;
                        });
                      }
                      if (selectedItem == "EMG") {
                        setState(() {
                          _showFSR = false;
                          _showEMG = true;
                          _showGSR = false;
                        });
                      }
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        scrollToEnd();
                      });
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        const BorderSide(
                          color: Colors.blue,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Show Chart",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        Provider.of<DataProvider>(context, listen: false)
                            .toggleAnalyzer();
                      });
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        scrollToEnd();
                      });
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        const BorderSide(
                          color: Colors.blue,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Analyze",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (Provider.of<DataProvider>(context).analyzer)
            const AnalyzeWidget(),
          if (_showFSR) const FSRChart(),
          if (_showGSR) const PulseGsrChart(),
          if (_showEMG) const EMGChart(),
        ],
      ),
    );
  }

  void scrollToEnd() {
    final end = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      end,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeIn,
    );
  }
}
