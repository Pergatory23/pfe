class ChartFilter {
  String selectedMeasure;
  String selectedDimension;
  String selectedSegment;
  String selectedTime;

  ChartFilter({
    this.selectedMeasure = '',
    this.selectedDimension = '',
    this.selectedSegment = '',
    this.selectedTime = '',
  });

  ChartFilter clean() => ChartFilter(
        selectedDimension: selectedDimension == 'select a dimension' ? '' : selectedDimension,
        selectedMeasure: selectedMeasure == 'select a measure' ? '' : selectedMeasure,
        selectedSegment: selectedSegment == 'select a segment' ? '' : selectedSegment,
        selectedTime: selectedTime == 'select a time' ? '' : selectedTime,
      );

  ChartFilter normalizeForDropdown(bool forDropdown) => ChartFilter(
        selectedDimension: selectedDimension.isEmpty ? 'select a dimension' : selectedDimension,
        selectedMeasure: selectedMeasure.isEmpty ? 'select a measure' : selectedMeasure,
        selectedSegment: selectedSegment.isEmpty ? 'select a segment' : selectedSegment,
        selectedTime: selectedTime.isEmpty ? 'select a time' : selectedTime,
      );
}
