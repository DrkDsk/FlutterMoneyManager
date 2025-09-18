import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/colors/category_colors.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_bloc.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_state.dart';

class PieChartSample extends StatefulWidget {
  const PieChartSample({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSampleState();
}

class PieChartSampleState extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: BlocSelector<StatsBloc, StatsState, List<StatBreakdown>>(
        selector: (state) {
          return state.data.reports;
        },
        builder: (context, reports) {
          return Column(
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
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 50,
                    sections: showingSections(data: reports),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      {required List<StatBreakdown> data}) {
    return List.generate(data.length, (index) {
      final report = data[index];
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
