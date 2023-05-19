import 'package:dashboard/models/database_meta.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

const hostname = 'http://localhost:4000/cubejs-api/v1/';

class DatabaseMetaService extends GetxService {
  static DatabaseMetaService get find => Get.find<DatabaseMetaService>();

  DatabaseMeta? databaseMeta;

  DatabaseMetaService() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('${hostname}meta'),
      );

      if (response.statusCode == 200) {
        databaseMeta = decodeMetaFromJson(response.body);
      }
    } catch (exception) {
      debugPrint('Error occured: $exception');
    }
  }
}
