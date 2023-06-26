// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';

import 'ar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFB39DDB)),
        useMaterial3: true,
      ),
      home: LocalAndWebObjectsWidget(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late ArCoreController arCoreController;
//
//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//
//     _addSphere(arCoreController);
//     _addCylindre(arCoreController);
//     _addCube(arCoreController);
//   }
//
//   void _addSphere(ArCoreController controller) {
//     final material = ArCoreMaterial(
//         color: Color.fromARGB(120, 66, 134, 244));
//     final sphere = ArCoreSphere(
//       materials: [material],
//       radius: 0.1,
//     );
//     final node = ArCoreNode(
//       shape: sphere,
//       position: Vector3(0, 0, -1.5),
//     );
//     controller.addArCoreNode(node);
//   }
//
//   void _addCylindre(ArCoreController controller) {
//     final material = ArCoreMaterial(
//       color: Color(0xFFB39DDB),
//       reflectance: 1.0,
//     );
//     final cylindre = ArCoreCylinder(
//       materials: [material],
//       radius: 0.5,
//       height: 0.3,
//     );
//     final node = ArCoreNode(
//       shape: cylindre,
//       position: Vector3(0.0, -0.5, -2.0),
//     );
//     controller.addArCoreNode(node);
//   }
//
//   void _addCube(ArCoreController controller) {
//     final material = ArCoreMaterial(
//       color: Color.fromARGB(120, 66, 134, 244),
//       metallic: 1.0,
//     );
//     final cube = ArCoreCube(
//       materials: [material],
//       size: Vector3(0.5, 0.5, 0.5),
//     );
//     final node = ArCoreNode(
//       shape: cube,
//       position: Vector3(-0.5, 0.5, -3.5),
//     );
//     controller.addArCoreNode(node);
//   }
//
//   @override
//   void dispose() {
//     arCoreController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: ARView(
//         onArCoreViewCreated: _onArCoreViewCreated,
//       ),
//       // ARKitSceneView(
//       //   onARKitViewCreated: (ARKitController controller) => arView(controller),
//       // ),
//     );
//   }
// }
//
// void arView(ARKitController controller) {
//
//   final nodeAr = ARKitNode(
//     geometry: ARKitSphere(radius: 0.1),
//     position: Vector3(0,0, -0.5),
//   );
//
//   controller.add(nodeAr);
// }
