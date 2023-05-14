import 'package:dashboard/helpers/colors.dart';
import 'package:dashboard/helpers/extensions.dart';
import 'package:dashboard/views/widgets/on_hover.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/filter_controller.dart';
import '../helpers/helpers.dart';

class FilterScreen extends StatelessWidget {
  static const routeName = '/filter';
  final int? id;

  const FilterScreen({super.key, this.id});

  @override
  Widget build(BuildContext context) => GetBuilder<FilterController>(
        initState: (state) => FilterController.find.fetchEditableChart(id),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: const Text('Filtrer'),
            ),
            backgroundColor: primaryColor,
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
                          colors: [secondaryLighterColor, secondaryColor],
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
                              title: 'Chart Type',
                              options: controller.chartOptions,
                              value: controller.chartType.stringValue,
                              onChanged: (value) => controller.chartType = Helpers.chartTypeFromString(value),
                            ),
                            const SizedBox(height: 20),
                            _buildDropdownRow(
                              title: 'Measures',
                              options: controller.measureOptions,
                              value: controller.chartFilter.selectedMeasure,
                              onChanged: (value) => controller.updateFilter(FilterCriteria.measure, value),
                            ),
                            const SizedBox(height: 20),
                            _buildDropdownRow(
                              title: 'Dimensions',
                              options: controller.dimensionOptions,
                              value: controller.chartFilter.selectedDimension,
                              onChanged: (value) => controller.updateFilter(FilterCriteria.dimension, value),
                            ),
                            const SizedBox(height: 20),
                            _buildDropdownRow(
                              title: 'Segments',
                              options: controller.segmentOptions,
                              value: controller.chartFilter.selectedSegment,
                              onChanged: (value) => controller.updateFilter(FilterCriteria.segment, value),
                            ),
                            const SizedBox(height: 20),
                            _buildDropdownRow(
                              title: 'Time',
                              options: controller.timeOptions,
                              value: controller.chartFilter.selectedTime,
                              onChanged: (value) => controller.updateFilter(FilterCriteria.time, value),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () => controller.upsertChart(id),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, minimumSize: Size(constraints.maxWidth, 50)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  id != null ? 'Update Chart' : 'Add Chart',
                                  style: const TextStyle(color: primaryColor),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (id != null) ...[
                              TextButton(
                                onPressed: () => controller.deleteChart(id),
                                child: Text(
                                  'Delete this Chart',
                                  style: TextStyle(color: Colors.red[800], fontSize: 14),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ]
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
    double maxHeight = options.length * 50;
    if (maxHeight > 300) maxHeight = 300;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white),
        ),
        const SizedBox(height: 5),
        DropdownSearch<String>(
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            itemBuilder: (context, item, isSelected) => OnHover(
              builder: (isHovered) => Container(
                color: isHovered ? Colors.white.withAlpha(50) : null,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  item,
                  style: TextStyle(fontSize: 16, height: 1.2, color: isSelected ? secondaryColor : Colors.white),
                ),
              ),
            ),
            menuProps: MenuProps(
              textStyle: const TextStyle(color: Colors.white),
              backgroundColor: primaryLighterColor,
              constraints: BoxConstraints(maxHeight: maxHeight),
            ),
            textStyle: const TextStyle(color: Colors.white),
            showSearchBox: options.length > 10,
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                hintText: 'Search for something',
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          dropdownSearchTextStyle: const TextStyle(color: Colors.white),
          items: options,
          enabled: true,
          onChanged: onChanged,
          selectedItem: value,
        ),
      ],
    );
  }
}
