class ChartFilter {
  int index;
  String selectedMeasure;
  String selectedDimension;
  String selectedSegment;
  String selectedTime;

  ChartFilter({
    required this.index,
    this.selectedMeasure = '',
    this.selectedDimension = '',
    this.selectedSegment = '',
    this.selectedTime = '',
  });

      factory ChartFilter.fromJson(Map<String, dynamic> json) => ChartFilter(
        index: json['index'],
        selectedMeasure: json['selectedMeasure'],
        selectedDimension: json['selectedDimension'],
        selectedSegment: json['selectedSegment'],
        selectedTime: json['selectedTime'],
    );

    Map<String, dynamic> toJson() => {
        'index': index,
        'selectedMeasure': selectedMeasure,
        'selectedDimension': selectedDimension,
        'selectedSegment': selectedSegment,
        'selectedTime': selectedTime,
    };

  ChartFilter clean() => ChartFilter(
        index: index,
        selectedDimension: selectedDimension == 'select a dimension' ? '' : selectedDimension,
        selectedMeasure: selectedMeasure == 'select a measure' ? '' : selectedMeasure,
        selectedSegment: selectedSegment == 'select a segment' ? '' : selectedSegment,
        selectedTime: selectedTime == 'select a time' ? '' : selectedTime,
      );

  ChartFilter normalizeForDropdown() => ChartFilter(
        index: index,
        selectedDimension: selectedDimension.isEmpty ? 'select a dimension' : selectedDimension,
        selectedMeasure: selectedMeasure.isEmpty ? 'select a measure' : selectedMeasure,
        selectedSegment: selectedSegment.isEmpty ? 'select a segment' : selectedSegment,
        selectedTime: selectedTime.isEmpty ? 'select a time' : selectedTime,
      );
}
