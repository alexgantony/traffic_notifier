import "package:flutter/material.dart";

class AddRoutePage extends StatelessWidget {
  const AddRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Route"),
      ),
      body: Padding(padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Route form goes here")
        ],
      ),
      ),
    );
  }
}  
