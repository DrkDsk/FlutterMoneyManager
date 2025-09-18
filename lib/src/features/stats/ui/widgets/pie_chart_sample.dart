import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_money_manager/src/core/colors/category_colors.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';

class PieChartSample extends StatefulWidget {
  final List<StatBreakdown> stats;

  const PieChartSample({super.key, required this.stats});

  @override
  State<PieChartSample> createState() => _PieChartSampleState();
}

class _PieChartSampleState extends State<PieChartSample> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final stats = widget.stats;

    return AspectRatio(
      aspectRatio: 1.5,
      child: Column(
        children: <Widget>[
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                sections: showingSections(stats: stats),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      {required List<StatBreakdown> stats}) {
    if (stats.isEmpty) {
      final isTouched = 0 == touchedIndex;
      final fontSize = isTouched ? 20.0 : 15.0;
      final radius = isTouched ? 90.0 : 70.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 10)];

      return [
        PieChartSectionData(
          color: Colors.grey.shade200,
          value: 100,
          title: '',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        )
      ];
    }

    return List.generate(stats.length, (index) {
      final report = stats[index];
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 20.0 : 15.0;
      final radius = isTouched ? 90.0 : 70.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 10)];

      return PieChartSectionData(
        color: CategoryColors.getCategoryColor(report.source.toLowerCase()),
        value: report.percent,
        title: '${report.percent}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }
}
