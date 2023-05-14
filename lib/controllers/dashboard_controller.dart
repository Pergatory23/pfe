import 'dart:convert';

import 'package:dashboard/helpers/constants.dart';
import 'package:dashboard/helpers/helpers.dart';
import 'package:dashboard/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/chart_data.dart';
import '../models/chart_filter.dart';
import '../models/chart_model.dart';

const baseURL = 'http://localhost:4000/cubejs-api/v1/load?query=';

class DashboardController extends GetxController {
  static DashboardController get find => Get.find<DashboardController>();

  List<ChartModel> chartModels = [];
  ChartFilter _chartFilter = ChartFilter(index: -1);
  bool isFetchError = false;
  RxBool isLoading = false.obs;
  int index = 0;

  ChartFilter get chartFilter => _chartFilter;

  set chartFilter(ChartFilter chartFilter) {
    _chartFilter = chartFilter;
    updateView();
  }

  DashboardController() {
    _initialize();
  }

  void updateView() => WidgetsBinding.instance.addPostFrameCallback((_) => update());

  void _initialize() {
    chartFilter = Helpers.getSavedUserFilter();
    // Get user last saved dashboard if any
    var source = SharedPreferencesService.find.get(dashbordKey);
    if (source != null) {
      chartModels = (jsonDecode(source) as List).map((e) => ChartModel.fromJson(e)).toList();
      index = chartModels.length;
    }
  }

  Future<ChartModel?> _fetchData(ChartFilter chartFilter, ChartType chartType) async {
    isLoading(true);
    try {
      chartFilter = chartFilter.clean();
      isFetchError = false;
      ChartModel? result;
      final response = await http.get(Uri.parse(_buildURL(chartFilter)));
      debugPrint('Status fetch: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List<dynamic> resultSet = json.decode(response.body)['data'] as List<dynamic>;
        result = ChartModel(
          chartId: chartFilter.index,
          chartFilter: chartFilter,
          chartsData: resultSet
              .where((element) => element[chartFilter.selectedDimension] != null && element[chartFilter.selectedMeasure] != null)
              .map((result) => ChartData(result[chartFilter.selectedDimension].toString(), result[chartFilter.selectedMeasure]))
              .toList(),
          chartType: chartType,
        );
        Helpers.saveUserFilter(chartFilter);
      }
      return result;
    } catch (exception) {
      debugPrint('Error occured: $exception');
    }
    return null;
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

  Future<void> upsertChart(ChartFilter chartFilter, ChartType chartType) async {
    final chartModel = await _fetchData(chartFilter, chartType);
    if (chartFilter.index >= 0) {
      if (chartModel != null) {
        final index = chartModels.indexWhere((element) => element.chartId == chartFilter.index);
        chartModels.removeWhere((element) => element.chartId == chartFilter.index);
        chartModels.insert(index, chartModel);
      } else {
        chartModels.singleWhere((element) => element.chartId == chartFilter.index).isError = true;
      }
    } else {
      chartModel?.chartId = index++;
      chartModel?.chartFilter?.index = index;
      chartModels.add(chartModel ?? ChartModel.error());
    }
    Helpers.saveUserDashboard(chartModels);
    isLoading(false);
    update();
  }

  void deleteChart(int? id) {
    chartModels.removeWhere((element) => element.chartId == id);
    Helpers.saveUserDashboard(chartModels);
    update();
  }
}
