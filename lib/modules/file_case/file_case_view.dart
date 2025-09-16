import 'package:flutter/material.dart';
import 'file_case_controller.dart';

class FileCaseView extends StatelessWidget {
  const FileCaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File a Case')),
      body: const Center(child: Text('File a Case Module')), // TODO: Implement file a case features
    );
  }
}

