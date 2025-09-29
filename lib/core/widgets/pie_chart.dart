import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';

/// A simple data model for each slice of the pie chart.
class PieData {
  final String name;
  final double value;
  final Color color;

  PieData({required this.name, required this.value, required this.color});
}

/// A reusable and customizable pie chart widget using fl_chart.
class CustomPieChart extends StatefulWidget {
  final List<PieData> data;
  const CustomPieChart({super.key, required this.data});

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int touchedIndex = -1; // -1 means no slice is currently being touched

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 20),
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
              borderData: FlBorderData(show: true),
              sectionsSpace: 3, // Space between slices
              centerSpaceRadius: DimensionConstant.horizontalPadding(
                context,
                10,
              ), // Creates the "donut" hole
              sections: showingSections(),
            ),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          ),
        ),
        // --- The Legend (Indicators) ---
        SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: DimensionConstant.horizontalPadding(context, 3),
              vertical: DimensionConstant.horizontalPadding(context, 3),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: DimensionConstant.isMobile(context)
                  ? 2
                  : DimensionConstant.screenWidth(context) < 900
                  ? 3
                  : 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 5, // ปรับความสูง/กว้างของ item
            ),
            itemCount: widget.data.length,
            itemBuilder: (ctx, index) {
              final item = widget.data[index];
              return _Indicator(
                color: item.color,
                text: item.name,
                size: DimensionConstant.responsiveFont(context, 16),
                isSquare: true,
              );
            },
          ),
        ),
      ],
    );
  }

  /// Generates the list of PieChartSectionData from the input data.
  List<PieChartSectionData> showingSections() {
    return List.generate(widget.data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      final dataItem = widget.data[i];

      // Calculate percentage
      final double totalValue = widget.data.fold(
        0,
        (prev, element) => prev + element.value,
      );
      final double percentage = (dataItem.value / totalValue) * 100;

      return PieChartSectionData(
        color: dataItem.color,
        value: dataItem.value,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      );
    });
  }
}

/// A small helper widget to create the legend/indicator items.
class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    // this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  // final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
              borderRadius: isSquare ? BorderRadius.circular(4) : null,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: DimensionConstant.responsiveFont(context, 16),
              fontWeight: FontWeight.normal,
              // color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
