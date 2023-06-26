import 'dart:io';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart';

class LocalAndWebObjectsWidget extends StatefulWidget {
  const LocalAndWebObjectsWidget({super.key});

  @override
  State<LocalAndWebObjectsWidget> createState() =>
      _LocalAndWebObjectsWidgetState();
}

class _LocalAndWebObjectsWidgetState extends State<LocalAndWebObjectsWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;

  //String localObjectReference;
  ARNode? localObjectNode;

  //String webObjectReference;
  ARNode? webObjectNode;
  ARNode? fileSystemNode;
  HttpClient? httpClient;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local & Web Objects'),
      ),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(
                //         onPressed: onFileSystemObjectAtOriginButtonPressed,
                //         child: Text("Add/Remove Filesystem\nObject at Origin")),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: onWebObjectAtOriginButtonPressed,
                      child: const Text("Add/Remove Web\nObject at Origin"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          customPlaneTexturePath: "Images/triangle.png",
          showWorldOrigin: true,
          handleTaps: false,
        );
    this.arObjectManager!.onInitialize();

    //Download model to file system
    httpClient = HttpClient();
    // _downloadFile(
    //     "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb",
    //     "LocalDuck.glb");
  }

  // Future<File> _downloadFile(String url, String filename) async {
  //   var request = await httpClient!.getUrl(Uri.parse(url));
  //   var response = await request.close();
  //   var bytes = await consolidateHttpClientResponseBytes(response);
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   File file = File('$dir/$filename');
  //   await file.writeAsBytes(bytes);
  //   print("Downloading finished, path: " + '$dir/$filename');
  //   return file;
  // }

  // Future<void> _downloadAndUnpack(String url, String filename) async {
  //   var request = await httpClient!.getUrl(Uri.parse(url));
  //   var response = await request.close();
  //   var bytes = await consolidateHttpClientResponseBytes(response);
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   File file = File('$dir/$filename');
  //   await file.writeAsBytes(bytes);
  //   print("Downloading finished, path: " + '$dir/$filename');
  //
  //   // To print all files in the directory: print(Directory(dir).listSync());
  //   try {
  //     await ZipFile.extractToDirectory(
  //         zipFile: File('$dir/$filename'), destinationDir: Directory(dir));
  //     print("Unzipping successful");
  //   } catch (e) {
  //     print("Unzipping failed: $e");
  //   }
  // }

  Future<void> onWebObjectAtOriginButtonPressed() async {
    if (webObjectNode != null) {
      arObjectManager!.removeNode(webObjectNode!);
      webObjectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri:
              "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/VC/glTF-Binary/VC.glb",
          scale: Vector3(0.2, 0.2, 0.2));
      bool? didAddWebNode = await arObjectManager!.addNode(newNode);
      webObjectNode = (didAddWebNode!) ? newNode : null;
    }
  }

// Future<void> onFileSystemObjectAtOriginButtonPressed() async {
//   if (this.fileSystemNode != null) {
//     this.arObjectManager!.removeNode(this.fileSystemNode!);
//     this.fileSystemNode = null;
//   } else {
//     var newNode = ARNode(
//         type: NodeType.fileSystemAppFolderGLB,
//         uri: "LocalDuck.glb",
//         scale: Vector3(0.2, 0.2, 0.2));
//     //Alternative to use type fileSystemAppFolderGLTF2:
//     //var newNode = ARNode(
//     //    type: NodeType.fileSystemAppFolderGLTF2,
//     //    uri: "Chicken_01.gltf",
//     //    scale: Vector3(0.2, 0.2, 0.2));
//     bool? didAddFileSystemNode = await this.arObjectManager!.addNode(newNode);
//     this.fileSystemNode = (didAddFileSystemNode!) ? newNode : null;
//   }
// }
}
