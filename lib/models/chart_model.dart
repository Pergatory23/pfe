import 'package:dashboard/helpers/extensions.dart';
import 'package:dashboard/helpers/helpers.dart';

import 'chart_data.dart';
import 'chart_filter.dart';

enum ChartType { pie, table, line, scatter }

class ChartModel {
  int chartId;
  List<ChartData>? chartsData;
  ChartType? chartType;
  ChartFilter? chartFilter;
  bool isError;

  ChartModel({required this.chartId, required this.chartsData, required this.chartType, required this.chartFilter, this.isError = false});

  ChartModel.error({this.chartId = -1, this.isError = true});

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        chartId: json['chartId'],
        chartsData: (json['chartsData'] as List).map((e) => ChartData.fromJson(e)).toList(),
        chartFilter: ChartFilter.fromJson(json['chartFilter']),
        chartType: Helpers.chartTypeFromString(json['chartType']),
        isError: json['isError'],
      );

  Map<String, dynamic> toJson() => {
        'chartId': chartId,
        'chartsData': chartsData == null ? [] : List<dynamic>.from(chartsData!.map((x) => x.toJson())),
        'chartFilter': chartFilter?.toJson(),
        'chartType': chartType?.stringValue,
        'isError': isError,
      };
}
