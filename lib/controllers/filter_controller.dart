import 'package:dashboard/controllers/dashboard_controller.dart';
import 'package:dashboard/models/chart_filter.dart';
import 'package:get/get.dart';

import '../helpers/helpers.dart';
import '../services/database_meta_service.dart';

enum FilterCriteria { measure, dimension, segment, time }

class FilterController extends GetxController {
  static FilterController get find => Get.find<FilterController>();

  final List<String> measureOptions = [];
  final List<String> dimensionOptions = [];
  final List<String> segmentOptions = [];
  final List<String> timeOptions = [];
  ChartFilter _chartFilter = ChartFilter(
    selectedMeasure: 'select a measure',
    selectedDimension: 'select a dimension',
    selectedSegment: 'select a segment',
    selectedTime: 'select a time',
  );

  ChartFilter get chartFilter => _chartFilter;

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
    measureOptions.add(chartFilter.selectedMeasure);
    dimensionOptions.add(chartFilter.selectedDimension);
    segmentOptions.add(chartFilter.selectedSegment);
    timeOptions.add(chartFilter.selectedTime);
    meta?.cubes?.forEach((cube) {
      measureOptions.addAll(cube.measures!.map((e) => e.name?.toLowerCase() ?? 'null').where((element) => element != 'null').toSet());
      dimensionOptions.addAll(cube.dimensions!.map((e) => e.name?.toLowerCase() ?? 'null').where((element) => element != 'null').toSet());
      segmentOptions.addAll(cube.segments!.map((e) => e.toString().toLowerCase()).toSet());
      // How about [timeOptions] ??
    });
    // Get the last saved user filter
    chartFilter = Helpers.getSavedUserFilter(forDropdown: true);
  }

  void filterData() {
    // Request a new filter and go back to the dashboard screen
    Get.back();
    DashboardController.find.chartFilter = chartFilter.clean();
  }

  updateFilter(FilterCriteria measure, String? value) {
    switch (measure) {
      case FilterCriteria.dimension:
        chartFilter.selectedDimension = value ?? 'select a dimension';
        break;
      case FilterCriteria.segment:
        chartFilter.selectedSegment = value ?? 'select a segment';
        break;
      case FilterCriteria.measure:
        chartFilter.selectedMeasure = value ?? 'select a measure';
        break;
      case FilterCriteria.time:
        chartFilter.selectedTime = value ?? 'select a time';
        break;
      default:
    }
    update();
  }
}
