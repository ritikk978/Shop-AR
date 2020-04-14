import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AR extends StatefulWidget {
  @override
  _ARState createState() => _ARState();
}

class _ARState extends State<AR> {
  ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Core'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addEarth(arCoreController);
  }

  void _addEarth(ArCoreController controller) async {
    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes:
          (await rootBundle.load('assets/ar/earth.jpg')).buffer.asUint8List(),
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.5,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
