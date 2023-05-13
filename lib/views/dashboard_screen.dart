import 'package:dashboard/views/widgets/dashboard_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../controllers/dashboard_controller.dart';
import '../helpers/helpers.dart';
import '../models/chart_data.dart';
import 'filter_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF363567),
          title: const Text('Dashboard'),
        ),
        drawer: const DashboardDrawer(),
        body: GetBuilder<DashboardController>(
          builder: (controller) => controller.chartData.isEmpty || controller.isFetchError
              ? controller.isFetchError
                  ? const Center(child: Text('An error has been occured with this provided filtering data'))
                  : const Center(child: CircularProgressIndicator())
              : ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(10),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        _BuildPieChartData(chartData: controller.chartData),
                        _BuildTableData(chartData: controller.chartData),
                        _BuildLineChartData(chartData: controller.chartData),
                        _BuildScatterChartData(chartData: controller.chartData),
                      ],
                    ),
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(FilterScreen.routeName),
          backgroundColor: const Color(0xFF373856),
          child: const Icon(Icons.filter_alt),
        ),
      );
}

class _BuildPieChartData extends StatelessWidget {
  final List<ChartData> chartData;
  const _BuildPieChartData({required this.chartData});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0x44686799),
        ),
        child: PieChart(
          PieChartData(
            sections: chartData
                .map(
                  (data) => PieChartSectionData(
                    title: data.batiment.trim(),
                    radius: 80,
                    badgeWidget: Container(padding: const EdgeInsets.only(bottom: 30), child: Text(data.count.toString())),
                    color: Helpers.getColorFromHex(data.colorPaletteSeries[chartData.indexOf(data)]),
                  ),
                )
                .toList(),
            borderData: FlBorderData(show: false),
            sectionsSpace: 1,
            centerSpaceRadius: 30,
            startDegreeOffset: 120,
            centerSpaceColor: Colors.transparent,
            pieTouchData: PieTouchData(),
          ),
        ),
      );
}

class _BuildTableData extends StatelessWidget {
  final List<ChartData> chartData;
  const _BuildTableData({required this.chartData});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0x44686799),
        ),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Count')),
                ],
                rows: chartData
                    .map((data) => DataRow(cells: [
                          DataCell(Text(data.batiment)),
                          DataCell(Text(data.count.toString())),
                        ]))
                    .toList(),
              ),
            ),
          ),
        ),
      );
}

class _BuildLineChartData extends StatelessWidget {
  final List<ChartData> chartData;
  const _BuildLineChartData({required this.chartData});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0x44686799),
        ),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(tooltipBgColor: Colors.blueGrey.withOpacity(0.8)),
              handleBuiltInTouches: true,
            ),
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (double value) => value % 10 == 0,
              getDrawingHorizontalLine: (double value) => FlLine(color: Colors.grey, strokeWidth: 0.5),
              drawVerticalLine: true,
              horizontalInterval: 10,
            ),
            titlesData: FlTitlesData(),
            borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey)),
            lineBarsData: [
              LineChartBarData(
                spots: chartData.asMap().map((index, data) => MapEntry(index, FlSpot(index.toDouble(), data.count.toDouble()))).values.toList(),
                isCurved: true,
                color: Colors.blue,
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (FlSpot spot, double percent, LineChartBarData bar, int index) => FlDotCirclePainter(radius: 4, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      );
}

class _BuildScatterChartData extends StatelessWidget {
  final List<ChartData> chartData;
  const _BuildScatterChartData({required this.chartData});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0x44686799),
        ),
        child: ScatterChart(
          ScatterChartData(
            scatterSpots: chartData
                .map(
                  (data) => ScatterSpot(
                    data.count.toDouble(),
                    chartData.indexOf(data).toDouble(),
                    color: Helpers.getColorFromHex(data.colorPaletteSeries[chartData.indexOf(data)]),
                  ),
                )
                .toList(),
            minX: 0,
            maxX: chartData.length.toDouble() - 1,
            minY: 0,
            maxY: chartData.length.toDouble() - 1,
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(),
          ),
        ),
      );
}
