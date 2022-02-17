import 'package:flutter/material.dart';
import 'package:true_flutter/src/presentation/map/views/map_screen_view.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MapScreenView(),
    );
  }
}