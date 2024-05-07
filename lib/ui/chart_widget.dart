import 'dart:math';

import 'package:dio/dio.dart';
import 'package:eurovision_app/core/app_core.dart';
import 'package:eurovision_app/core/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatefulWidget {
  final int id;
  final Map<String, int>? pointList;
  const ChartWidget({
    super.key,
    this.pointList,
    required this.id,
  });

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  List<BarChartGroupData> _getList() {
    List<BarChartGroupData> result = [];
    widget.pointList!.forEach((key, value) {
      result.add(
        BarChartGroupData(
          x: int.parse(key),
          barRods: [
            BarChartRodData(
              toY: value.toDouble(),
              color:
                  ApplicationCore().authBloc.getPointsForCountry(widget.id) ==
                          int.parse(key)
                      ? euroPink
                      : euroBlue,
            ),
          ],
        ),
      );
    });
    return result;
  }

  double _getMaxValue() {
    double result = 0;
    widget.pointList!.forEach((key, value) {
      result = max(result, value.toDouble());
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return widget.pointList != null
        ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                height: 300,
                child: BarChart(
                  BarChartData(
                    maxY: max(5, _getMaxValue()),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    barGroups: _getList(),
                    titlesData: FlTitlesData(
                      rightTitles: AxisTitles(axisNameWidget: Container()),
                      topTitles: AxisTitles(axisNameWidget: Container()),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(interval: 1, showTitles: true),
                      ),
                    ),
                  ),
                  swapAnimationDuration:
                      Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                ),
              ),
            ),
          )
        : Container();
  }
}
