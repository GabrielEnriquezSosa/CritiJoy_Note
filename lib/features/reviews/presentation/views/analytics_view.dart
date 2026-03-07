import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../shared/core/theme/theme_provider.dart';
import '../../domain/models/analytics_data.dart';
import '../providers/analytics_provider.dart';

class AnalyticsView extends ConsumerWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final analyticsAsyncValue = ref.watch(analyticsProvider);

    final backgroundColor =
        isDarkMode ? const Color(0xFF0F1522) : const Color(0xFFF5F7FA);
    final textColor = isDarkMode ? Colors.white : const Color(0xFF2C3E50);
    final cardColor = isDarkMode ? const Color(0xFF111827) : Colors.white;
    final cyanColor = const Color(0xFF00E5FF);
    final magentaColor = const Color(0xFFD500F9);
    final yellowColor = const Color(0xFFFFEA00);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        title: Text(
          'Estadísticas',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: analyticsAsyncValue.when(
        data: (data) {
          if (data.totalReviewsThisYear == 0 &&
              data.reviewsPerMonth.isEmpty &&
              data.topGenres.isEmpty) {
            return Center(
              child: Text(
                'Aún no hay reseñas registradas.',
                style: TextStyle(color: textColor.withValues(alpha: 0.5)),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Line Chart Activity
                Text(
                  'Actividad de reseñas',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildActivityChart(
                  context,
                  data,
                  cardColor,
                  textColor,
                  cyanColor,
                  isDarkMode,
                ),
                const SizedBox(height: 24),

                // 2. Insights Layer (Donuts)
                Text(
                  'Información',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInsightsSection(
                  context,
                  data,
                  cardColor,
                  textColor,
                  cyanColor,
                  magentaColor,
                  yellowColor,
                  isDarkMode,
                ),
                const SizedBox(height: 24),

                // 3. Top Platforms Ranking
                Text(
                  'Top Plataformas',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTopPlatforms(
                  context,
                  data,
                  cardColor,
                  textColor,
                  cyanColor,
                  isDarkMode,
                ),
              ],
            ),
          );
        },
        loading:
            () => Center(child: CircularProgressIndicator(color: cyanColor)),
        error:
            (error, stackTrace) => Center(
              child: Text(
                'Error al cargar estadísticas',
                style: TextStyle(color: textColor),
              ),
            ),
      ),
    );
  }

  Widget _buildActivityChart(
    BuildContext context,
    AnalyticsData data,
    Color cardColor,
    Color textColor,
    Color primaryColor,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total de reseñas este año',
            style: TextStyle(
              color: textColor.withValues(alpha: 0.6),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${data.totalReviewsThisYear}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
              if (data.percentageIncrease > 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    children: [
                      Icon(Icons.trending_up, color: primaryColor, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '+${data.percentageIncrease}% vs el año pasado',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 160,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final style = TextStyle(
                          color: textColor.withValues(alpha: 0.5),
                          fontSize: 12,
                        );
                        Widget text;
                        switch (value.toInt()) {
                          case 1:
                            text = Text('Ene', style: style);
                            break;
                          case 2:
                            text = Text('Feb', style: style);
                            break;
                          case 3:
                            text = Text('Mar', style: style);
                            break;
                          case 4:
                            text = Text('Abr', style: style);
                            break;
                          case 5:
                            text = Text('May', style: style);
                            break;
                          case 6:
                            text = Text('Jun', style: style);
                            break;
                          default:
                            text = Text('', style: style);
                            break;
                        }
                        return SideTitleWidget(
                          meta: meta,
                          space: 4,
                          child: text,
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 1,
                maxX: 6, // Mockup shows up to Jun
                minY: 0,
                maxY:
                    (data.reviewsPerMonth.values.isEmpty
                        ? 10
                        : data.reviewsPerMonth.values
                                .reduce((a, b) => a > b ? a : b)
                                .toDouble() *
                            1.5),
                lineBarsData: [
                  LineChartBarData(
                    spots:
                        data.reviewsPerMonth.entries
                            .map(
                              (e) =>
                                  FlSpot(e.key.toDouble(), e.value.toDouble()),
                            )
                            .toList(),
                    isCurved: true,
                    color: primaryColor,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsSection(
    BuildContext context,
    AnalyticsData data,
    Color cardColor,
    Color textColor,
    Color cyanColor,
    Color magentaColor,
    Color yellowColor,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Expanded(
          child: _DonutChartCard(
            title: 'Top Géneros',
            dataMap: data.topGenres,
            cardColor: cardColor,
            textColor: textColor,
            colors: [
              cyanColor,
              magentaColor,
              yellowColor,
              const Color(0xFF4CAF50),
              const Color(0xFFFF5722),
            ],
            totalCount: data.topGenres.values.fold(0, (sum, val) => sum + val),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _DonutChartCard(
            title: 'Top Formatos',
            dataMap: data.topFormats,
            cardColor: cardColor,
            textColor: textColor,
            colors: [
              magentaColor,
              cyanColor,
              yellowColor,
              const Color(0xFF9C27B0),
              const Color(0xFF03A9F4),
            ],
            totalCount: data.topFormats.values.fold(0, (sum, val) => sum + val),
          ),
        ),
      ],
    );
  }

  Widget _buildTopPlatforms(
    BuildContext context,
    AnalyticsData data,
    Color cardColor,
    Color textColor,
    Color cyanColor,
    bool isDarkMode,
  ) {
    if (data.topPlatforms.isEmpty) return const SizedBox.shrink();

    Color getPlatformColor(String name) {
      final n = name.toLowerCase();
      if (n.contains('netflix')) return const Color.fromARGB(255, 187, 1, 1);
      if (n.contains('crunchyroll')) return const Color(0xFF9E9D24);
      if (n.contains('prime video')) {
        return const Color.fromARGB(255, 0, 102, 255);
      }
      if (n.contains('disney plus')) {
        return const Color.fromARGB(255, 0, 225, 255);
      }
      if (n.contains('hbo max')) return const Color.fromARGB(255, 0, 26, 255);
      if (n.contains('apple tv')) {
        return const Color.fromARGB(255, 255, 255, 255);
      }
      if (n.contains('paramount plus')) return const Color(0xFF00B0FF);
      if (n.contains('peacock')) return const Color(0xFF00B0FF);
      if (n.contains('hulu')) return const Color(0xFF00B0FF);
      if (n.contains('youtube')) return const Color.fromARGB(255, 255, 0, 0);
      if (n.contains('vix')) return const Color.fromARGB(255, 255, 89, 0);

      return const Color(0xFF607D8B);
    }

    IconData getPlatformIcon(String name) {
      final n = name.toLowerCase();
      if (n.contains('netflix')) return Icons.play_circle_fill;
      if (n.contains('crunchyroll')) return Icons.animation;
      if (n.contains('prime video')) return Icons.movie;
      if (n.contains('disney plus')) return Icons.movie;
      if (n.contains('hbo max')) return Icons.movie;
      if (n.contains('apple tv')) return Icons.movie;
      if (n.contains('paramount plus')) return Icons.movie;
      if (n.contains('peacock')) return Icons.movie;
      if (n.contains('hulu')) return Icons.movie;
      if (n.contains('youtube')) return Icons.movie;
      if (n.contains('vix')) return Icons.movie;
      return Icons.smart_display;
    }

    return Column(
      children:
          data.topPlatforms.asMap().entries.map((entry) {
            int index = entry.key;
            MapEntry<String, int> platform = entry.value;
            final pColor = getPlatformColor(platform.key);

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: pColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        getPlatformIcon(platform.key),
                        color: pColor,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          platform.key,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${platform.value} ${platform.value == 1 ? 'Reseña' : 'Reseñas'}',
                          style: TextStyle(
                            color: textColor.withValues(alpha: 0.5),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '#${index + 1}',
                    style: TextStyle(
                      color: isDarkMode ? cyanColor : Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}

class _DonutChartCard extends StatelessWidget {
  final String title;
  final Map<String, int> dataMap;
  final Color cardColor;
  final Color textColor;
  final List<Color> colors;
  final int totalCount;

  const _DonutChartCard({
    required this.title,
    required this.dataMap,
    required this.cardColor,
    required this.textColor,
    required this.colors,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    if (dataMap.isEmpty) return const SizedBox.shrink();

    List<PieChartSectionData> sections = [];
    int i = 0;

    for (var entry in dataMap.entries) {
      final color = colors[i % colors.length];
      sections.add(
        PieChartSectionData(
          color: color,
          value: entry.value.toDouble(),
          title: '', // We hide titles inside the chart, matching the mockup
          radius: 8, // Thin stroke
        ),
      );
      i++;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.9),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 100,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: sections,
                startDegreeOffset: 270,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Legend
          ...dataMap.entries.map((entry) {
            int idx = dataMap.keys.toList().indexOf(entry.key);
            final c = colors[idx % colors.length];
            final percentage =
                totalCount > 0 ? (entry.value / totalCount * 100).round() : 0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: c),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        color: textColor.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
