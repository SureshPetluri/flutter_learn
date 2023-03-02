import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main()async  {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExpandTable(),
    );
  }
}

class ExpandTable extends StatefulWidget {
  const ExpandTable({Key? key}) : super(key: key);

  @override
  State<ExpandTable> createState() => _ExpandTableState();
}

class _ExpandTableState extends State<ExpandTable> {
  bool isEqual = true;
  int? indexEqual;
  int? preIndex;
  double tableHeight = 0;
  double constTableHeight = 50;
  double expansionTableHeight = 250;
  bool _isExpanded = false;

  expandHeight(int index) {
    isEqual = true;
  }
  final box = GetStorage();

  List<Map<String, dynamic>> tableList = [
    {"name": "John", "role": "Lead  developer", "experience": "8"},
    {"name": "Suresh", "role": "Lead  developer", "experience": "8"},
    {"name": "Kalyan", "role": "Lead  developer", "experience": "8"},
    {"name": "Shiva", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ram", "role": "Lead  developer", "experience": "8"},
    {"name": "Ramachandra", "role": "Lead  developer", "experience": "8"}
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            indexEqual != null && _isExpanded
                ? Positioned(
                    top: tableHeight,
                    right: MediaQuery.of(context).size.width * 0.4,
                    child: const Text(
                      "Table Expansion",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ))
                : SizedBox(),
            Table(
              children: [
                const TableRow(children: [
                  Text("S.No"),
                  Text("Name"),
                  Text("Role"),
                  Text("Experience"),
                ]),
                for (int i = 0; i < tableList.length; i++)
                  TableRow(
                    children: [
                      GestureDetector(
                        child: Container(
                            color: Colors.grey,
                            height: indexEqual == i && _isExpanded
                                ? expansionTableHeight
                                : constTableHeight,
                            child: Text("$i")),
                        onTapDown: (TapDownDetails details) {
                          box.write('quote', indexEqual);
                         setState(() {
                            indexEqual = i;
                         });
                          tableHeight = (i * constTableHeight) +
                              expansionTableHeight * 0.5;
                          box.read('quote') != i?_isExpanded = true:_isExpanded = !_isExpanded;
                          if (kDebugMode) {
                            print(
                                "index ${details.globalPosition.dy},,,,${details.globalPosition.dx}");
                          }
                        },
                      ),
                      Text("${tableList[i]["name"]} "),
                      Text("${tableList[i]["role"]} "),
                      Text("${tableList[i]["experience"]} "),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*
Table(
children: [
TableRow(
children: [
TableCell(
child: TableRowInkWell(
onTap: () {
setState(() {
_isExpanded = !_isExpanded;
});
},
child: Container(
padding: EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Cell content'),
// if (_isExpanded ) Text('Expanded content'),
],
),
),
),
),
TableCell(
child: TableRowInkWell(
onTap: () {
setState(() {
_isExpanded = !_isExpanded;
});
},
child: Container(
padding: EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Cell content'),
// if (_isExpanded) Text('Expanded content'),
],
),
),
),
),
TableCell(
child: TableRowInkWell(
onTap: () {
setState(() {
_isExpanded = !_isExpanded;

});
},
child: Container(
padding: EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Cell content'),
// if (_isExpanded) Text('Expanded content'),
],
),
),
),
),
TableCell(
child: TableRowInkWell(
onTap: () {
setState(() {
_isExpanded = !_isExpanded;

});
},
child: Container(
padding: EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Cell content'),
// if (_isExpanded) Text('Expanded content'),
],
),
),
),
),
],
),
for(int i=0;i<10;i++)
TableRow(
children: [
TableCell(
child: TableRowInkWell(
onTap: () {
setState(() {
_isExpanded = !_isExpanded;
indexEqual = i;
});
},
child: Container(
padding: EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Cell content'),
if (_isExpanded && indexEqual== i) Text('Expanded content$i'),
],
),
),
),
),
TableCell(
child: TableRowInkWell(
onTap: () {
setState(() {
_isExpanded = !_isExpanded;
indexEqual = i;
});
},
child: Container(
padding: EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Cell content$i'),
if (_isExpanded && indexEqual== i) Text('Expanded content$i'),
],
),
),
),
),
TableCell(
child: TableRowInkWell(
onTap: () {
setState(() {
_isExpanded = !_isExpanded;
indexEqual = i;
});
},
child: Container(
padding: EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Cell content$i'),
if (_isExpanded&& indexEqual== i) Text('Expanded content$i'),
],
),
),
),
),
TableCell(
child: TableRowInkWell(
onTap: () {
setState(() {
_isExpanded = !_isExpanded;
indexEqual = i;
});
},
child: Container(
padding: EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Cell content $i'),
if (_isExpanded&& indexEqual== i) Text('Expanded content $i'),
],
),
),
),
),
],
),
],
)*/
