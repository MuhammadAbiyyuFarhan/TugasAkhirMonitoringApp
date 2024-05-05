import 'package:flutter/material.dart';

class AddReportScreen extends StatelessWidget {
  const AddReportScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Report'),
      ),
      body: const Center(
        child: Text(
          'Ini adalah layar untuk menambah laporan.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
