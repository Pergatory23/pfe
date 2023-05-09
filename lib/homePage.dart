import 'package:dashboard/home.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  const Home({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Row(
            children: [
              ElevatedButton(
                  onPressed: loadData,
                  child: const Text('Press')),
              ElevatedButton(
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => DashboardScreen())),
                child: const Text('Dashboard'),)
            ]));
  }

  loadData() async {
    var body = json.encode({
      'query': {"measures": [
        "Orders.count"
      ],
        "dimensions": [
          "Orders.status"
        ]}
    });

    var response = await http.post(
      Uri.parse('http://localhost:4000/cubejs-api/v1/load'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '754ad8795c14373da0cae65956e5cdea5f5f45d7f143bf6c602cdad4d765d9f230919d35e07e18e567f860bbfb3058ff02c6c950f935118017e8df042fe8ae32'
      },
      body: body,
    );

    print(json.decode(response.body));
    return json.decode(response.body);
  }
}


