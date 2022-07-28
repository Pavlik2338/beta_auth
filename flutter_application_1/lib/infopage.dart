import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Информация "),
      ),
      body: const Center(
          child: Text(
              'Информа́ция   — сведения независимо от формы их представления')),
    );
  }
}
