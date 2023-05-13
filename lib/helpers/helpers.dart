import 'package:flutter/material.dart';

import '../models/chart_filter.dart';
import '../services/shared_preferences.dart';
import 'constants.dart';

class Helpers {
  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) hexColor = "FF$hexColor";
    return Color(int.parse(hexColor, radix: 16));
  }

  static ChartFilter getSavedUserFilter({bool forDropdown = false}) {
    final sharedPreferences = SharedPreferencesService.find;
    final result = ChartFilter(
      selectedMeasure: sharedPreferences.get(measureKey) ?? 'g_caisse_article.count',
      selectedSegment: sharedPreferences.get(segmentKey) ?? '',
      selectedDimension: sharedPreferences.get(dimensionKey) ?? 'g_caisse_article.batiment',
      selectedTime: sharedPreferences.get(timeKey) ?? '',
    );
    return forDropdown ? result.normalizeForDropdown(forDropdown) : result;
  }

  static void saveUserFilter(ChartFilter chartFilter) {
    final sharedPreferences = SharedPreferencesService.find;
    sharedPreferences.add(measureKey, chartFilter.selectedMeasure);
    sharedPreferences.add(dimensionKey, chartFilter.selectedDimension);
    sharedPreferences.add(segmentKey, chartFilter.selectedSegment);
    sharedPreferences.add(timeKey, chartFilter.selectedTime);
  }
}
