import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
      ),
      body: Row(
        children: [
          SidebarNavigation(),
          const Text("Content"),
        ],
      ),
    );
  }
}
