import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:yoga_project/Providers/data_provider.dart';
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
    // TODO: implement initState
    super.initState();
  }

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
        slivers: [
          const MultipleSkeletons(
          ),
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
              margin: const EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              width: double.infinity,
              child: OutlinedButton(
                child: const Text("Show chart"),
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
                },
              ),
            ),
          ),
          if (_showFSR) const FSRChart(),
          if (_showGSR) const PulseGsrChart(),
        ],
      ),
    );
  }
}
