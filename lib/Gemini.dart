// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart'; // Import the page_transition package
//
// void main() => runApp(const MaterialApp(home: FirstPage()));
//
// class FirstPage extends StatelessWidget {
//   const FirstPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('First Page')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Use Hero for the shared image transition.  The tag *must* be unique.
//             Hero(
//               tag: 'imageHero', // Unique tag for the image
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                     image: NetworkImage('https://picsum.photos/200'), // Example image
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Hero for the text transition.  Also needs a unique tag.
//             Hero(
//               tag: 'textHero', // Unique tag for the text
//               child: const Text(
//                 'Welcome',
//                 style: TextStyle(fontSize: 24, color: Colors.black),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   // Use PageTransition for the custom animation
//                   PageTransition(
//                     type: PageTransitionType.fade, // Choose your animation type
//                     child: const SecondPage(),
//                   ),
//                 );
//               },
//               child: const Text('Go to Second Page'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SecondPage extends StatelessWidget {
//   const SecondPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Second Page')),
//       body:  LayoutBuilder(builder: (context, constraints) {
//         return  SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minHeight: constraints.maxHeight,
//             ),
//             child: Center(
//               child: Column(
//                 children: <Widget>[
//                   // Hero for the image in the second page.  Use the same tag.
//                   Hero(
//                     tag: 'imageHero', // Same tag as in the first page
//                     child: Container(
//                       width: constraints.maxWidth * 0.8, // Make it responsive
//                       height: constraints.maxWidth * 0.8,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           image: NetworkImage('https://picsum.photos/200'), // Same image URL
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Hero for the text in the second page.  Use the same tag.
//                   Hero(
//                     tag: 'textHero', // Same tag as in the first page
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20, top: 20), // Position the text
//                       child: Text(
//                         'Welcome to the Detail Page',
//                         style: TextStyle(fontSize: 30, color: Colors.blue[900], fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
