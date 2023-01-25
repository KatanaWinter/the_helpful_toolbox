import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DataTableTable extends StatefulWidget {
  const DataTableTable({Key? key}) : super(key: key);

  @override
  State<DataTableTable> createState() => _DataTableTableState();
}

class _DataTableTableState extends State<DataTableTable> {
  // Liste der Cols und Liste der Rows als Zwschenspeicher

  // ToDo
  final List<Map> _rows = [
    {
      'active': "1",
      'id': "#00001",
      'client': 'Kevin Winter',
      'contact': 'info@helpfultoolbox.com',
      'property': '123 Teststreet'
    },
    {
      'active': "1",
      'id': "#00002",
      'client': 'Vanessa Winter',
      'contact': 'office@perks-llc.com',
      'property': '123 Teststreet'
    },
    {
      'active': "0",
      'id': "#00003",
      'client': 'Harold Ford',
      'contact': '+1 758 555 321',
      'property': 'Mercedes Road 9045'
    },
  ];
  TextEditingController searchTextController = TextEditingController();
  late List<dynamic> _filteredRows = [];
  String _searchResult = '';

  @override
  void initState() {
    super.initState();
    _filteredRows = _rows;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Row(
                children: [
                  Flexible(
                    child: ListTile(
                      leading: const Icon(Icons.search),
                      title: TextField(
                          controller: searchTextController,
                          decoration: const InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                          onChanged: (value) {
                            setState(() {
                              _searchResult = value;
                              _filteredRows = _rows
                                  .where((rowVal) => (rowVal
                                          .toString()
                                          .toUpperCase())
                                      .contains(_searchResult.toUpperCase()))
                                  .toList();
                            });
                          }),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          setState(() {
                            searchTextController.clear();
                            _searchResult = '';
                            _filteredRows = _rows;
                          });
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        createNew();
                      },
                      child: const Text("New"))
                ],
              ),
            ),
            DataTable2(
              minWidth: 900,
              columns: createColumns(),
              empty: Center(
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.grey[200],
                      child: const Text('No data'))),
              rows: createRows(),
            ),
          ],
        ),
      );
    });
  }

  createColumns() {
    // ToDo
    List<DataColumn> dCols = const [
      DataColumn2(label: Text("Active"), size: ColumnSize.S),
      DataColumn2(label: Text("ID"), size: ColumnSize.S),
      DataColumn2(label: Text("Client"), size: ColumnSize.M),
      DataColumn2(label: Text("Contact"), size: ColumnSize.M),
      DataColumn2(label: Text("Property"), size: ColumnSize.L),
      DataColumn2(label: Text("Buttons"), size: ColumnSize.M),
    ];
    return dCols;
  }

  createRows() {
    // ToDo
    List<DataRow> dRows = _filteredRows
        .map((val) => DataRow(cells: [
              DataCell(Padding(
                padding: const EdgeInsets.all(2.0),
                child: val["active"] != "1"
                    ? Container(
                        color: Colors.red,
                      )
                    : Container(color: Colors.green),
              )),
              DataCell(Text(val['id'])),
              DataCell(Text(val['client'])),
              DataCell(Text(val['contact'])),
              DataCell(Text(val['property'])),
              DataCell(Row(
                children: [
                  IconButton(
                      onPressed: () {
                        openEntry(val['id']);
                      },
                      icon: Icon(
                        Icons.open_in_new,
                        color: Colors.blue[400],
                      )),
                  IconButton(
                      onPressed: () {
                        editEntry(val['id']);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.brown,
                      )),
                  IconButton(
                      onPressed: () {
                        deleteEntry(val['id']);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ))
            ]))
        .toList();
    return dRows;
  }

  // ToDo
  void createNew() {}

  void openEntry(val) {}

  void editEntry(val) {}

  void deleteEntry(val) {}
}
