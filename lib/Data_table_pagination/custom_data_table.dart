import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomDataTable(myData:  [
        {
          "sno": '1',
          "age": '20',
          "name": 'John',
          "roll": '101',
          "rolls": '101',
          "rollss": '101',
          "rollsss": '101',
        },
        {
          "sno": '1',
          "age": '20',
          "name": 'John',
          "roll": '101',
          "rolls": '101',
          "rollss": '101',
          "rollsss": '101',
        },
        {
          "sno": '1',
          "age": '20',
          "name": 'John',
          "roll": '101',
          "rolls": '101',
          "rollss": '101',
          "rollsss": '101',
        },
        {
          "sno": '1',
          "age": '20',
          "name": 'John',
          "roll": '101',
          "rolls": '101',
          "rollss": '101',
          "rollsss": '101',
        },
        {
          "sno": '1',
          "age": '20',
          "name": 'John',
          "roll": '101',
          "rolls": '101',
          "rollss": '101',
          "rollsss": '101',
        },
        {
          "sno": '1',
          "age": '20',
          "name": 'John',
          "roll": '101',
          "rolls": '101',
          "rollss": '101',
          "rollsss": '101',
        },
        {
          "sno": '1',
          "age": '20',
          "name": 'John',
          "roll": '101',
          "rolls": '101',
          "rollss": '101',
          "rollsss": '101',
        },
        {
          "sno": '1',
          "age": '20',
          "name": 'John',
          "roll": '101',
          "rolls": '101',
          "rollss": '101',
          "rollsss": '101',
        },
        {
          "sno": '1',
          "age": '20',
          "name": 'John',
          "roll": '101',
          "rolls": '101',
          "rollss": '101',
          "rollsss": '101',
        },
        {
          "sno": '1',
          "age": '20',
          "name": 'John',
          "roll": '101',
          "rolls": '101',
          "rollss": '101',
          "rollsss": '101',
        },
      ],headers:['S.No','Age','Name','Roll',"'Rolls'",'Rollsss','Rollsss',]),
    );
  }
}



class CustomDataTable extends StatelessWidget {
  CustomDataTable({required this.myData,required this.headers,super.key});
  final List<Map> myData;
  final List<String> headers;

  int selectedDigit = 1;

  // Create a ScrollController to control the scrolling
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digit Selector'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DataTable(
              decoration: BoxDecoration(
                // Add a BoxDecoration for the DataTable
                border: Border.all(color: Colors.grey), // Border for the table
              ),
              showBottomBorder: true,
              columns: <DataColumn>[
                DataColumn(
                  label: Text(headers[0]),
                ),
                DataColumn(
                  label: Text(headers[1]),
                ),
                DataColumn(
                  label: Text(headers[2]),
                ),
                DataColumn(
                  label: Text(headers[3]),
                ),
                DataColumn(
                  label: Text(headers[4]),
                ),
                DataColumn(
                  label: Text(headers[5]),
                ),
                DataColumn(
                  label: Text(headers[6]),
                ),
              ],
              rows: [
                for (int i = 0; i < myData.length; i++)
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text("${i + 1}")),
                      DataCell(Text("${myData[i]["age"]}")),
                      DataCell(Text("${myData[i]["name"]}")),
                      DataCell(Text("${myData[i]["roll"]}")),
                      DataCell(Text("${myData[i]["rolls"]}")),
                      DataCell(Text("${myData[i]["rollss"]}")),
                      DataCell(Text("${myData[i]["rollsss"]}")),
                      // DataCell(Text("${i["sno"]}")),
                    ],
                  ),
                // Add more rows here
              ],
            ),
            StatefulBuilder(
              builder:(context,setState)=> Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (selectedDigit > 1) {
                          setState(() {
                            selectedDigit--;
                          });
                          _scrollToCenter(selectedDigit);
                        }
                      },
                      icon: Icon(Icons.arrow_back_ios_new)),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          width: 280,
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(30, (index) {
                              final digit = index + 1;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDigit = digit;
                                  });
                                  // Scroll to the selected digit and keep it centered
                                  _scrollToCenter(digit);
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedDigit == digit
                                          ? Colors.green
                                          : Colors.grey),
                                  child: Center(
                                    child: Text(
                                      digit.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (30 > selectedDigit) {
                          selectedDigit++;
                          setState(() {});
                          _scrollToCenter(selectedDigit);
                        }
                      },
                      icon: Icon(Icons.arrow_forward_ios_sharp))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToCenter(int digit) {
    // Calculate the offset to center the selected digit
    const itemWidth = 40.0;
    const viewportWidth = 280;
    final targetOffset =
        (digit - 1) * itemWidth - (viewportWidth - itemWidth) / 2;
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}

