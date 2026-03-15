import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:adm_panel_v2/design/app_colors.dart';
import 'package:adm_panel_v2/design/app_text_styles.dart';
import 'package:adm_panel_v2/components/app_card.dart';
import 'package:adm_panel_v2/models/admin/dashboard_stats.dart';

/// Компонент графика для Dashboard
class AppChart extends StatelessWidget {
  final ChartData chartData;
  final double height;
  final bool showGrid;
  final Color? lineColor;
  final Color? fillColor;

  const AppChart({
    super.key,
    required this.chartData,
    this.height = 200,
    this.showGrid = true,
    this.lineColor,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = chartData.dataPoints.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final minValue = chartData.dataPoints.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue;
    final padding = range * 0.2; // Добавляем 20% отступ сверху и снизу

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chartData.title,
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: height,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: showGrid,
                  drawVerticalLine: false,
                  horizontalInterval: (maxValue + padding - (minValue - padding)) / 4,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.border,
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < chartData.dataPoints.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              chartData.dataPoints[index].label,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          _formatValue(value),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: AppColors.border),
                ),
                minX: 0,
                maxX: (chartData.dataPoints.length - 1).toDouble(),
                minY: minValue - padding,
                maxY: maxValue + padding,
                lineBarsData: [
                  LineChartBarData(
                    spots: chartData.dataPoints.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.value);
                    }).toList(),
                    isCurved: true,
                    color: lineColor ?? AppColors.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: (fillColor ?? AppColors.primary).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatValue(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return value.toStringAsFixed(0);
  }
}

