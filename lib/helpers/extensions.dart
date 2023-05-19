import '../models/chart_model.dart';

extension ChartTypeExtension on ChartType {
  String get stringValue {
    switch (this) {
      case ChartType.pie:
        return 'Pie Chart';
      case ChartType.table:
        return 'Table Chart';
      case ChartType.line:
        return 'Line Chart';
      case ChartType.scatter:
        return 'Scatter Chart';
    }
  }
}