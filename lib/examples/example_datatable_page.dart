import 'package:flutter/material.dart';
import 'package:the_helpful_toolbox/examples/example_datatable.dart';
import 'package:the_helpful_toolbox/features/navigation/presentation/sidebarnav.dart';

class DataTableExamplePage extends StatelessWidget {
  const DataTableExamplePage({Key? key}) : super(key: key);

  final String appBarTitle = "Datatable Example";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: SidebarDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Datatable Example'),
      ),
      body: Row(
        children: [
          SidebarNavigation(),
          const Flexible(child: DataTableTable()),
        ],
      ),
    );
  }
}
