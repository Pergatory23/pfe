import 'dart:convert';

import 'package:dashboard/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/chart_data.dart';
import '../models/chart_filter.dart';

const baseURL = 'http://localhost:4000/cubejs-api/v1/load?query=';

class DashboardController extends GetxController {
  static DashboardController get find => Get.find<DashboardController>();

  List<ChartData> chartData = [];
  ChartFilter _chartFilter = ChartFilter();
  bool isFetchError = false;

  ChartFilter get chartFilter => _chartFilter;

  set chartFilter(ChartFilter chartFilter) {
    _chartFilter = chartFilter;
    _fetchData(_chartFilter);
  }

  DashboardController() {
    _initialize();
  }

  void updateView() => WidgetsBinding.instance.addPostFrameCallback((_) => update());

  void _initialize() => chartFilter = Helpers.getSavedUserFilter();

  Future<void> _fetchData(ChartFilter chartFilter) async {
    try {
      isFetchError = false;
      final response = await http.get(Uri.parse(_buildURL(chartFilter)));
      debugPrint('Status fetch: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List<dynamic> resultSet = json.decode(response.body)['data'] as List<dynamic>;
        chartData = resultSet
            .where((element) => element[chartFilter.selectedDimension] != null && element[chartFilter.selectedMeasure] != null)
            .map((result) => ChartData(result[chartFilter.selectedDimension].toString(), result[chartFilter.selectedMeasure]))
            .toList();
        Helpers.saveUserFilter(chartFilter);
      } else {
        chartData = [];
        isFetchError = true;
      }
      updateView();
    } catch (exception) {
      debugPrint('Error occured: $exception');
    }
  }

  String _buildURL(ChartFilter chartFilter) {
    final query = {
      if (chartFilter.selectedMeasure.isNotEmpty) 'measures': [chartFilter.selectedMeasure],
      if (chartFilter.selectedDimension.isNotEmpty) 'dimensions': [chartFilter.selectedDimension],
      if (chartFilter.selectedSegment.isNotEmpty) 'segments': [chartFilter.selectedSegment],
      if (chartFilter.selectedTime.isNotEmpty) 'time': [chartFilter.selectedTime],
    };
    final encodedQuery = Uri.encodeComponent(jsonEncode(query));
    final url = '$baseURL$encodedQuery';
    debugPrint(Uri.decodeFull(url));
    return url;
  }
}
