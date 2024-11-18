import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  const ChartCard(
      {super.key,
      required this.firstAccuracies,
      required this.secondAccuracies});

  final List<int> firstAccuracies;
  final List<int> secondAccuracies;

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.only(
          left: 10,
          top: 80,
          right: 10,
          bottom: 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => const Color(0xff4C6ED7),
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return [
                      LineTooltipItem(
                        "一次正确率${touchedBarSpots[0].y}%",
                        const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      LineTooltipItem(
                        "二次正确率${touchedBarSpots[1].y}%",
                        const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ];
                  },
                ),
              ),
              gridData: const FlGridData(drawVerticalLine: false),
              maxY: 100,
              minX: 1,
              maxX: firstAccuracies.length.toDouble() + 1,
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  axisNameWidget: const Text("准确率(%)"),
                  sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toString(),
                          style: const TextStyle(
                            color: Color(0xff4f4f4f),
                            fontSize: 12,
                          ),
                        );
                      }),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: const Text("课堂"),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                            color: Color(0xff4f4f4f), fontSize: 12),
                      );
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                    spots: firstAccuracies
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble() + 1, e.value.toDouble()))
                        .toList(),
                    color: const Color(0xff4C6ED7)
                    // color: Colors.black,
                    ),
                LineChartBarData(
                    spots: secondAccuracies
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble() + 1, e.value.toDouble()))
                        .toList(),
                    color: const Color(0xff08AF18)),
              ],
            ),
          ),
        ));
  }
}
