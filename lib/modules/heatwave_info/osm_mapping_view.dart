import 'package:flutter/material.dart';

class OsmMappingView extends StatelessWidget {
  const OsmMappingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ওএসএম ম্যাপিং')), // OSM Mapping
      body: const Center(
        child: Text(
          'এখানে OpenStreetMap (OSM) ম্যাপিং ফিচার আসবে।\n\n(ডেমো কন্টেন্ট)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

