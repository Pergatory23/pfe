import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';


class Details extends StatefulWidget {

  final List<ChartData> chartData;
  const Details({
    Key? key,
    required this.chartData, required List pieChartData,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {


   @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    
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

      setState(() {
           
      });
    }
    
  }

  String _buildDescription() {
    if (widget.chartData.isEmpty) {
      return '';
    }

    int totalCount = 0;
    int maxCount = 0;
    String maxDimension = '';
    Map<String, int> dimensionCount = {};

    for (final data in widget.chartData) {
      final dimension = data.batiment.trim();
      final count = data.count;
      dimensionCount[dimension] = count;
     

      if (count > maxCount) {
        maxCount = count;
        maxDimension = dimension;
      }
    }

    final avgCount = totalCount / widget.chartData.length;
    final maxPercent = maxCount / totalCount * 100;
    final avgPercent = avgCount / totalCount * 100;

    final maxDescription =
        '$maxDimension est le plus représenté avec $maxCount ($maxPercent%)';
    final avgDescription =
        'en moyenne chaque élément a $avgCount ($avgPercent%)';
    final distributionDescription = dimensionCount.entries
        .map((entry) =>
            '${entry.key} représente ${entry.value} (${entry.value / totalCount * 100}%)')
        .join(', ');

    return 'Le pie chart représente la distribution des éléments par rapport à la dimension "batiment". $maxDescription, $avgDescription. Voici la distribution par élément: $distributionDescription.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF363567),
        title: Text('Details'),
      ),
      backgroundColor: Color(0xFF363567),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
        Transform.rotate(angle:1.8,
        origin: Offset(20,40),
        child:Container(
          margin: EdgeInsets.only(
            left:50,
            top:30,
            ),
            height:300,
            width: double.infinity,
            decoration: BoxDecoration
            (borderRadius:BorderRadius.circular(80),
            gradient: LinearGradient(begin: Alignment.bottomLeft,
            colors: [Color(0xffFD8BAB),Color(0xFFFD44C4)],
            ), 
            ),
            ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal:20,vertical: 70),)]),
            Text(
              _buildDescription(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
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