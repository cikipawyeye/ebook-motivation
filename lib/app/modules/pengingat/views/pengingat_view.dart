import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengingat_controller.dart';

class PengingatView extends GetView<PengingatController> {
  const PengingatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PengingatView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PengingatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
