import 'package:flutter/material.dart';

class SelectTransportProblemScreen extends StatelessWidget {
  const SelectTransportProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis problemas"),
      ),
      body: _SelectTransportProblemView(),
    );
  }
}

class _SelectTransportProblemView extends StatelessWidget {
  const _SelectTransportProblemView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 10),
      child: ListView(

      ),
    );
  }
}