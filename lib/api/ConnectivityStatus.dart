// import 'package:flutter/material.dart';
//
// import 'ConnectivityService.dart';
//
// class ConnectivityStatus extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<bool>(
//       stream: ConnectivityService.connectionStream,
//       builder: (context, snapshot) {
//         final isConnected = snapshot.data ?? true;
//         return AnimatedSwitcher(
//           duration: Duration(milliseconds: 300),
//           child:
//               isConnected
//                   ? SizedBox.shrink()
//                   : Banner(
//                     message: "Offline",
//                     location: BannerLocation.topStart,
//                     color: Colors.red,
//                   ),
//         );
//       },
//     );
//   }
// }
