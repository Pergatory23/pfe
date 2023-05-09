import 'dart:convert';
import 'dart:io';
import 'package:dashboard/Dashboardhomepage.dart';
import 'package:dashboard/details.dart';
import 'package:dashboard/menu.dart';
import 'package:dashboard/screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<ChartData> _chartData = [];
   List<Map<dynamic, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try{
    final response = await http.post(
          Uri.parse('http://10.0.2.2:4000/cubejs-api/v1/load'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '5ac8bab52594374aaa5d1ae5fa37423dbff09fa7512ea484ff0a0dc8a4618162db7a05d7edaf12974530dd1b3f9bfd959a9c45f5f3740c999f5ef4fc2502bcbd'
      },
      body: json.encode({
      'query': {
        "measures": [
          "g_caisse_article.count"
        ],

        "dimensions": [
          "g_caisse_article.batiment"
        ]
      }
    })

      );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> resultSet = data['data'] as List<dynamic>;
      

      setState(() {
        _chartData = resultSet
            .map((result) =>
            ChartData(
              result['g_caisse_article.batiment'],
              result['g_caisse_article.count'],
            ))
            .toList();
           
      });
    }
    }
    on SocketException catch (error) {
      print('socket');
    } on HttpException catch (error) {
      print('http');
    }
    catch(exception){}
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xFF363567),
      title: const Text('Dashboard'),
    ),
    body: _chartData.isEmpty
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : SingleChildScrollView(
          child: GridView.count(
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Details(chartData: [], pieChartData: [],)),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: PieChart(
                    PieChartData(
                      sections: _chartData
                          .map(
                            (data) => PieChartSectionData(
                              title: data.batiment.trim(),
                              badgeWidget: Container(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Text(data.count.toString())),
                              color: HexColor(data.PALE_COLORS_SERIES[
                                  _chartData.indexOf(data)]),
                            ),
                          )
                          .toList(),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 1,
                      centerSpaceRadius: 30,
                      startDegreeOffset: 120,
                      centerSpaceColor: Colors.white,
                      pieTouchData: PieTouchData(),
                  ),
                ),),),
                GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Details(chartData: [], pieChartData: [],)),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child:
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Count')),
                  ],
                  rows: _chartData
                      .map((data) => DataRow(cells: [
                            DataCell(Text(data.batiment)),
                            DataCell(Text(data.count.toString())),
                          ]))
                      .toList(),
                ),)),
                         GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Details(chartData: [], pieChartData: [],)),
                  );
                },
                
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child:
                LineChart(
  LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
      ),
    
      handleBuiltInTouches: true,
    ),
    gridData: FlGridData(
      show: true,
      checkToShowHorizontalLine: (double value) => value % 10 == 0,
      getDrawingHorizontalLine: (double value) => FlLine(
        color: Colors.grey,
        strokeWidth: 0.5,
      ),
      drawVerticalLine: true,
      horizontalInterval: 10,
    ),
    titlesData: FlTitlesData(
      
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: Colors.grey),
    ),
    lineBarsData: [
      LineChartBarData(
        spots: _chartData
            .asMap()
            .map((index, data) => MapEntry(
                  index,
                  FlSpot(
                    index.toDouble(),
                    data.count.toDouble(),
                  ),
                ))
            .values
            .toList(),
        isCurved: true,
        color: Colors.blue,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (FlSpot spot, double percent, LineChartBarData bar, int index) =>
            FlDotCirclePainter(
              radius: 4,
              color: Colors.blue,
            ),
        ),
      ),
    ],
  ),
))),
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Details(chartData: [], pieChartData: [],)),
    );
  },
  child: Container(
    padding: const EdgeInsets.all(8),
    child: ScatterChart(
      ScatterChartData(
        scatterSpots: _chartData
          .map(
            (data) => ScatterSpot(
              data.count.toDouble(),
              _chartData.indexOf(data).toDouble(),
              color: HexColor(data.PALE_COLORS_SERIES[_chartData.indexOf(data)]),
            ),
          )
          .toList(),
        minX: 0,
        maxX: _chartData.length.toDouble() - 1,
        minY: 0,
        maxY: _chartData.length.toDouble() - 1,
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
         
        ),
      ),
    ),
  ),
),
                
              ],
            ),
            
          ),
           floatingActionButton: FloatingActionButton(
       onPressed: () =>
          Navigator.push(context, MaterialPageRoute(builder: (
              context) => CubePage()),),
    backgroundColor:const Color(0xFF373856) ,
              
    child: const Text('Filtrer'),
    ),
      drawer: DashboardMenu(
        menuItems: const [ 'Accueil','Déconnexion', ],
      ),
    );
  
}
}
class ChartData {
  final String batiment;
  final int count;
  final PALE_COLORS_SERIES = [
    '#5b8ff9',
    '#5ad8a6',
    '#5e7092',
    '#f6bd18',
    '#6f5efa',
    '#6ec8ec',
    '#945fb9',
    '#ff9845',
    '#299796',
    '#fe99c3',
  ];

  ChartData(this.batiment, this.count);
}
class DashboardMenu extends StatelessWidget {
  final List<String> menuItems;

  DashboardMenu({required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF363567),
            ),
            child: Text(
              'Dashboard Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          for (var item in menuItems)
            ListTile(
              title: Text(item),
              onTap: () {
                Navigator.pop(context); // fermer le menu
                switch (item) {
                  case 'Accueil':
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => Menu()));
                    break;

                  case 'Déconnexion':
                  Navigator.push(context, MaterialPageRoute(builder: (
                        context) => DashboardHomePage()));
                    break;
                  default:
                  // TODO: gérer les autres cas
                    break;
                }
              },
            ),
        ],
      ),
    );
  }}