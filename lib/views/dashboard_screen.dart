import 'package:dashboard/helpers/colors.dart';
import 'package:dashboard/views/widgets/dashboard_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../controllers/dashboard_controller.dart';
import '../helpers/helpers.dart';
import '../models/chart_data.dart';
import '../models/chart_model.dart';
import 'filter_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Dashboard'),
        ),
        drawer: const DashboardDrawer(),
        body: GetBuilder<DashboardController>(
          builder: (controller) => Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      child: GridView.count(
                        crossAxisCount: GetPlatform.isMobile ? 1 : 2,
                        padding: const EdgeInsets.all(10),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: controller.chartModels.isNotEmpty
                            ? List.generate(
                                controller.chartModels.length,
                                (index) => _resolveChartType(controller.chartModels[index]),
                              ).followedBy(
                                [_BuildAddChartButton(() => Get.toNamed(FilterScreen.routeName))],
                              ).toList()
                            : [_BuildAddChartButton(() => Get.toNamed(FilterScreen.routeName))],
                      ),
                    ),
                  ),
          ),
        ),
      );

  Widget _resolveChartType(ChartModel chartModel) {
    Widget result;
    if (chartModel.isError) {
      result = const _BuildErrorChartInfo();
    } else {
      switch (chartModel.chartType) {
        case ChartType.table:
          result = _BuildTableChartData(chartData: chartModel.chartsData ?? []);
          break;
        case ChartType.line:
          result = _BuildLineChartData(chartData: chartModel.chartsData ?? []);
          break;
        case ChartType.scatter:
          result = _BuildScatterChartData(chartData: chartModel.chartsData ?? []);
          break;
        default: // case ChartType.pie:
          result = _BuildPieChartData(chartData: chartModel.chartsData ?? []);
          break;
      }
    }
    // Wrap with InkWell for editing the chart
    return InkWell(
      onTap: () => Get.toNamed(FilterScreen.routeName, arguments: chartModel.chartId),
      radius: 20,
      child: result,
    );
  }
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
          color: primaryLighterColor.withAlpha(50),
        ),
        child: PieChart(
          PieChartData(
            sections: chartData
                .map(
                  (data) => PieChartSectionData(
                    title: data.batiment.trim(),
                    radius: GetPlatform.isMobile ? 120 : 80,
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

class _BuildTableChartData extends StatelessWidget {
  final List<ChartData> chartData;
  const _BuildTableChartData({required this.chartData});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryLighterColor.withAlpha(50),
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
          color: primaryLighterColor.withAlpha(50),
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
          color: primaryLighterColor.withAlpha(50),
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

class _BuildAddChartButton extends StatelessWidget {
  final Function() onAdd;
  const _BuildAddChartButton(this.onAdd);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryLighterColor.withAlpha(50),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: onAdd,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, minimumSize: const Size(200, 50)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Add Chart',
                style: TextStyle(color: primaryColor),
              ),
            ),
          ),
        ));
  }
}

class _BuildErrorChartInfo extends StatelessWidget {
  const _BuildErrorChartInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryLighterColor.withAlpha(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SizedBox(height: 0),
          Text(
            'An error has been occured with this provided filtering data!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Tap this container for editing',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
