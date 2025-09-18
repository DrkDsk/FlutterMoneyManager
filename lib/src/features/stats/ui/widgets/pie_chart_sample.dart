import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/colors/category_colors.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_bloc.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_state.dart';
import 'indicator.dart';

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
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.customOpacity(0.5),
                  offset: const Offset(0, 3),
                  blurRadius: 0.1)
            ],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.turquoise.customOpacity(0.8))),
        child: BlocSelector<StatsBloc, StatsState, List<StatBreakdown>>(
          selector: (state) {
            return state.data.reports;
          },
          builder: (context, reports) {
            return Row(
              children: <Widget>[
                const SizedBox(
                  height: 18,
                ),
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
                      centerSpaceRadius: 40,
                      sections: showingSections(data: reports),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...reports.map((report) {
                      final source = report.source;

                      return Indicator(
                          color: CategoryColors.getCategoryColor(
                              source.toLowerCase()),
                          text: source,
                          isSquare: true);
                    })
                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      {required List<StatBreakdown> data}) {
    return List.generate(data.length, (index) {
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final report = data[index];

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
