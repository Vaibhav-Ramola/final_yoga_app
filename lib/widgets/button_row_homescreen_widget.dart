// import 'package:flutter/material.dart';

// class ButtonRow extends StatefulWidget {
//   const ButtonRow({Key? key}) : super(key: key);

//   @override
//   State<ButtonRow> createState() => _ButtonRowState();
// }

// class _ButtonRowState extends State<ButtonRow> {
//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             OutlinedButton(
//               onPressed: () {
//                 if (selectedItem == "FSR") {
//                     setState(() {
//                       _showFSR = true;
//                       _showEMG = false;
//                       _showGSR = false;
//                     });
//                   }
//                   if (selectedItem == "Pulse-GSR") {
//                     setState(() {
//                       _showFSR = false;
//                       _showEMG = false;
//                       _showGSR = true;
//                     });
//                   }
//                   if (selectedItem == "EMG") {
//                     setState(() {
//                       _showFSR = false;
//                       _showEMG = true;
//                       _showGSR = false;
//                     });
//                   }
//               },
//               style: ButtonStyle(
//                 side: MaterialStateProperty.all(
//                   const BorderSide(
//                     color: Colors.blue,
//                     width: 1,
//                     style: BorderStyle.solid,
//                   ),
//                 ),
//               ),
//               child: const Text("Show Chart"),
//             ),
//             OutlinedButton(
//               onPressed: () {},
//               style: ButtonStyle(
//                 side: MaterialStateProperty.all(
//                   const BorderSide(
//                     color: Colors.blue,
//                     width: 1,
//                     style: BorderStyle.solid,
//                   ),
//                 ),
//               ),
//               child: const Text("Analyze"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
