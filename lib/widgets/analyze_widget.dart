import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_project/Providers/data_provider.dart';

class AnalyzeWidget extends StatefulWidget {
  const AnalyzeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AnalyzeWidget> createState() => _AnalyzeWidgetState();
}

class _AnalyzeWidgetState extends State<AnalyzeWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Dismissible(
        onDismissed: ((direction) {
          setState(() {
            Provider.of<DataProvider>(
              context,
              listen: false,
            ).toggleAnalyzer();
          });
        }),
        key: const ValueKey("1"),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Adherence to protocol"),
                      Text("80%"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Group synchrony"),
                      Text("83%"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Agility and flexibility"),
                      Text("87%"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
