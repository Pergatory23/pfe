import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CubePage extends StatefulWidget {
  const CubePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CubePageState createState() => _CubePageState();
}
loadData() async {
    var body = json.encode({
      'query': {
          "measures": ['*'],
          "dimensions": ['*']
        }
    });
    var response = await http.post(
      Uri.parse('http://localhost:4000/cubejs-api/v1/load'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'e5a61dac30b461cea8068147cc7c207f2ab231ec520deadc29876f4d08b8e1283b8c290dac9aa837c3d8c810df9133a3357bfc9232c7ff7dc9756079801dcaa6'
      },
      body: body,
    );

    print(json.decode(response.body));
    return json.decode(response.body);
  }
class _CubePageState extends State<CubePage> {
  String _selectedMeasure='';
  String _selectedDimension='';
  String _selectedSegment='';
  String _selectedTime='';

  List<String> _measures = [];
  List<String> _dimensions = [];
  List<String> _segments = [];
  List<String> _times = [];
  
  Future<void> _fetchData() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:4000/cubejs-api/v1/load'),
      body: json.encode({
        'query': {
          "measures": ['*'],
          "dimensions": ['*'],
        }
      }),
    );

    final data = json.decode(response.body);

    setState(() {
      _dimensions = List<String>.from(data['query']?['dimensions']?.map((dimension) => dimension['dimension'].toString()) ?? []);
      _segments = List<String>.from(data['query']?['segments']?.map((segments) => segments['segments'].toString()) ?? []);
      _times = List<String>.from(data['query']?['timeDimensions']?.map((timeDimensions) => timeDimensions['dimension'].toString()) ?? []);

      if (data['query']?['measures'] != null) {
        final List<dynamic> measures = data['query']!['measures']!;
        _measures = List<String>.from(measures.map((measure) => measure['title'].toString()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF363567),
        title: Text('Filtrer'),
      ),
      backgroundColor: Color(0xFF363567),
      body:SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            _buildSectionTitle('MEASURES'),
            _buildDropdownButton(_measures, _selectedMeasure, (value) {
              setState(() {
                _selectedMeasure = value.toString();
              });
            }),
            SizedBox(height: 16.0),
            _buildSectionTitle('DIMENSIONS'),
            _buildDropdownButton(_dimensions, _selectedDimension, (value) {
              setState(() {
                _selectedDimension = value.toString();
              });
            }),
            SizedBox(height: 16.0),
            _buildSectionTitle('SEGMENT'),
            _buildDropdownButton(_segments, _selectedSegment, (value) {
              setState(() {
                _selectedSegment = value.toString();
              });
            }),
            SizedBox(height: 16.0),
            _buildSectionTitle('TIME'),
            _buildDropdownButton(_times, _selectedTime, (value) {
              setState(() {
                _selectedTime = value.toString();
              });
            }),
            SizedBox(height: 16.0),
           ElevatedButton(
  onPressed: () {
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white, // couleur du bouton
  ),
  child: const Text(
    'Apply Filters',
    style: TextStyle(
      color: Color(0xFF363567), // couleur du texte
    ),
  ),
),
           ElevatedButton(
  onPressed: loadData,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white, // Couleur de fond du bouton
  ),
  child: const Text('Press', style: TextStyle(color: Color(0xFF363567))), // Couleur du texte du bouton
)
          ],

        ),
      ),
    ));
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDropdownButton(List<String> options, String? value, void Function(String?)? onChanged) {
    return DropdownButton<String>(
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option, style: TextStyle(color: Colors.grey)), // <-- Ajouter style ici
        );
      }).toList(),
     value: value,
      hint: Text('Select an option', style: TextStyle(color: Colors.grey)), // <-- Ajouter style ici
      isExpanded: true,
      underline: Container(
        height: 1,
        color: Colors.grey[400],
      ),
      onChanged: onChanged,
    );
  }
}