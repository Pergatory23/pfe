import 'package:get/get.dart';

import '../helpers/helpers.dart';
import '../models/chart_filter.dart';
import '../models/chart_model.dart';
import '../services/database_meta_service.dart';
import 'dashboard_controller.dart';

enum FilterCriteria { measure, dimension, segment, time }

class FilterController extends GetxController {
  static FilterController get find => Get.find<FilterController>();

  final List<String> measureOptions = [];
  final List<String> dimensionOptions = [];
  final List<String> segmentOptions = [];
  final List<String> timeOptions = [];
  final List<String> chartOptions = ['Pie Chart', 'Table Chart', 'Line Chart', 'Scatter Chart'];
  ChartFilter _chartFilter = ChartFilter(
    index: 0,
    selectedMeasure: 'select a measure',
    selectedDimension: 'select a dimension',
    selectedSegment: 'select a segment',
    selectedTime: 'select a time',
  );
  ChartType _chartType = ChartType.pie;

  ChartFilter get chartFilter => _chartFilter;
  ChartType get chartType => _chartType;

  set chartType(ChartType chartType) {
    _chartType = chartType;
    update();
  }

  set chartFilter(ChartFilter chartFilter) {
    _chartFilter = chartFilter;
    update();
  }

  FilterController() {
    _initialize();
  }

  void _initialize() {
    // Fill all the dropdowns options
    final meta = DatabaseMetaService.find.databaseMeta;
    measureOptions.add(_chartFilter.selectedMeasure);
    dimensionOptions.add(_chartFilter.selectedDimension);
    segmentOptions.add(_chartFilter.selectedSegment);
    timeOptions.add(_chartFilter.selectedTime);
    meta?.cubes?.forEach((cube) {
      measureOptions.addAll(cube.measures!.map((e) => e.name?.toLowerCase() ?? 'null').where((element) => element != 'null').toSet());
      dimensionOptions.addAll(cube.dimensions!.map((e) => e.name?.toLowerCase() ?? 'null').where((element) => element != 'null').toSet());
      segmentOptions.addAll(cube.segments!.map((e) => e.toString().toLowerCase()).toSet());
      // How about [timeOptions] ??
    });
    // Get the last saved user filter
    chartFilter = Helpers.getSavedUserFilter(forDropdown: true);
  }

  void upsertChart(int? id) {
    Get.back();
    chartFilter.index = id ?? -1;
    DashboardController.find.upsertChart(chartFilter, chartType);
  }

  void updateFilter(FilterCriteria measure, String? value) {
    switch (measure) {
      case FilterCriteria.dimension:
        _chartFilter.selectedDimension = value ?? 'select a dimension';
        break;
      case FilterCriteria.segment:
        _chartFilter.selectedSegment = value ?? 'select a segment';
        break;
      case FilterCriteria.measure:
        _chartFilter.selectedMeasure = value ?? 'select a measure';
        break;
      case FilterCriteria.time:
        _chartFilter.selectedTime = value ?? 'select a time';
        break;
      default:
    }
    update();
  }

  void deleteChart(int? id) {
    Get.back();
    DashboardController.find.deleteChart(id);
  }

  void fetchEditableChart(int? id) {
    if (id == null) return;
    var existingChart = DashboardController.find.chartModels.singleWhere((element) => element.chartId == id);
    chartFilter = existingChart.chartFilter!.normalizeForDropdown();
    chartType = existingChart.chartType!;
    update();
  }
}
