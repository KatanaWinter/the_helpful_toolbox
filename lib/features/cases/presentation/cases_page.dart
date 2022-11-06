import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class CasesPage extends StatelessWidget {
  const CasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = getScreenWidth(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cases'),
      ),
      body: Row(
        children: [
          SidebarNavigation(screenWidth),
          const Text("Content"),
        ],
      ),
    );
  }
}
