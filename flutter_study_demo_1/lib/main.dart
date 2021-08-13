import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '奥运奖牌榜 TOP10',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '奥运奖牌榜 TOP10'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// Medal Info
class MedalInfo {
  String country = '';
  Image flag;
  int gold = 0;
  int silver = 0;
  int bronze = 0;
  int total = 0;
  //bool selected = false;

  MedalInfo(this.country, this.flag, this.gold, this.silver, this.bronze) {
    this.country = country;
    this.flag = flag;
    this.gold = gold;
    this.silver = silver;
    this.bronze = bronze;
    this.total = gold + silver + bronze;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  void _refreshMedalInfo() {
    //TODO
  }


  List<MedalInfo> medalList = [
    // TOP 1-5
    MedalInfo('美国', Image.asset('image/image_1.png', width: 20, height: 10, fit: BoxFit.fill, ), 39, 41, 33),
    MedalInfo('中国', Image.asset('image/image_2.png', width: 20, height: 10, fit: BoxFit.fill, ), 38, 32, 18),
    MedalInfo('日本', Image.asset('image/image_3.png', width: 20, height: 10, fit: BoxFit.fill, ), 27, 14, 17),
    MedalInfo('英国', Image.asset('image/image_4.png', width: 20, height: 10, fit: BoxFit.fill, ), 22, 21, 22),
    MedalInfo('俄罗斯奥委会', Image.asset('image/image_5.png', width: 20, height: 10, fit: BoxFit.fill, ), 20, 28, 23),

    // TOP 6-10
    MedalInfo('澳大利亚', Image.asset('image/image_6.png', width: 20, height: 10, fit: BoxFit.fill, ), 17, 7, 22),
    MedalInfo('荷兰', Image.asset('image/image_7.png', width: 20, height: 10, fit: BoxFit.fill, ), 10, 12, 11),
    MedalInfo('法国', Image.asset('image/image_8.png', width: 20, height: 10, fit: BoxFit.fill, ), 10, 12, 11),
    MedalInfo('德国', Image.asset('image/image_9.png', width: 20, height: 10, fit: BoxFit.fill, ), 10, 11, 16),
    MedalInfo('意大利', Image.asset('image/image_10.png', width: 20, height: 10, fit: BoxFit.fill, ), 10, 10, 20),
  ];

  int _currentSortColumn = 1;
  bool _sortAscending = true;

  List<DataRow> _getMedalInfoRows(double screenWidth) {
    List<DataRow> dataRows = [];
    //for (int i = 0; i < medalList.length; i++) {
    for (MedalInfo eachItem in medalList) {
      dataRows.add(
          DataRow(
              cells: [
                DataCell(
                  Container (
                      child: Text(
                        eachItem.country,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                DataCell(
                  Container (
                      width: screenWidth / 30,
                      child: eachItem.flag),
                ),
                DataCell(
                  Container (
                      width: screenWidth / 10,
                      child: Text(
                        eachItem.gold.toString(),
                        textAlign: TextAlign.center,
                      )),
                ),
                DataCell(
                  Container (
                      width: screenWidth / 10,
                      child: Text(
                        eachItem.silver.toString(),
                        textAlign: TextAlign.center,
                      )),
                ),
                DataCell(
                  Container (
                      width: screenWidth / 10,
                      child: Text(
                        eachItem.bronze.toString(),
                        textAlign: TextAlign.center,
                      )),
                ),
                DataCell(
                  Container (
                      width: screenWidth / 10,
                      child: Text(
                        eachItem.total.toString(),
                        textAlign: TextAlign.center,
                      )),
                ),
              ]
          )
      );
    }

    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Icon(Icons.menu),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '刷新',
            onPressed: _refreshMedalInfo,
          ),
        ],
        elevation: 0.0,
        centerTitle: true,
      ),
      body:  Container(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              sortColumnIndex: _currentSortColumn,
              sortAscending: _sortAscending,
              dataRowHeight: 60,
              horizontalMargin: 12,
              columnSpacing: 12,
              columns: [
                DataColumn(
                    label: Container (
                      width: screenWidth / 6,
                      child: Text('国家/地区'),
                    )
                ),
                DataColumn(label: Text('')),
                DataColumn(
                    label: Container (
                      width: screenWidth / 10,
                      child: Text(
                        '金牌',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        _sortAscending = ascending;
                        if (ascending) {
                          medalList.sort((a, b) => a.gold.compareTo(b.gold));
                        } else {
                          medalList.sort((a, b) => b.gold.compareTo(a.gold));
                        }
                      });
                    }
                ),
                DataColumn(
                    label: Container (
                      width: screenWidth / 10,
                      child: Text(
                        '银牌',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        _sortAscending = ascending;
                        if (ascending) {
                          medalList.sort((a, b) => a.silver.compareTo(b.silver));
                        } else {
                          medalList.sort((a, b) => b.silver.compareTo(a.silver));
                        }
                      });
                    }
                ),
                DataColumn(
                    label: Container (
                      width: screenWidth / 10,
                      child: Text(
                        '铜牌',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        _sortAscending = ascending;
                        if (ascending) {
                          medalList.sort((a, b) => a.bronze.compareTo(b.bronze));
                        } else {
                          medalList.sort((a, b) => b.bronze.compareTo(a.bronze));
                        }
                      });
                    }
                ),
                DataColumn(
                    label: Container (
                      width: screenWidth / 10,
                      child: Text(
                        '总数',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) {
                      setState(() {
                        _currentSortColumn = columnIndex;
                        _sortAscending = ascending;
                        if (ascending) {
                          medalList.sort((a, b) => a.total.compareTo(b.total));
                        } else {
                          medalList.sort((a, b) => b.total.compareTo(a.total));
                        }
                      });
                    }
                ),
              ],
              rows: _getMedalInfoRows(screenWidth),
            )
        ),
      ),
    );
  }
}
