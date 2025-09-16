import 'package:flutter/material.dart';
import 'lawyer_controller.dart';

class LawyerView extends StatelessWidget {
  const LawyerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lawyer')),
      body: const Center(child: Text('Lawyer Module')), // TODO: Implement lawyer features
    );
  }
}

