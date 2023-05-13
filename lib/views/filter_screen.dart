import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/filter_controller.dart';

class FilterScreen extends StatelessWidget {
  static const routeName = '/filter';

  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<FilterController>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF363567),
              title: const Text('Filtrer'),
            ),
            backgroundColor: const Color(0xFF363567),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Transform.rotate(
                    angle: 1.8,
                    origin: const Offset(20, 40),
                    child: Container(
                      margin: const EdgeInsets.only(left: 50, top: 30),
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          colors: [Color(0xffFD8BAB), Color(0xFFFD44C4)],
                        ),
                      ),
                    ),
                  ),
                  LayoutBuilder(
                    builder: (_, constraints) => SingleChildScrollView(
                      child: SizedBox(
                        height: constraints.maxHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildDropdownRow(
                              title: 'MEASURES',
                              options: controller.measureOptions,
                              value: controller.chartFilter.selectedMeasure,
                              onChanged: (value) => controller.updateFilter(FilterCriteria.measure, value),
                            ),
                            const SizedBox(height: 20),
                            _buildDropdownRow(
                              title: 'DIMENSIONS',
                              options: controller.dimensionOptions,
                              value: controller.chartFilter.selectedDimension,
                              onChanged: (value) => controller.updateFilter(FilterCriteria.dimension, value),
                            ),
                            const SizedBox(height: 20),
                            _buildDropdownRow(
                              title: 'SEGMENT',
                              options: controller.segmentOptions,
                              value: controller.chartFilter.selectedSegment,
                              onChanged: (value) => controller.updateFilter(FilterCriteria.segment, value),
                            ),
                            const SizedBox(height: 20),
                            _buildDropdownRow(
                              title: 'TIME',
                              options: controller.timeOptions,
                              value: controller.chartFilter.selectedTime,
                              onChanged: (value) => controller.updateFilter(FilterCriteria.time, value),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: controller.filterData,
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, minimumSize: Size(constraints.maxWidth, 50)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Apply Filters',
                                  style: TextStyle(color: Color(0xFF363567)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  Widget _buildDropdownRow({required List<String> options, required String title, String? value, void Function(String?)? onChanged}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white),
        ),
        DropdownButton<String?>(
          key: GlobalKey(),
          items: options.map((option) {
            return DropdownMenuItem<String?>(
              value: option,
              child: Text(option, style: TextStyle(color: Colors.grey[300])),
            );
          }).toList(),
          value: value,
          menuMaxHeight: 300,
          dropdownColor: const Color(0xFF686799),
          isExpanded: true,
          underline: Container(height: 1, color: Colors.grey[400]),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
