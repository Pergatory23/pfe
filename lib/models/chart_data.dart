class ChartData {
  final String batiment;
  final int count;
  final colorPaletteSeries = [
    '#5b8ff9',
    '#5ad8a6',
    '#5e7092',
    '#f6bd18',
    '#6f5efa',
    '#6ec8ec',
    '#945fb9',
    '#ff9845',
    '#299796',
    '#fe99c3',
  ];

  ChartData(this.batiment, this.count);

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
        json['batiment'],
        json['count'],
      );

  Map<String, dynamic> toJson() => {
        'batiment': batiment,
        'count': count,
      };
}
